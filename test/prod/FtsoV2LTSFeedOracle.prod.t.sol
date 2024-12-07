// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {LibCycloProd, PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS} from "test/lib/LibCycloProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract FtsoV2LTSFeedOracleProdTest is Test {
    function testProdCycloFtsoV2LTSFeedOraclePrice() external {
        LibCycloProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS)).price();

        assertEq(price, 32496900000000000);
    }

    fallback() external payable {}

    receive() external payable {}
}
