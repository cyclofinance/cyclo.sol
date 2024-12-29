// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {Base64} from "solady/utils/Base64.sol";
import {
    CycloReceipt,
    DATA_URI_BASE64_PREFIX,
    CYCLO_RECEIPT_SVG_URI
} from "src/concrete/receipt/CycloReceipt.sol";
import {
    PROD_CYSFLR_RECEIPT_SYMBOL,
    PROD_CYSFLR_RECEIPT_NAME
} from "test/lib/LibCycloTestProd.sol";
import {ZeroReceiptId} from "src/error/ErrCycloReceipt.sol";

contract CycloReceiptMetadataTest is Test {
    struct URIJson {
        uint8 decimals;
        string description;
        string image;
        string name;
    }

    function checkCycloReceiptURIZeroId(address cycloReceipt) internal {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        vm.expectRevert(abi.encodeWithSelector(ZeroReceiptId.selector));
        receipt.uri(0);
    }

    function checkCycloReceiptURI(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        string memory uri = receipt.uri(0.01544e18);
        uint256 uriLength = bytes(uri).length;
        assembly ("memory-safe") {
            mstore(uri, 29)
        }
        assertEq(uri, DATA_URI_BASE64_PREFIX);
        assembly ("memory-safe") {
            uri := add(uri, 29)
            mstore(uri, sub(uriLength, 29))
        }

        string memory uriDecoded = string(Base64.decode(uri));
        bytes memory uriJsonData = vm.parseJson(uriDecoded);

        URIJson memory uriJson = abi.decode(uriJsonData, (URIJson));
        assertEq(uriJson.decimals, 18);
        assertEq(
            uriJson.description,
            "1 of these receipts can be burned alongside 1 cysFLR to redeem 64.766839378238341968 sFLR. Reedem at https://cyclo.finance."
        );
        assertEq(uriJson.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(uriJson.name, "Receipt for Cyclo lock at 0.01544 USD per sFLR.");
    }

    function checkCycloReceiptName(address cycloReceipt) internal pure {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.name(), PROD_CYSFLR_RECEIPT_NAME);
    }

    function checkCycloReceiptSymbol(address cycloReceipt) internal pure {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.symbol(), PROD_CYSFLR_RECEIPT_SYMBOL);
    }

    function testCycloReceiptURI() external {
        CycloReceipt receipt = new CycloReceipt();

        checkCycloReceiptURI(address(receipt));
    }

    function testCycloReceiptName() external {
        CycloReceipt receipt = new CycloReceipt();

        checkCycloReceiptName(address(receipt));
    }

    function testCycloReceiptSymbol() external {
        CycloReceipt receipt = new CycloReceipt();

        checkCycloReceiptSymbol(address(receipt));
    }
}
