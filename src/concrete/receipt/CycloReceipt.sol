// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {ERC1155, Receipt, DATA_URI_BASE64_PREFIX} from "ethgild/concrete/receipt/Receipt.sol";
import {IReceiptVaultV1} from "ethgild/interface/IReceiptVaultV1.sol";
import {ZeroReceiptId} from "../../error/ErrCycloReceipt.sol";

/// @dev The SVG of Cyclo logo is pinned on IPFS.
string constant CYCLO_RECEIPT_SVG_URI = "ipfs://bafybeidjgkxfpk7nujlnx7jwvjvmtcbkfg53vnlc2cc6ftqfhapqkmtahq";

/// @dev The Cyclo brand name.
string constant CYCLO_BRAND_NAME = "Cyclo";

/// @dev The URL to redeem Cyclo token.
string constant CYCLO_REDEEM_URL = "https://cyclo.finance";

contract CycloReceipt is Receipt {
    function redeemURL() internal pure virtual override returns (string memory) {
        return CYCLO_RECEIPT_SVG_URI;
    }

    function brandName() internal pure virtual override returns (string memory) {
        return CYCLO_BRAND_NAME;
    }
}
