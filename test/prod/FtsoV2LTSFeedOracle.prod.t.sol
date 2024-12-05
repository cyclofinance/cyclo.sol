// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 thedavidmeister
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {PROD_FORK_URL, PROD_BLOCK_NUMBER, PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS} from "test/lib/LibCycloProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract FtsoV2LTSFeedOracleProdTest is Test {
    function testProdCycloFtsoV2LTSFeedOraclePrice() external {
        vm.createSelectFork(PROD_FORK_URL, PROD_BLOCK_NUMBER);

        uint256 price = IPriceOracleV2(payable(PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS)).price();

        assertEq(price, 32593600000000000);
    }

    fallback() external payable {}

    receive() external payable {}
}
