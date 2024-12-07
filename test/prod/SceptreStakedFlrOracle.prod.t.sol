// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 thedavidmeister
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {LibCycloProd, PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS} from "test/lib/LibCycloProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract SceptreStakedFlrOracleProdTest is Test {
    function testProdCycloSceptreStakedFlrOraclePrice() external {
        LibCycloProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS)).price();

        assertEq(price, 847762204247758556);
    }

    fallback() external payable {}

    receive() external payable {}
}
