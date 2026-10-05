// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";

import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "test/interface/IPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)).price();

        assertEq(price, 0.02222382163208827e18);
    }

    fallback() external payable {}

    receive() external payable {}
}
