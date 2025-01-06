// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

contract CycloVault is ERC20PriceOracleReceiptVault {
    constructor(ReceiptVaultConstructionConfig memory config) ERC20PriceOracleReceiptVault(config) {}

    function name() public view virtual override returns (string memory) {
        return string.concat("Cyclo ", symbol());
    }

    function symbol() public view virtual override returns (string memory) {
        return string.concat("cy", IERC20Metadata(asset()).symbol());
    }
}
