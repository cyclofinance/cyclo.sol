// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

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
    PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";
import {PythOracle, PythOracleConfig} from "ethgild/concrete/oracle/PythOracle.sol";
import {LibPyth} from "rain.pyth/lib/pyth/LibPyth.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract PythOracleProdTest is Test {
    function testProdCycloPythOraclePrice() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        uint256 price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WETH_USD_ARBITRUM)).price();
        assertEq(price, 2931.91265984e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM)).price();
        assertEq(price, 3575.82075957e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM)).price();
        assertEq(price, 87033.65787235e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM)).price();
        assertEq(price, 87234.72332538e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_LINK_USD_ARBITRUM)).price();
        assertEq(price, 12.92700001e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_DOT_USD_ARBITRUM)).price();
        assertEq(price, 2.25198666e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_UNI_USD_ARBITRUM)).price();
        assertEq(price, 6.02794029e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM)).price();
        assertEq(price, 0.000004477e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_ENA_USD_ARBITRUM)).price();
        assertEq(price, 0.27549322e18);

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_ARB_USD_ARBITRUM)).price();
        assertEq(price, 0.21402471e18);
    }

    function testProdCycloPythOracleBytecode() external {
        PythOracle ethusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_WETH_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(ethusd), PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH);

        LibCycloTestProd.createSelectForkArbitrum(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_WETH_USD_ARBITRUM, PYTH_ORACLE_WETH_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM, PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM, PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM, PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_LINK_USD_ARBITRUM, PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_DOT_USD_ARBITRUM, PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_UNI_USD_ARBITRUM, PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM, PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_ENA_USD_ARBITRUM, PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_ARB_USD_ARBITRUM, PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
