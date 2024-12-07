// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    ERC20PriceOracleReceiptVault,
    ERC20PriceOracleVaultConfig,
    ReceiptVaultConstructionConfig,
    VaultConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {IPriceOracleV2} from "ethgild/abstract/PriceOracleV2.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";

bytes32 constant DEPLOYMENT_SUITE_IMPLEMENTATIONS = keccak256("implementations");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT = keccak256("sceptre-staked-flare-price-vault");

/// @title Deploy
/// This is intended to be run on every commit by CI to a testnet such as mumbai,
/// then cross chain deployed to whatever mainnet is required, by users.
contract Deploy is Script {
    function deployImplementations(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();

        ReceiptVaultConstructionConfig memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfig({
            factory: ICloneableFactoryV2(vm.envAddress("CLONE_FACTORY")),
            receiptImplementation: cycloReceipt
        });
        new ERC20PriceOracleReceiptVault(receiptVaultConstructionConfig);

        vm.stopBroadcast();
    }

    function deployStakedFlrPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({
                feedId: FLR_USD_FEED_ID,
                // 30 mins.
                staleAfter: 1800
            })
        );

        IPriceOracleV2 stakedFlrOracle = new SceptreStakedFlrOracle();
        IPriceOracleV2 twoPriceOracle =
            new TwoPriceOracleV2(TwoPriceOracleConfigV2({base: ftsoV2LTSFeedOracle, quote: stakedFlrOracle}));

        ICloneableFactoryV2(vm.envAddress("CLONE_FACTORY")).clone(
            vm.envAddress("ERC20_PRICE_ORACLE_VAULT_IMPLEMENTATION"),
            abi.encode(
                ERC20PriceOracleVaultConfig({
                    priceOracle: twoPriceOracle,
                    vaultConfig: VaultConfig({
                        asset: address(SFLR_CONTRACT),
                        receiptOwner: vm.envAddress("RECEIPT_VAULT_RECEIPT_OWNER"),
                        name: vm.envString("RECEIPT_VAULT_NAME"),
                        symbol: vm.envString("RECEIPT_VAULT_SYMBOL")
                    })
                })
            )
        );
        vm.stopBroadcast();
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        bytes32 suite = keccak256(bytes(vm.envString("DEPLOYMENT_SUITE")));

        if (suite == DEPLOYMENT_SUITE_IMPLEMENTATIONS) {
            deployImplementations(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT) {
            deployStakedFlrPriceVault(deployerPrivateKey);
        } else {
            revert("Unknown deployment suite");
        }
    }
}
