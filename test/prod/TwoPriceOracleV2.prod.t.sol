// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH,
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {TwoPriceOracleV2, TwoPriceOracleConfigV2} from "ethgild/concrete/oracle/TwoPriceOracleV2.sol";

contract TwoPriceOracleV2ProdTest is Test {
    function testProdCycloTwoPriceOracleV2Price() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)).price();

        assertEq(price, 0.02222382163208827e18);
    }

    function testProdCycloTwoPriceOracleV2Bytecode() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        TwoPriceOracleV2 fresh = new TwoPriceOracleV2(
            TwoPriceOracleConfigV2({
                base: IPriceOracleV2(payable(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE)),
                quote: IPriceOracleV2(payable(PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE))
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(fresh), PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH2
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2, PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
