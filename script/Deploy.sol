// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script, console2} from "forge-std/Script.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    ERC20PriceOracleReceiptVault,
    ERC20PriceOracleVaultConfig,
    ReceiptVaultConstructionConfig,
    VaultConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {IReceiptV2} from "ethgild/abstract/ReceiptVault.sol";
import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID, ETH_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {IPriceOracleV2} from "ethgild/abstract/PriceOracleV2.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_LATEST,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_LATEST
} from "src/lib/LibCycloProdCloneFactory.sol";
import {CycloVault, CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";
import {FLARE_STARGATE_WETH} from "src/lib/LibCycloProdAssets.sol";
import {
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_LATEST,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_LATEST
} from "src/lib/LibCycloProdReceipt.sol";
import {PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH} from "src/lib/LibCycloProdOracle.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

// 30 mins.
uint256 constant DEFAULT_STALE_AFTER = 1800;

bytes32 constant DEPLOYMENT_SUITE_FACTORY = keccak256("factory");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION = keccak256("cyclo-receipt-implementation");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION = keccak256("cyclo-vault-implementation");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT = keccak256("sceptre-staked-flare-price-vault");
bytes32 constant DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_ETH_USD = keccak256("ftso-v2-lts-feed-oracle-eth-usd");
bytes32 constant DEPLOYMENT_SUITE_STARGATE_WETH_PRICE_VAULT = keccak256("stargate-weth-price-vault");

/// @title Deploy
/// This is intended to be run on every commit by CI to a testnet such as mumbai,
/// then cross chain deployed to whatever mainnet is required, by users.
contract Deploy is Script {
    function deployFactory(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ICloneableFactoryV2 cloneFactory = new CloneFactory();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cloneFactory), PROD_FLARE_CLONE_FACTORY_CODEHASH_LATEST);

        vm.stopBroadcast();
    }

    function deployCycloReceiptImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cycloReceipt), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_LATEST);

        vm.stopBroadcast();
    }

    function deployCycloVaultImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ReceiptVaultConstructionConfig memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfig({
            factory: ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_LATEST),
            receiptImplementation: IReceiptV2(PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_LATEST)
        });
        CycloVault cycloVault = new CycloVault(receiptVaultConstructionConfig);
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(cycloVault), PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployStakedFlrPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        IPriceOracleV2 stakedFlrOracle = new SceptreStakedFlrOracle();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(stakedFlrOracle), PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );

        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: FLR_USD_FEED_ID, staleAfter: DEFAULT_STALE_AFTER})
        );

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

    function deployFTSOV2LTSFeedOracleETHUSD(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: ETH_USD_FEED_ID, staleAfter: DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            ftsoV2LTSFeedOracle, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH
        );
        vm.stopBroadcast();
    }

    function deployStargateWethPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_LATEST).clone(
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
            abi.encode(
                CycloVaultConfig({priceOracle: PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE, asset: FLARE_STARGATE_WETH})
            )
        );
        vm.stopBroadcast();
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        bytes32 suite = keccak256(bytes(vm.envString("DEPLOYMENT_SUITE")));

        if (suite == DEPLOYMENT_SUITE_FACTORY) {
            deployFactory(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION) {
            deployCycloReceiptImplementation(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION) {
            deployCycloVaultImplementation(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT) {
            deployStakedFlrPriceVault(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_ETH_USD) {
            deployFTSOV2LTSFeedOracleETHUSD(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STARGATE_WETH_PRICE_VAULT) {
            deployStargateWethPriceVault(deployerPrivateKey);
        } else {
            revert("Unknown deployment suite");
        }
    }
}
