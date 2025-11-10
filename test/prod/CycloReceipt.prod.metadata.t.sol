// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_RECEIPT_CYFXRP
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptURIV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYWETH, "cyWETH", "WETH", 18);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYFXRP, "cyFXRP.ftso", "FXRP", 6);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptNameV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYFXRP, "FXRP.ftso");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptSymbolV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYFXRP, "FXRP.ftso");
    }
}
