// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {PROD_CYCLO_RECEIPT_ADDRESS} from "src/lib/LibCycloProd.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptURIV1(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptName(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptSymbol(PROD_CYCLO_RECEIPT_ADDRESS);
    }
}
