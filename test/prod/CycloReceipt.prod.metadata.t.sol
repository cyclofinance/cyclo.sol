// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 thedavidmeister
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {PROD_FORK_URL, PROD_CYCLO_RECEIPT_ADDRESS} from "test/lib/LibCycloProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        vm.createSelectFork(PROD_FORK_URL);

        checkCycloReceiptURI(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptName() external {
        vm.createSelectFork(PROD_FORK_URL);

        checkCycloReceiptName(PROD_CYCLO_RECEIPT_ADDRESS);
    }

    function testProdCycloReceiptSymbol() external {
        vm.createSelectFork(PROD_FORK_URL);

        checkCycloReceiptSymbol(PROD_CYCLO_RECEIPT_ADDRESS);
    }
}
