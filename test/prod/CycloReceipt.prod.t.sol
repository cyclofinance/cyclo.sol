// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {
    LibCycloProd,
    PROD_CYCLO_RECEIPT_ADDRESS,
    PROD_CYCLO_VAULT_ADDRESS,
    PROD_CYCLO_RECEIPT_IMPLEMENTATION_ADDRESS
} from "test/lib/LibCycloProd.sol";

contract CycloReceiptProdTest is Test {
    function testProdCycloReceiptBytecode() external {
        LibCycloProd.createSelectFork(vm);

        CycloReceipt fresh = new CycloReceipt();

        address proxy = PROD_CYCLO_RECEIPT_ADDRESS;
        bytes memory proxyCode = proxy.code;
        address implementation;
        assembly {
            implementation := mload(add(proxyCode, 30))
        }

        assertEq(implementation.code, address(fresh).code);
        assertEq(implementation, PROD_CYCLO_RECEIPT_IMPLEMENTATION_ADDRESS);

        bytes memory expectedProxyCode =
            abi.encodePacked(hex"363d3d373d3d3d363d73", implementation, hex"5af43d82803e903d91602b57fd5bf3");

        assertEq(proxyCode, expectedProxyCode);
    }

    function testProdCycloReceiptManager() external {
        LibCycloProd.createSelectFork(vm);

        assertEq(CycloReceipt(PROD_CYCLO_RECEIPT_ADDRESS).manager(), PROD_CYCLO_VAULT_ADDRESS);
    }

    fallback() external payable {}

    receive() external payable {}
}
