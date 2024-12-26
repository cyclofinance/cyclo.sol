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
import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID, ETH_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {IPriceOracleV2} from "ethgild/abstract/PriceOracleV2.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";

// 30 mins.
uint256 constant DEFAULT_STALE_AFTER = 1800;

bytes32 constant DEPLOYMENT_SUITE_IMPLEMENTATIONS = keccak256("implementations");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT = keccak256("sceptre-staked-flare-price-vault");
bytes32 constant DEPLOYMENT_SUITE_WETH_PRICE_VAULT = keccak256("weth-price-vault");

address constant FLARE_CLONE_FACTORY_V1 = 0x67fe33484cAF1a8D716b84b779569f79881788Ae;

address constant FLARE_VAULT_IMPLEMENTATION_V1 = 0x35ea13bBEfF8115fb63E4164237922E491dd21BC;

address constant STARGATE_WETH_CONTRACT = 0x1502FA4be69d526124D453619276FacCab275d3D;

string constant STARGATE_WETH_VAULT_NAME = "Cyclo WETH (cyWETH)";

string constant STARGATE_WETH_VAULT_SYMBOL = "cyWETH";

/// @title Deploy
/// This is intended to be run on every commit by CI to a testnet such as mumbai,
/// then cross chain deployed to whatever mainnet is required, by users.
contract Deploy is Script {
    function deployImplementations(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();

        CloneFactory cloneFactory = new CloneFactory();

        ReceiptVaultConstructionConfig memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfig({
            factory: ICloneableFactoryV2(cloneFactory),
            receiptImplementation: cycloReceipt
        });
        new ERC20PriceOracleReceiptVault(receiptVaultConstructionConfig);

        vm.stopBroadcast();
    }

    function deployStakedFlrPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: FLR_USD_FEED_ID, staleAfter: DEFAULT_STALE_AFTER})
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
                        name: vm.envString("RECEIPT_VAULT_NAME"),
                        symbol: vm.envString("RECEIPT_VAULT_SYMBOL")
                    })
                })
            )
        );
        vm.stopBroadcast();
    }

    function deployStargateWethPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: ETH_USD_FEED_ID, staleAfter: DEFAULT_STALE_AFTER})
        );

        ICloneableFactoryV2(FLARE_CLONE_FACTORY_V1).clone(
            FLARE_VAULT_IMPLEMENTATION_V1,
            abi.encode(
                ERC20PriceOracleVaultConfig({
                    priceOracle: ftsoV2LTSFeedOracle,
                    vaultConfig: VaultConfig({
                        asset: STARGATE_WETH_CONTRACT,
                        name: STARGATE_WETH_VAULT_NAME,
                        symbol: STARGATE_WETH_VAULT_SYMBOL
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
        } else if (suite == DEPLOYMENT_SUITE_STARGATE_WETH_PRICE_VAULT) {
            deployStargateWethPriceVault(deployerPrivateKey);
        } else {
            revert("Unknown deployment suite");
        }
    }
}
