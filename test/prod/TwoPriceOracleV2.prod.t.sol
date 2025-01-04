// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS,
    PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_ADDRESS,
    PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS,
    PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_EXPECTED_CODE
} from "src/lib/LibCycloProd.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloTestProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS)).price();

        assertEq(price, 35553306952338608);
    }

    function testProdCycloTwoPriceOracleV2Bytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS.code, PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_EXPECTED_CODE
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
