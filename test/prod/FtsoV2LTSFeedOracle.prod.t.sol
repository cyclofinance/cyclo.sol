// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_ADDRESS,
    PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_EXPECTED_CODE
} from "src/lib/LibCycloProd.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";

contract FtsoV2LTSFeedOracleProdTest is Test {
    function testProdCycloFtsoV2LTSFeedOraclePrice() external {
        LibCycloTestProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_ADDRESS)).price();

        assertEq(price, 29396200000000000);
    }

    function testProdCycloFtsoV2LTSFeedOracleBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_ADDRESS.code, PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_EXPECTED_CODE);
    }

    fallback() external payable {}

    receive() external payable {}
}
