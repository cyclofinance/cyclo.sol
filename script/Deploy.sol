// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    ERC20PriceOracleVaultConfig,
    ReceiptVaultConstructionConfigV2,
    VaultConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {IReceiptV3} from "ethgild/interface/IReceiptV3.sol";
import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID, ETH_USD_FEED_ID, XRP_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {IPriceOracleV2} from "ethgild/abstract/PriceOracleV2.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V1,
    PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1,
    PROD_ARBITRUM_CLONE_FACTORY_CODEHASH_V1
} from "src/lib/LibCycloProdCloneFactory.sol";
import {CycloVault, CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";
import {FLARE_STARGATE_WETH, FLARE_FASSET_XRP, ARBITRUM_WETH, ARBITRUM_WBTC} from "src/lib/LibCycloProdAssets.sol";
import {
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_ORACLE_DEFAULT_STALE_AFTER,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_WETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM,
    PYTH_ORACLE_NAME,
    PYTH_ORACLE_SYMBOL
} from "src/lib/LibCycloProdOracle.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibPyth} from "rain.pyth/lib/pyth/LibPyth.sol";
import {PythOracle, PythOracleConfig} from "ethgild/concrete/oracle/PythOracle.sol";

bytes32 constant DEPLOYMENT_SUITE_FACTORY = keccak256("factory");
bytes32 constant DEPLOYMENT_SUITE_FACTORY_ARBITRUM = keccak256("factory-arbitrum");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION = keccak256("cyclo-receipt-implementation");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION_ARBITRUM =
    keccak256("cyclo-receipt-implementation-arbitrum");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION = keccak256("cyclo-vault-implementation");
bytes32 constant DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION_ARBITRUM = keccak256("cyclo-vault-implementation-arbitrum");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_1 = keccak256("sceptre-staked-flare-oracle-1");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_2 = keccak256("sceptre-staked-flare-oracle-2");
bytes32 constant DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT = keccak256("sceptre-staked-flare-price-vault");
bytes32 constant DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_ETH_USD = keccak256("ftso-v2-lts-feed-oracle-eth-usd");
bytes32 constant DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_XRP_USD = keccak256("ftso-v2-lts-feed-oracle-xrp-usd");
bytes32 constant DEPLOYMENT_SUITE_STARGATE_WETH_PRICE_VAULT = keccak256("stargate-weth-price-vault");
bytes32 constant DEPLOYMENT_SUITE_FLARE_FASSET_XRP = keccak256("flare-fasset-xrp-price-vault");
bytes32 constant DEPLOYMENT_SUITE_PYTH_ORACLE_WETH_USD = keccak256("pyth-oracle-weth-usd");
bytes32 constant DEPLOYMENT_SUITE_PYTH_ORACLE_WBTC_USD = keccak256("pyth-oracle-wbtc-usd");
bytes32 constant DEPLOYMENT_SUITE_PYTH_WETH_PRICE_VAULT = keccak256("pyth-weth-price-vault");
bytes32 constant DEPLOYMENT_SUITE_PYTH_WBTC_PRICE_VAULT = keccak256("pyth-wbtc-price-vault");

contract Deploy is Script {
    function deployFactory(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ICloneableFactoryV2 cloneFactory = new CloneFactory();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cloneFactory), PROD_FLARE_CLONE_FACTORY_CODEHASH_V1);

        vm.stopBroadcast();
    }

    function deployFactoryArbitrum(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ICloneableFactoryV2 cloneFactory = new CloneFactory();
        // Use the same codehash as Flare's clone factory
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cloneFactory), PROD_ARBITRUM_CLONE_FACTORY_CODEHASH_V1);

        vm.stopBroadcast();
    }

    function deployCycloReceiptImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cycloReceipt), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2);

        vm.stopBroadcast();
    }

    function deployCycloReceiptImplementationArbitrum(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        CycloReceipt cycloReceipt = new CycloReceipt();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cycloReceipt), PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2);

        vm.stopBroadcast();
    }

    function deployCycloVaultImplementation(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ReceiptVaultConstructionConfigV2 memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfigV2({
            factory: ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1),
            receiptImplementation: IReceiptV3(PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2)
        });
        CycloVault cycloVault = new CycloVault(receiptVaultConstructionConfig);
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(cycloVault), PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployCycloVaultImplementationArbitrum(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        ReceiptVaultConstructionConfigV2 memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfigV2({
            factory: ICloneableFactoryV2(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1),
            receiptImplementation: IReceiptV3(PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2)
        });
        CycloVault cycloVault = new CycloVault(receiptVaultConstructionConfig);
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(cycloVault), PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );

        vm.stopBroadcast();
    }

    function deployStakedFlrOracles1(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        IPriceOracleV2 stakedFlrOracle = new SceptreStakedFlrOracle();
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(stakedFlrOracle), PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );

        //forge-lint: disable-next-line(mixed-case-variable)
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

    //forge-lint: disable-next-line(mixed-case-function)
    function deployFTSOV2LTSFeedOracleETHUSD(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        //forge-lint: disable-next-line(mixed-case-variable)
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: ETH_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(payable(ftsoV2LTSFeedOracle)), PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH
        );
        vm.stopBroadcast();
    }

    //forge-lint: disable-next-line(mixed-case-function)
    function deployFTSOV2LTSFeedOracleXRPUSD(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);
        //forge-lint: disable-next-line(mixed-case-variable)
        IPriceOracleV2 ftsoV2LTSFeedOracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: XRP_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(payable(ftsoV2LTSFeedOracle)), PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2
        );
        vm.stopBroadcast();
    }

    //forge-lint: disable-next-line(mixed-case-function)
    function deployPythOracleWETHUSDArbitrum(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        require(block.chainid == LibPyth.CHAIN_ID_ARBITRUM, "Chain is not Arbitrum");

        IPriceOracleV2 pythOracle = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_WETH_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(pythOracle), PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH);

        vm.stopBroadcast();
    }

    //forge-lint: disable-next-line(mixed-case-function)
    function deployPythOracleWBTCUSDArbitrum(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        require(block.chainid == LibPyth.CHAIN_ID_ARBITRUM, "Chain is not Arbitrum");

        IPriceOracleV2 pythOracle = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_WBTC_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(pythOracle), PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH);

        vm.stopBroadcast();
    }

    function deployStargateWethPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cyweth = ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
            abi.encode(
                CycloVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE)),
                    asset: FLARE_STARGATE_WETH,
                    oracleName: "",
                    oracleSymbol: ""
                })
            )
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cyweth, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        vm.stopBroadcast();
    }

    function deployPythWethPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cyweth = ICloneableFactoryV2(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            abi.encode(
                CycloVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_PYTH_ORACLE_WETH_USD_ARBITRUM)),
                    asset: ARBITRUM_WETH,
                    oracleName: PYTH_ORACLE_NAME,
                    oracleSymbol: PYTH_ORACLE_SYMBOL
                })
            )
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cyweth, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        vm.stopBroadcast();
    }

    function deployPythWbtcPriceVault(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cywbtc = ICloneableFactoryV2(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            abi.encode(
                CycloVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM)),
                    asset: ARBITRUM_WBTC,
                    oracleName: PYTH_ORACLE_NAME,
                    oracleSymbol: PYTH_ORACLE_SYMBOL
                })
            )
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cywbtc, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        vm.stopBroadcast();
    }

    //forge-lint: disable-next-line(mixed-case-function)
    function deployFlareFassetXRP(uint256 deploymentKey) internal {
        vm.startBroadcast(deploymentKey);

        address cyxrp = ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1).clone(
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
            abi.encode(
                CycloVaultConfig({
                    priceOracle: IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE)),
                    asset: FLARE_FASSET_XRP,
                    oracleName: "FTSO",
                    oracleSymbol: "ftso"
                })
            )
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            cyxrp, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        vm.stopBroadcast();
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        bytes32 suite = keccak256(bytes(vm.envString("DEPLOYMENT_SUITE")));

        if (suite == DEPLOYMENT_SUITE_FACTORY) {
            deployFactory(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_FACTORY_ARBITRUM) {
            deployFactoryArbitrum(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION) {
            deployCycloReceiptImplementation(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_RECEIPT_IMPLEMENTATION_ARBITRUM) {
            deployCycloReceiptImplementationArbitrum(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION) {
            deployCycloVaultImplementation(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_CYCLO_VAULT_IMPLEMENTATION_ARBITRUM) {
            deployCycloVaultImplementationArbitrum(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_1) {
            deployStakedFlrOracles1(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_ORACLE_2) {
            deployStakedFlrOracles2(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STAKED_FLR_PRICE_VAULT) {
            deployStakedFlrPriceVault(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_ETH_USD) {
            deployFTSOV2LTSFeedOracleETHUSD(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_FTSO_V2_LTS_FEED_ORACLE_XRP_USD) {
            deployFTSOV2LTSFeedOracleXRPUSD(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_STARGATE_WETH_PRICE_VAULT) {
            deployStargateWethPriceVault(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_FLARE_FASSET_XRP) {
            deployFlareFassetXRP(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_PYTH_ORACLE_WETH_USD) {
            deployPythOracleWETHUSDArbitrum(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_PYTH_ORACLE_WBTC_USD) {
            deployPythOracleWBTCUSDArbitrum(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_PYTH_WETH_PRICE_VAULT) {
            deployPythWethPriceVault(deployerPrivateKey);
        } else if (suite == DEPLOYMENT_SUITE_PYTH_WBTC_PRICE_VAULT) {
            deployPythWbtcPriceVault(deployerPrivateKey);
        } else {
            revert("Unknown deployment suite");
        }
    }
}
