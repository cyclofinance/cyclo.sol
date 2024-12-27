// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {PROD_CYCLO_RECEIPT_ADDRESS, PROD_CYCLO_VAULT_ADDRESS} from "src/lib/LibCycloProd.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {IReceiptV2} from "ethgild/interface/IReceiptV2.sol";

contract CycloReceiptProdAccessTest is Test {
    function testProdCycloReceiptManager() external {
        LibCycloTestProd.createSelectFork(vm);

        address manager = IReceiptV2(PROD_CYCLO_RECEIPT_ADDRESS).manager();

        assertEq(manager, PROD_CYCLO_VAULT_ADDRESS);
    }
}
