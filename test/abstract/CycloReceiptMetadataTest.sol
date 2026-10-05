// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {Base64} from "solady-0.1.26/src/utils/Base64.sol";
import {ICycloReceipt, ZeroReceiptId} from "test/interface/ICycloReceipt.sol";
import {PROD_CYSFLR_RECEIPT_SYMBOL, PROD_CYSFLR_RECEIPT_NAME} from "test/lib/LibCycloTestProd.sol";

string constant DATA_URI_BASE64_PREFIX = "data:application/json;base64,";
string constant CYCLO_RECEIPT_SVG_URI = "ipfs://bafybeidjgkxfpk7nujlnx7jwvjvmtcbkfg53vnlc2cc6ftqfhapqkmtahq";

/// Receipt metadata checks against a receipt address.
abstract contract CycloReceiptMetadataTest is Test {
    struct MetadataWithImage {
        uint8 decimals;
        string description;
        string image;
        string name;
    }

    function decodeMetadataURIWithImage(string memory uri) internal pure returns (MetadataWithImage memory) {
        uint256 uriLength = bytes(uri).length;
        uint256 prefixLength = bytes(DATA_URI_BASE64_PREFIX).length;
        assembly ("memory-safe") {
            mstore(uri, prefixLength)
        }
        assertEq(uri, DATA_URI_BASE64_PREFIX);
        assembly ("memory-safe") {
            uri := add(uri, prefixLength)
            mstore(uri, sub(uriLength, prefixLength))
        }
        return abi.decode(vm.parseJson(string(Base64.decode(uri))), (MetadataWithImage));
    }

    function checkCycloReceiptURIZeroId(address cycloReceipt) internal {
        vm.expectRevert(abi.encodeWithSelector(ZeroReceiptId.selector));
        ICycloReceipt(cycloReceipt).uri(0);
    }

    function checkCycloReceiptURIV1(address cycloReceipt) internal view {
        MetadataWithImage memory metadata = decodeMetadataURIWithImage(ICycloReceipt(cycloReceipt).uri(0.01544e18));

        assertEq(metadata.decimals, 18);
        assertEq(
            metadata.description,
            "1 of these receipts can be burned alongside 1 cysFLR to redeem 64.766839378238341968 sFLR. Reedem at https://cyclo.finance."
        );
        assertEq(metadata.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(metadata.name, "Receipt for Cyclo lock at 0.01544 USD per sFLR.");
    }

    function checkCycloReceiptURIV2(
        address cycloReceipt,
        string memory shareSymbol,
        string memory assetSymbol,
        uint8 decimals
    ) internal view {
        MetadataWithImage memory metadata = decodeMetadataURIWithImage(ICycloReceipt(cycloReceipt).uri(0.01544e18));

        assertEq(metadata.decimals, decimals);
        assertEq(
            metadata.description,
            string.concat(
                "1 of these receipts can be burned alongside 1 ",
                shareSymbol,
                " to redeem 64.766839378238341968 of ",
                assetSymbol,
                ". Redeem at https://cyclo.finance."
            )
        );
        assertEq(metadata.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(metadata.name, string.concat("Receipt for Cyclo lock at 0.01544 USD per ", assetSymbol, "."));
    }

    function checkCycloReceiptNameV1(address cycloReceipt) internal view {
        assertEq(ICycloReceipt(cycloReceipt).name(), PROD_CYSFLR_RECEIPT_NAME);
    }

    function checkCycloReceiptNameV2(address cycloReceipt, string memory assetSymbol) internal view {
        assertEq(ICycloReceipt(cycloReceipt).name(), string.concat("cy", assetSymbol, " Receipt"));
    }

    function checkCycloReceiptSymbolV1(address cycloReceipt) internal view {
        assertEq(ICycloReceipt(cycloReceipt).symbol(), PROD_CYSFLR_RECEIPT_SYMBOL);
    }

    function checkCycloReceiptSymbolV2(address cycloReceipt, string memory assetSymbol) internal view {
        assertEq(ICycloReceipt(cycloReceipt).symbol(), string.concat("cy", assetSymbol, " RCPT"));
    }

    function checkCycloReceiptURIVariesWithId(address cycloReceipt) internal view {
        MetadataWithImage memory m1 = decodeMetadataURIWithImage(ICycloReceipt(cycloReceipt).uri(0.01544e18));
        MetadataWithImage memory m2 = decodeMetadataURIWithImage(ICycloReceipt(cycloReceipt).uri(0.03088e18));
        assertTrue(
            keccak256(bytes(m1.description)) != keccak256(bytes(m2.description)), "description should differ by priceId"
        );
        assertTrue(keccak256(bytes(m1.name)) != keccak256(bytes(m2.name)), "name should differ by priceId");
        assertEq(m1.decimals, m2.decimals);
        assertEq(m1.image, m2.image);
    }
}
