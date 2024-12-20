// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {ERC1155, Receipt, DATA_URI_BASE64_PREFIX} from "ethgild/concrete/receipt/Receipt.sol";
import {Base64Upgradeable as Base64} from "openzeppelin-contracts-upgradeable/contracts/utils/Base64Upgradeable.sol";
import {
    LibFixedPointDecimalArithmeticOpenZeppelin,
    Math
} from "rain.math.fixedpoint/lib/LibFixedPointDecimalArithmeticOpenZeppelin.sol";
import {LibFixedPointDecimalFormat} from "rain.math.fixedpoint/lib/format/LibFixedPointDecimalFormat.sol";
import {FIXED_POINT_ONE} from "rain.math.fixedpoint/lib/FixedPointDecimalConstants.sol";
import {ZeroReceiptId} from "../../error/ErrCycloReceipt.sol";

/// @dev The SVG of Cyclo logo is pinned on IPFS.
string constant CYCLO_RECEIPT_SVG_URI = "ipfs://bafybeidjgkxfpk7nujlnx7jwvjvmtcbkfg53vnlc2cc6ftqfhapqkmtahq";

/// @dev The name of Cyclo receipt is "cysFLR Receipt".
string constant CYCLO_RECEIPT_NAME = "cysFLR Receipt";

/// @dev The symbol of Cyclo receipt is "cysFLR RCPT".
string constant CYCLO_RECEIPT_SYMBOL = "cysFLR RCPT";

contract CycloReceipt is Receipt {
    /// @inheritdoc ERC1155
    function uri(uint256 id) public view virtual override returns (string memory) {
        if (id == 0) {
            revert ZeroReceiptId();
        }
        bytes memory json = bytes(
            string.concat(
                "{\"decimals\":18,\"description\":\"1 of these receipts can be burned alongside 1 cysFLR to redeem ",
                LibFixedPointDecimalFormat.fixedPointToDecimalString(
                    LibFixedPointDecimalArithmeticOpenZeppelin.fixedPointDiv(FIXED_POINT_ONE, id, Math.Rounding.Down)
                ),
                " sFLR. Reedem at https://cyclo.finance.\",\"image\":\"",
                CYCLO_RECEIPT_SVG_URI,
                "\",\"name\":\"Receipt for Cyclo lock at ",
                LibFixedPointDecimalFormat.fixedPointToDecimalString(id),
                " USD per sFLR.\"}"
            )
        );

        return string.concat(DATA_URI_BASE64_PREFIX, Base64.encode(json));
    }

    /// @inheritdoc Receipt
    function name() public pure virtual override returns (string memory) {
        return CYCLO_RECEIPT_NAME;
    }

    /// @inheritdoc Receipt
    function symbol() public pure virtual override returns (string memory) {
        return CYCLO_RECEIPT_SYMBOL;
    }
}
