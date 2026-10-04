// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {TWO_PRICE_ORACLE_V2_CREATION_CODE} from "src/legacy/TwoPriceOracleV2.sol";
import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V1
} from "src/lib/LibCycloProdCloneFactory.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_RECEIPT_CYFXRP,
    PROD_FLARE_RECEIPT_CYJOULE,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP,
    PROD_FLARE_VAULT_CYJOULE
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2
} from "src/lib/LibCycloProdOracle.sol";

/// @title CycloProdFlareTest
/// @notice Every Flare production deployment still runs the pinned code.
contract CycloProdFlareTest is Test {
    function setUp() external {
        LibCycloTestProd.createSelectForkFlare(vm);
    }

    function testProdCloneFactory() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_CLONE_FACTORY_ADDRESS_V1, PROD_FLARE_CLONE_FACTORY_CODEHASH_V1
        );
    }

    function testProdReceipts() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYWETH, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYFXRP, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYJOULE, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
        );
    }

    function testProdVaults() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYWETH,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYFXRP,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYJOULE,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testProdOracles() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE, PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2, PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH
        );
    }

    /// `TwoPriceOracleV2` prices itself in its constructor, so it only
    /// constructs on a Flare fork.
    function testReproduceTwoPriceOracleV2() external {
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            LibCycloTestProd.deployLegacy(
                TWO_PRICE_ORACLE_V2_CREATION_CODE,
                abi.encode(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE, PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE)
            ),
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2
        );
    }

    receive() external payable {}
}
