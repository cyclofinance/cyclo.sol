// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";

import {
    PROD_ORACLE_DEFAULT_STALE_AFTER,
    PROD_PYTH_ORACLE_WETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM,
    PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM,
    PROD_PYTH_ORACLE_LINK_USD_ARBITRUM,
    PROD_PYTH_ORACLE_DOT_USD_ARBITRUM,
    PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH,
    PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_UNI_USD_ARBITRUM,
    PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM,
    PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_ENA_USD_ARBITRUM,
    PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_ARB_USD_ARBITRUM,
    PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM,
    PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM,
    PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "test/interface/IPriceOracleV2.sol";

contract PythOracleProdTest is Test {
    function testProdCycloPythOraclePrice() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        uint256 price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WETH_USD_ARBITRUM)).price();
        assertEq(price, 2904.76083912e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM)).price();
        assertEq(price, 3550.61377701e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM)).price();
        assertEq(price, 86560.66805924e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM)).price();
        assertEq(price, 86785.63466162e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_LINK_USD_ARBITRUM)).price();
        assertEq(price, 12.80597072e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_DOT_USD_ARBITRUM)).price();
        assertEq(price, 2.24827361e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_UNI_USD_ARBITRUM)).price();
        assertEq(price, 6.00215163e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM)).price();
        assertEq(price, 0.0000044354e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_ENA_USD_ARBITRUM)).price();
        assertEq(price, 0.27290774e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_ARB_USD_ARBITRUM)).price();
        assertEq(price, 0.20872191e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM)).price();
        assertEq(price, 0.0749194e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM)).price();
        assertEq(price, 4140.27469615e18);
    }

    fallback() external payable {}

    receive() external payable {}
}
