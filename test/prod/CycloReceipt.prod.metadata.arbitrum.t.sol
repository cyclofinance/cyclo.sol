// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataArbitrumTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "cyWETH.pyth", "WETH", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "cyWBTC.pyth", "WBTC", 8);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cycbBTC.pyth", "cbBTC", 8);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "WBTC.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cbBTC.pyth");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "WBTC.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cbBTC.pyth");
    }
}
