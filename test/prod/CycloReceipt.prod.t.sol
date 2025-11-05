// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYFXRP,
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CycloReceiptProdTest is Test {
    function testProdCycloReceiptBytecode() external {
        CycloReceipt fresh = new CycloReceipt();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1);

        LibCycloTestProd.createSelectFork(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYWETH, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYFXRP, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
        );
    }

    function testProdCysFLRImplementationIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR);
    }

    function testProdCycloReceiptIsInitializedCysFLR() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYSFLR);
    }

    function testProdCysWETHImplementationIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1);
    }

    function testProdCycloReceiptIsInitializedCYWETH() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYWETH);
    }

    function testProdCycloReceiptIsInitializedCYFXRP() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYFXRP);
    }

    fallback() external payable {}

    receive() external payable {}
}
