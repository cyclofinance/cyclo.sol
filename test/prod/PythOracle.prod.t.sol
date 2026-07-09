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
    PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM,
    PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH,
    PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM,
    PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";
import {PythOracle, PythOracleConfig} from "ethgild/concrete/oracle/PythOracle.sol";
import {LibPyth} from "rain.pyth/lib/pyth/LibPyth.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract PythOracleProdTest is Test {
    /// At the pinned block, WBTC, UNI and XAUT have fresh Pyth pushes; the
    /// other 9 feeds are older than the 1800s stale threshold and revert with
    /// `StalePrice()` (selector 0x19abf40e). The fresh prices are pinned
    /// exactly; the stale ones are pinned as `vm.expectRevert(StalePrice)`.
    function testProdCycloPythOraclePrice() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        bytes memory stalePrice = abi.encodeWithSignature("StalePrice()");

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_WETH_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM)).price();

        uint256 price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM)).price();
        assertEq(price, 80906.60000001e18);

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_LINK_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_DOT_USD_ARBITRUM)).price();

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_UNI_USD_ARBITRUM)).price();
        assertEq(price, 3.48202396e18);

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_ENA_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_ARB_USD_ARBITRUM)).price();

        vm.expectRevert(stalePrice);
        IPriceOracleV2(payable(PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM)).price();

        price = IPriceOracleV2(payable(PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM)).price();
        assertEq(price, 4711.38445871e18);
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

        PythOracle wstethusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_WSTETH_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(wstethusd), PYTH_ORACLE_WSTETH_USD_ARBITRUM_CODEHASH);

        PythOracle wbtcusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_WBTC_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(wbtcusd), PYTH_ORACLE_WBTC_USD_ARBITRUM_CODEHASH);

        PythOracle cbbtcusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_CBBTC_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(cbbtcusd), PYTH_ORACLE_CBBTC_USD_ARBITRUM_CODEHASH);

        PythOracle linkusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_LINK_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(linkusd), PYTH_ORACLE_LINK_USD_ARBITRUM_CODEHASH);

        PythOracle dotusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_DOT_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(dotusd), PYTH_ORACLE_DOT_USD_ARBITRUM_CODEHASH);

        PythOracle uniusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_UNI_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(uniusd), PYTH_ORACLE_UNI_USD_ARBITRUM_CODEHASH);

        PythOracle pepeusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_PEPE_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(pepeusd), PYTH_ORACLE_PEPE_USD_ARBITRUM_CODEHASH);

        PythOracle enausd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_ENA_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(enausd), PYTH_ORACLE_ENA_USD_ARBITRUM_CODEHASH);

        PythOracle arbusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_ARB_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(arbusd), PYTH_ORACLE_ARB_USD_ARBITRUM_CODEHASH);

        PythOracle pythusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_PYTH_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(pythusd), PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH);

        PythOracle xautusd = new PythOracle(
            PythOracleConfig({
                priceFeedId: LibPyth.PRICE_FEED_ID_CRYPTO_XAUT_USD,
                staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
            })
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(xautusd), PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH);

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
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM, PYTH_ORACLE_PYTH_USD_ARBITRUM_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM, PYTH_ORACLE_XAUT_USD_ARBITRUM_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
