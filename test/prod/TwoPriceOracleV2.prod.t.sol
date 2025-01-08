// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloTestProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)).price();

        assertEq(price, 30947565872727724);
    }

    function testProdCycloTwoPriceOracleV2Bytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2.codehash, PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
