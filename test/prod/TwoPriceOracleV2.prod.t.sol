// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    LibCycloProd,
    PROD_TWO_PRICE_ORACLE_V2_ADDRESS,
    PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS,
    PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS
} from "test/lib/LibCycloProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_V2_ADDRESS)).price();

        assertEq(price, 35681817222460415);
    }

    function testProdCycleoFtsoV2LTSFeedOracleBytecode() external {
        LibCycloProd.createSelectFork(vm);

        TwoPriceOracleV2 fresh = new TwoPriceOracleV2(
            TwoPriceOracleConfigV2({
                base: IPriceOracleV2(payable(PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS)),
                quote: IPriceOracleV2(payable(PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS))
            })
        );

        assertEq(PROD_TWO_PRICE_ORACLE_V2_ADDRESS.code, address(fresh).code);
    }

    fallback() external payable {}

    receive() external payable {}
}
