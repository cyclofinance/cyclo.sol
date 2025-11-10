// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
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
    }

    function testProdCysWETHImplementationIsInitializedArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2);
    }

    function testProdCycloReceiptIsInitializedCYWETHArbitrum() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_RECEIPT_CYWETH_PYTH);
    }

    fallback() external payable {}

    receive() external payable {}
}
