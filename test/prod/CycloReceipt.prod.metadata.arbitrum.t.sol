// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYLINK_PYTH,
    PROD_ARBITRUM_RECEIPT_CYDOT_PYTH,
    PROD_ARBITRUM_RECEIPT_CYUNI_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYENA_PYTH,
    PROD_ARBITRUM_RECEIPT_CYARB_PYTH,
    PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloReceiptMetadataTest} from "test/src/concrete/receipt/CycloReceipt.metadata.t.sol";

contract CycloReceiptProdMetadataArbitrumTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "cyWETH.pyth", "WETH", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH, "cywstETH.pyth", "wstETH", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "cyWBTC.pyth", "WBTC", 8);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cycbBTC.pyth", "cbBTC", 8);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYLINK_PYTH, "cyLINK.pyth", "LINK", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYDOT_PYTH, "cyDOT.pyth", "DOT", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYUNI_PYTH, "cyUNI.pyth", "UNI", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH, "cyPEPE.pyth", "PEPE", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH, "cyPYTH.pyth", "PYTH", 6);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYENA_PYTH, "cyENA.pyth", "ENA", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYARB_PYTH, "cyARB.pyth", "ARB", 18);
        checkCycloReceiptURIV2(PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH, "cyXAUt0.pyth", "XAUt0", 6);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH, "wstETH.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "WBTC.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cbBTC.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYLINK_PYTH, "LINK.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYDOT_PYTH, "DOT.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYUNI_PYTH, "UNI.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH, "PEPE.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH, "PYTH.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYENA_PYTH, "ENA.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYARB_PYTH, "ARB.pyth");
        checkCycloReceiptNameV2(PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH, "XAUt0.pyth");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, "WETH.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH, "wstETH.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, "WBTC.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, "cbBTC.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYLINK_PYTH, "LINK.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYDOT_PYTH, "DOT.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYUNI_PYTH, "UNI.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH, "PEPE.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH, "PYTH.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYENA_PYTH, "ENA.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYARB_PYTH, "ARB.pyth");
        checkCycloReceiptSymbolV2(PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH, "XAUt0.pyth");
    }
}
