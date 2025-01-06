// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig,
    IPriceOracleV2,
    ERC20PriceOracleVaultConfig,
    VaultConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

struct CycloVaultConfig {
    IPriceOracleV2 priceOracle;
    address asset;
}

contract CycloVault is ERC20PriceOracleReceiptVault {
    constructor(ReceiptVaultConstructionConfig memory config) ERC20PriceOracleReceiptVault(config) {}

    function initialize(bytes memory data) public virtual override returns (bytes32) {
        CycloVaultConfig memory config = abi.decode(data, (CycloVaultConfig));
        return super.initialize(
            abi.encode(
                ERC20PriceOracleVaultConfig({
                    priceOracle: config.priceOracle,
                    vaultConfig: VaultConfig({
                        asset: config.asset,
                        // These will be ignored because the getters are overridden.
                        name: "",
                        symbol: ""
                    })
                })
            )
        );
    }

    function name() public view virtual override returns (string memory) {
        return string.concat("Cyclo ", symbol());
    }

    function symbol() public view virtual override returns (string memory) {
        return string.concat("cy", IERC20Metadata(asset()).symbol());
    }
}
