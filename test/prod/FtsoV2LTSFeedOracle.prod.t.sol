// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2,
    PROD_ORACLE_DEFAULT_STALE_AFTER
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {FLR_USD_FEED_ID, ETH_USD_FEED_ID, XRP_USD_FEED_ID} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";

contract FtsoV2LTSFeedOracleProdTest is Test {
    function testProdCycloFtsoV2LTSFeedOraclePrice() external {
        LibCycloTestProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE)).price();
        assertEq(price, 0.0176799e18);

        price = FtsoV2LTSFeedOracle(payable(PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE)).price();
        assertEq(price, 4209.596e18);

        price = FtsoV2LTSFeedOracle(payable(PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE)).price();
        assertEq(price, 2.643909e18);
    }

    function testProdCycloFtsoV2LTSFeedOracleBytecode() external {
        FtsoV2LTSFeedOracle flrusd = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: FLR_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(flrusd), PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH2
        );

        FtsoV2LTSFeedOracle ethusd = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: ETH_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(ethusd), PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH2
        );

        FtsoV2LTSFeedOracle xrpusd = new FtsoV2LTSFeedOracle(
            FtsoV2LTSFeedOracleConfig({feedId: XRP_USD_FEED_ID, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER})
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(xrpusd), PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH2
        );

        LibCycloTestProd.createSelectFork(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE, PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
