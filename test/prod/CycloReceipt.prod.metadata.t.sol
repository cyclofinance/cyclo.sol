// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {LibCycloProd, PROD_CYCLO_RECEIPT_ADDRESS} from "test/lib/LibCycloProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloProd.createSelectFork(vm);

        checkCycloReceiptURI(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptName() external {
        LibCycloProd.createSelectFork(vm);

        checkCycloReceiptName(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloProd.createSelectFork(vm);

        checkCycloReceiptSymbol(PROD_CYCLO_RECEIPT_ADDRESS);
    }
}
