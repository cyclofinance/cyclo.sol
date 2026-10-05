// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {RUNTIME_CODE as CYCLO_RECEIPT_RUNTIME} from "src/generated/candidate/CycloReceipt.sol";
import {RUNTIME_CODE as CYCLO_VAULT_FLARE_RUNTIME} from "src/generated/candidate/CycloVaultFlare.sol";
import {RUNTIME_CODE as CYCLO_VAULT_ARBITRUM_RUNTIME} from "src/generated/candidate/CycloVaultArbitrum.sol";
import {RUNTIME_CODE as SCEPTRE_STAKED_FLR_ORACLE_RUNTIME} from "src/generated/candidate/SceptreStakedFlrOracle.sol";
import {
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME
} from "src/generated/candidate/FtsoV2LTSFeedOracleFlrUsd.sol";
import {
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME
} from "src/generated/candidate/FtsoV2LTSFeedOracleEthUsd.sol";
import {
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME
} from "src/generated/candidate/FtsoV2LTSFeedOracleXrpUsd.sol";
import {
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME
} from "src/generated/candidate/FtsoV2LTSFeedOracleJouleUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_WETH_USD_RUNTIME} from "src/generated/candidate/PythOracleWethUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_WSTETH_USD_RUNTIME} from "src/generated/candidate/PythOracleWstethUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_WBTC_USD_RUNTIME} from "src/generated/candidate/PythOracleWbtcUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_CBBTC_USD_RUNTIME} from "src/generated/candidate/PythOracleCbbtcUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_LINK_USD_RUNTIME} from "src/generated/candidate/PythOracleLinkUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_DOT_USD_RUNTIME} from "src/generated/candidate/PythOracleDotUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_UNI_USD_RUNTIME} from "src/generated/candidate/PythOracleUniUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_PEPE_USD_RUNTIME} from "src/generated/candidate/PythOraclePepeUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_PYTH_USD_RUNTIME} from "src/generated/candidate/PythOraclePythUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_ENA_USD_RUNTIME} from "src/generated/candidate/PythOracleEnaUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_ARB_USD_RUNTIME} from "src/generated/candidate/PythOracleArbUsd.sol";
import {RUNTIME_CODE as PYTH_ORACLE_XAUT_USD_RUNTIME} from "src/generated/candidate/PythOracleXautUsd.sol";
import {
    RUNTIME_CODE as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_RUNTIME
} from "src/generated/candidate/TwoPriceOracleV2FlrUsdSflr.sol";
import {PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
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
    PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2
} from "src/lib/LibCycloProdOracle.sol";

/// @title LibCycloProdReproductionTest
/// @notice Every recorded runtime code, CBOR-trimmed, is the production code
/// hash pinned for that deployment. `CycloDeploySnapshotTest` holds each
/// runtime code to what its creation code constructs.
contract LibCycloProdReproductionTest is Test {
    function testReproduceCycloReceipt() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(CYCLO_RECEIPT_RUNTIME, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2);
    }

    function testReproduceCycloVaultFlare() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            CYCLO_VAULT_FLARE_RUNTIME, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testReproduceCycloVaultArbitrum() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            CYCLO_VAULT_ARBITRUM_RUNTIME, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testReproduceSceptreStakedFlrOracle() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            SCEPTRE_STAKED_FLR_ORACLE_RUNTIME, PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );
    }

    function testReproduceFtsoV2LTSFeedOracleFlrUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME, PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2
        );
    }

    function testReproduceFtsoV2LTSFeedOracleEthUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2
        );
    }

    function testReproduceFtsoV2LTSFeedOracleXrpUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME, PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2
        );
    }

    function testReproduceFtsoV2LTSFeedOracleJouleUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME, PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH
        );
    }

    function testReproducePythOracleWethUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_WETH_USD_RUNTIME, PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleWstethUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_WSTETH_USD_RUNTIME, PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleWbtcUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_WBTC_USD_RUNTIME, PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleCbbtcUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_CBBTC_USD_RUNTIME, PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleLinkUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_LINK_USD_RUNTIME, PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleDotUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_DOT_USD_RUNTIME, PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleUniUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_UNI_USD_RUNTIME, PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOraclePepeUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_PEPE_USD_RUNTIME, PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOraclePythUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_PYTH_USD_RUNTIME, PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleEnaUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_ENA_USD_RUNTIME, PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleArbUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_ARB_USD_RUNTIME, PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproducePythOracleXautUsd() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PYTH_ORACLE_XAUT_USD_RUNTIME, PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH
        );
    }

    function testReproduceTwoPriceOracleV2FlrUsdSflr() external pure {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_RUNTIME, PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2
        );
    }
}
