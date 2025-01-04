// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {ERC20PriceOracleReceipt} from "ethgild/concrete/receipt/ERC20PriceOracleReceipt.sol";

/// @dev The SVG of Cyclo logo is pinned on IPFS.
string constant CYCLO_RECEIPT_SVG_URI = "ipfs://bafybeidjgkxfpk7nujlnx7jwvjvmtcbkfg53vnlc2cc6ftqfhapqkmtahq";

/// @dev The Cyclo brand name.
string constant CYCLO_BRAND_NAME = "Cyclo";

/// @dev The URL to redeem Cyclo token.
string constant CYCLO_REDEEM_URL = "https://cyclo.finance";

contract CycloReceipt is ERC20PriceOracleReceipt {
    function _redeemURL() internal pure virtual override returns (string memory) {
        return CYCLO_RECEIPT_SVG_URI;
    }

    function _brandName() internal pure virtual override returns (string memory) {
        return CYCLO_BRAND_NAME;
    }

    function _receiptSVGURI() internal pure virtual override returns (string memory) {
        return CYCLO_RECEIPT_SVG_URI;
    }
}
