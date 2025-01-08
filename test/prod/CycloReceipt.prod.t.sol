// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_RECEIPT_CYSFLR
} from "src/lib/LibCycloProdDeployment.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {PROD_CYCLO_RECEIPT_IMPLEMENTATION_EXPECTED_CODE} from "src/lib/LibCycloProdBytecode.sol";

contract CycloReceiptProdTest is Test {
    function testProdCycloReceiptBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        address proxy = PROD_FLARE_RECEIPT_CYSFLR;
        bytes memory proxyCode = proxy.code;
        address implementation;
        assembly {
            implementation := mload(add(proxyCode, 30))
        }

        assertEq(implementation.code, PROD_CYCLO_RECEIPT_IMPLEMENTATION_EXPECTED_CODE);
        assertEq(implementation, PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR);

        bytes memory expectedProxyCode =
            abi.encodePacked(hex"363d3d373d3d3d363d73", implementation, hex"5af43d82803e903d91602b57fd5bf3");

        assertEq(proxyCode, expectedProxyCode);
    }

    function testProdCycloReceiptManager() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(CycloReceipt(PROD_FLARE_RECEIPT_CYSFLR).manager(), PROD_FLARE_VAULT_CYSFLR);
    }

    function testProdCycloReceiptIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);

        CycloReceipt receipt = CycloReceipt(PROD_FLARE_RECEIPT_CYSFLR);
        vm.expectRevert("Initializable: contract is already initialized");
        receipt.initialize("");
    }

    fallback() external payable {}

    receive() external payable {}
}
