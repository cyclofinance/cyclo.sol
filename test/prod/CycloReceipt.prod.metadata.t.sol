// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {PROD_FLARE_RECEIPT_CYSFLR, PROD_FLARE_RECEIPT_CYWETH} from "src/lib/LibCycloProdDeployment.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptURIV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptNameV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        checkCycloReceiptSymbolV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
    }
}
