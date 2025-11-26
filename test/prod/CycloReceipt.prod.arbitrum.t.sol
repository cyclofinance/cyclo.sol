// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYLINK_PYTH,
    PROD_ARBITRUM_RECEIPT_CYDOT_PYTH,
    PROD_ARBITRUM_RECEIPT_CYUNI_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYENA_PYTH,
    PROD_ARBITRUM_RECEIPT_CYARB_PYTH,
    PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH,
    PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CycloReceiptProdArbitrumTest is Test {
    function testProdCycloReceiptBytecodeArbitrum() external {
        CycloReceipt fresh = new CycloReceipt();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2);

        LibCycloTestProd.createSelectForkArbitrum(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYLINK_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYDOT_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYUNI_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYENA_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYARB_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH,
            PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2
        );
    }

    function testProdCyImplementationIsInitializedArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2);
    }

    function testProdCycloReceiptIsInitializedCYWETHArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYWETH_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYWSTETHArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYWBTCArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYCBBTCArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYLINKArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYLINK_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYDOTArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYDOT_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYUNIArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYUNI_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYPEPEArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYPYTHArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYENAArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYENA_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYARBArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYARB_PYTH);
    }

    function testProdCycloReceiptIsInitializedCYXAUTArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH);
    }

    fallback() external payable {}

    receive() external payable {}
}
