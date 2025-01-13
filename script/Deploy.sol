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
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V1
} from "src/lib/LibCycloProdCloneFactory.sol";
import {CycloVault, CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";
import {FLARE_STARGATE_WETH} from "src/lib/LibCycloProdAssets.sol";
import {
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_ORACLE_DEFAULT_STALE_AFTER,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE
} from "src/lib/LibCycloProdOracle.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

bytes32 constant DEPLOYMENT_SUITE_FACTORY = keccak256("factory");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION = keccak256("cyclo-receipt-implementation");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION = keccak256("cyclo-vault-implementation");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_1 = keccak256("sceptre-staked-flare-oracle-1");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_2 = keccak256("sceptre-staked-flare-oracle-2");
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
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cloneFactory), PROD_FLARE_CLONE_FACTORY_CODEHASH_V1);

        vm.stopBroadcast();
    }

    function deployCycloReceiptImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cycloReceipt), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1);

        vm.stopBroadcast();
    }

    function deployCycloVaultImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ReceiptVaultConstructionConfig memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfig({
            factory: ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1),
            receiptImplementation: IReceiptV2(PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1)
        });
        CycloVault cycloVault = new CycloVault(receiptVaultConstructionConfig);
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(cycloVault), PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployStakedFlrOracles1(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        IPriceOracleV2 stakedFlrOracle = new SceptreStakedFlrOracle();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(stakedFlrOracle), PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );

        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: FLR_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(ftsoV2LTSFeedOracle), PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployStakedFlrOracles2(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        IPriceOracleV2 twoPriceOracle = new TwoPriceOracleV2(
            TwoPriceOracleConfigV2({
                base: IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE)),
                quote: IPriceOracleV2(payable(PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE))
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(twoPriceOracle), PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployStakedFlrPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cysflr = ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
            abi.encode(
                ERC20PriceOracleVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)),
                    vaultConfig: VaultConfig({asset: address(SFLR_CONTRACT), name: "cysFLR", symbol: "cysFLR"})
                })
            )
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cysflr, PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR, PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployFTSOV2LTSFeedOracleETHUSD(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: ETH_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(payable(ftsoV2LTSFeedOracle)), PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH
        );
        vm.stopBroadcast();
    }

    function deployStargateWethPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cyweth = ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
            abi.encode(
                CycloVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE)),
                    asset: FLARE_STARGATE_WETH
                })
            )
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cyweth, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
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
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_1) {
            deployStakedFlrOracles1(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_2) {
            deployStakedFlrOracles2(deployerPrivateKey);
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
