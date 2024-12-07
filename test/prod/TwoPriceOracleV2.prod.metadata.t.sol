// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 thedavidmeister
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {LibCycloProd, PROD_TWO_PRICE_ORACLE_V2_ADDRESS} from "test/lib/LibCycloProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_V2_ADDRESS)).price();

        assertEq(price, 38380849692945697);
    }

    fallback() external payable {}

    receive() external payable {}
}
