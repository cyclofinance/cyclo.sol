// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CYCLO_RECEIPT_CREATION_CODE} from "src/legacy/CycloReceipt.sol";
import {CYCLO_VAULT_CREATION_CODE} from "src/legacy/CycloVault.sol";
import {SCEPTRE_STAKED_FLR_ORACLE_CREATION_CODE} from "src/legacy/SceptreStakedFlrOracle.sol";
import {FTSO_V2_LTS_FEED_ORACLE_CREATION_CODE} from "src/legacy/FtsoV2LTSFeedOracle.sol";
import {PYTH_ORACLE_CREATION_CODE} from "src/legacy/PythOracle.sol";
import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
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
    FTSO_V2_LTS_FLR_USD_FEED_ID,
    FTSO_V2_LTS_ETH_USD_FEED_ID,
    FTSO_V2_LTS_XRP_USD_FEED_ID,
    FTSO_V2_LTS_JOULE_USD_FEED_ID,
    PYTH_PRICE_FEED_CONTRACT_ARBITRUM,
    PYTH_PRICE_FEED_ID_WETH_USD,
    PYTH_PRICE_FEED_ID_WSTETH_USD,
    PYTH_PRICE_FEED_ID_WBTC_USD,
    PYTH_PRICE_FEED_ID_CBBTC_USD,
    PYTH_PRICE_FEED_ID_LINK_USD,
    PYTH_PRICE_FEED_ID_DOT_USD,
    PYTH_PRICE_FEED_ID_UNI_USD,
    PYTH_PRICE_FEED_ID_PEPE_USD,
    PYTH_PRICE_FEED_ID_PYTH_USD,
    PYTH_PRICE_FEED_ID_ENA_USD,
    PYTH_PRICE_FEED_ID_ARB_USD,
    PYTH_PRICE_FEED_ID_XAUT_USD,
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

/// @title LibCycloLegacyReproductionTest
/// @notice Every production code hash re-derived offline from the recorded
/// creation code, constructed with the arguments the deployments were
/// constructed with. `TwoPriceOracleV2` reads Flare at construction, so its
/// reproduction is in `test/prod`.
contract LibCycloLegacyReproductionTest is Test {
    function testReproduceCycloReceipt() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(CYCLO_RECEIPT_CREATION_CODE, ""), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
        );
    }

    function testReproduceCycloVaultFlare() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(
                CYCLO_VAULT_CREATION_CODE,
                abi.encode(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2)
            ),
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testReproduceCycloVaultArbitrum() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(
                CYCLO_VAULT_CREATION_CODE,
                abi.encode(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1, PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2)
            ),
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testReproduceSceptreStakedFlrOracle() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(SCEPTRE_STAKED_FLR_ORACLE_CREATION_CODE, ""),
            PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );
    }

    function checkFtso(bytes21 feedId, bytes32 codehash) internal {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(
                FTSO_V2_LTS_FEED_ORACLE_CREATION_CODE, abi.encode(feedId, PROD_ORACLE_DEFAULT_STALE_AFTER)
            ),
            codehash
        );
    }

    function testReproduceFtsoV2LTSFeedOracleFlrUsd() external {
        checkFtso(FTSO_V2_LTS_FLR_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleEthUsd() external {
        checkFtso(FTSO_V2_LTS_ETH_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleXrpUsd() external {
        checkFtso(FTSO_V2_LTS_XRP_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2);
    }

    function testReproduceFtsoV2LTSFeedOracleJouleUsd() external {
        checkFtso(FTSO_V2_LTS_JOULE_USD_FEED_ID, PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH);
    }

    function checkPyth(bytes32 priceFeedId, bytes32 codehash) internal {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(
                PYTH_ORACLE_CREATION_CODE,
                abi.encode(priceFeedId, PROD_ORACLE_DEFAULT_STALE_AFTER, PYTH_PRICE_FEED_CONTRACT_ARBITRUM)
            ),
            codehash
        );
    }

    function testReproducePythOracles() external {
        checkPyth(PYTH_PRICE_FEED_ID_WETH_USD, PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_WSTETH_USD, PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_WBTC_USD, PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_CBBTC_USD, PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_LINK_USD, PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_DOT_USD, PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_UNI_USD, PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_PEPE_USD, PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_PYTH_USD, PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_ENA_USD, PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_ARB_USD, PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH);
        checkPyth(PYTH_PRICE_FEED_ID_XAUT_USD, PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH);
    }
}
