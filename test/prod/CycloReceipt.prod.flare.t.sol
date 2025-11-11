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
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CycloReceiptProdFlareTest is Test {
    function testProdCycloReceiptBytecodeFlare() external {
        CycloReceipt fresh = new CycloReceipt();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2);

        LibCycloTestProd.createSelectForkFlare(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYWETH, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_RECEIPT_CYFXRP, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2
        );
    }

    function testProdCysFLRImplementationIsInitializedFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR);
    }

    function testProdCycloReceiptIsInitializedCysFLRFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYSFLR);
    }

    function testProdCysWETHImplementationIsInitializedFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1);
    }

    function testProdCycloReceiptIsInitializedCYWETHFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYWETH);
    }

    function testProdCycloReceiptIsInitializedCYFXRPFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_RECEIPT_CYFXRP);
    }

    fallback() external payable {}

    receive() external payable {}
}
