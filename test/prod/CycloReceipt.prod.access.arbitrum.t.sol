// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {
    PROD_ARBITRUM_VAULT_CYWETH_PYTH,
    PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYWBTC_PYTH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {IReceiptV2} from "ethgild/interface/deprecated/IReceiptV2.sol";

contract CycloReceiptProdAccessFlareTest is Test {
    function checkAccess(address receiptAddress, address vaultAddress, string memory asset) internal view {
        address manager = IReceiptV2(receiptAddress).manager();
        assertEq(manager, vaultAddress, string.concat(asset, " manager should be vault"));
    }

    function testProdCycloReceiptManagerFlare() external {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        checkAccess(PROD_ARBITRUM_RECEIPT_CYWETH_PYTH, PROD_ARBITRUM_VAULT_CYWETH_PYTH, "cyWETH");
        checkAccess(PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, "cyWBTC");
        checkAccess(PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, "cyCBBTC");
    }
}
