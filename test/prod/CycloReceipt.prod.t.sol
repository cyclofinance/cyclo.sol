// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {PROD_FLARE_VAULT_CYSFLR} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_LATEST,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
} from "src/lib/LibCycloProdReceipt.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibExtrospectERC1167Proxy} from "rain.extrospection/lib/LibExtrospectERC1167Proxy.sol";

contract CycloReceiptProdTest is Test {
    function checkProdCycloReceiptBytecode(
        address proxy,
        address expectedImplementation,
        bytes32 expectedImplementationCodehash
    ) internal view {
        (bool isProxy, address implementation) = LibExtrospectERC1167Proxy.isERC1167Proxy(proxy.code);
        assertTrue(isProxy);
        assertEq(implementation, expectedImplementation);

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(expectedImplementation, expectedImplementationCodehash);
    }

    function checkProdCycloReceiptIsInitialized(address receipt) internal {
        LibCycloTestProd.createSelectFork(vm);
        vm.expectRevert("Initializable: contract is already initialized");
        CycloReceipt(receipt).initialize("");
    }

    function testProdCycloReceiptBytecode() external {
        CycloReceipt fresh = new CycloReceipt();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_FLARE_CYCLO_RECEIPT_CODEHASH_LATEST);

        LibCycloTestProd.createSelectFork(vm);

        checkProdCycloReceiptBytecode(
            PROD_FLARE_RECEIPT_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
        checkProdCycloReceiptBytecode(
            PROD_FLARE_RECEIPT_CYWETH, PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1, PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1
        );
    }

    function testProdCycloReceiptIsInitializedCysFLR() external {
        checkProdCycloReceiptIsInitialized(PROD_FLARE_RECEIPT_CYSFLR);
    }

    function testProdCycloReceiptIsInitializedCYWETH() external {
        checkProdCycloReceiptIsInitialized(PROD_FLARE_RECEIPT_CYWETH);
    }

    fallback() external payable {}

    receive() external payable {}
}
