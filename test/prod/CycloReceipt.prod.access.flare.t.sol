// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {
    PROD_FLARE_VAULT_CYSFLR, PROD_FLARE_VAULT_CYWETH, PROD_FLARE_VAULT_CYFXRP
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_RECEIPT_CYFXRP
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {IReceiptV2} from "ethgild/interface/deprecated/IReceiptV2.sol";

contract CycloReceiptProdAccessFlareTest is Test {
    function checkAccess(address receiptAddress, address vaultAddress, string memory asset) internal view {
        address manager = IReceiptV2(receiptAddress).manager();
        assertEq(manager, vaultAddress, string.concat(asset, " manager should be vault"));
    }

    function testProdCycloReceiptManagerFlare() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkAccess(PROD_FLARE_RECEIPT_CYSFLR, PROD_FLARE_VAULT_CYSFLR, "cysFLR");
        checkAccess(PROD_FLARE_RECEIPT_CYWETH, PROD_FLARE_VAULT_CYWETH, "cyWETH");
        checkAccess(PROD_FLARE_RECEIPT_CYFXRP, PROD_FLARE_VAULT_CYFXRP, "cyFXRPC");
    }
}
