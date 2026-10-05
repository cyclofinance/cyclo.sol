// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";

import {
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE_CODEHASH,
    PROD_ORACLE_DEFAULT_STALE_AFTER
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "test/interface/IPriceOracleV2.sol";

contract FtsoV2LTSFeedOracleProdTest is Test {
    function testProdCycloFtsoV2LTSFeedOraclePrice() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE)).price();
        assertEq(price, 0.0133948e18);

        price = IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE)).price();
        assertEq(price, 2946.373e18);

        price = IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE)).price();
        assertEq(price, 2.192621e18);

        price = IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE)).price();
        assertEq(price, 0.00093977e18);
    }

    fallback() external payable {}

    receive() external payable {}
}
