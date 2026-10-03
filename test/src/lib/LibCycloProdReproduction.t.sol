// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {CycloVault} from "src/concrete/vault/CycloVault.sol";
import {ReceiptVaultConstructionConfigV2} from "ethgild/abstract/ReceiptVault.sol";
import {IReceiptV3} from "ethgild/interface/IReceiptV3.sol";
import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {PythOracle, PythOracleConfig} from "ethgild/concrete/oracle/PythOracle.sol";
import {
    FLR_USD_FEED_ID,
    ETH_USD_FEED_ID,
    XRP_USD_FEED_ID,
    JOULE_USD_FEED_ID
} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {LibPyth} from "rain.pyth/lib/pyth/LibPyth.sol";
import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V1,
    PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1
} from "src/lib/LibCycloProdCloneFactory.sol";
import {
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_ORACLE_DEFAULT_STALE_AFTER,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH,
    PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";

/// @title LibCycloProdReproductionTest
/// @notice Every hand-written production code hash re-derived offline from the
/// pinned sources, constructed exactly as `script/CreateVault.sol` constructs
/// them. A pin this cannot reproduce is a pin the sources no longer describe.
contract LibCycloProdReproductionTest is Test {
    function testReproduceCloneFactory() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(new CloneFactory()), PROD_FLARE_CLONE_FACTORY_CODEHASH_V1);
    }

    function testReproduceCycloReceipt() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(new CycloReceipt()), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2);
    }

    function testReproduceCycloVaultFlare() external {
        CycloVault vault = new CycloVault(
            ReceiptVaultConstructionConfigV2({
                factory: ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1),
                receiptImplementation: IReceiptV3(PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2)
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(vault), PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH);
    }

    function testReproduceCycloVaultArbitrum() external {
        CycloVault vault = new CycloVault(
            ReceiptVaultConstructionConfigV2({
                factory: ICloneableFactoryV2(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1),
                receiptImplementation: IReceiptV3(PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2)
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(vault), PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testReproduceSceptreStakedFlrOracle() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(new SceptreStakedFlrOracle()), PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );
    }

    function checkFtso(bytes21 feedId, bytes32 codehash) internal {
        FtsoV2LTSFeedOracle oracle = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: feedId, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(oracle), codehash);
    }

    function testReproduceFtsoV2LTSFeedOracleFlrUsd() external {
        checkFtso(FLR_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleEthUsd() external {
        checkFtso(ETH_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleXrpUsd() external {
        checkFtso(XRP_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleJouleUsd() external {
        checkFtso(JOULE_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH);
    }

    function checkPyth(bytes32 priceFeedId, bytes32 codehash) internal {
        PythOracle oracle = new PythOracle(
            PythOracleConfig({
                priceFeedId: priceFeedId,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(oracle), codehash);
    }

    function testReproducePythOracles() external {
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_WETH_USD, PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_WSTETH_USD, PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_WBTC_USD, PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_CBBTC_USD, PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_LINK_USD, PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_DOT_USD, PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_UNI_USD, PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_PEPE_USD, PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_PYTH_USD, PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_ENA_USD, PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_ARB_USD, PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH);
        checkPyth(LibPyth.PRICE_FEED_ID_CRYPTO_XAUT_USD, PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH);
    }
}
