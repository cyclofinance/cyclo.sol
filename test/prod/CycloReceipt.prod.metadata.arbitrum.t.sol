// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {PROD_ARBITRUM_RECEIPT_CYWETH_PYTH} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataArbitrumTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "cyWETH.pyth", "WETH", 18);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
    }
}
