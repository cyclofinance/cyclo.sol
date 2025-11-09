// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfigV2,
    IPriceOracleV2,
    ERC20PriceOracleVaultConfig,
    VaultConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {ERC20} from "ethgild/abstract/ReceiptVault.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {IntOrAString, LibIntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";
import {console2} from "forge-std/console2.sol";

/// @title CycloVaultConfig
/// Configuration for the CycloVault contract initializer.
/// @param priceOracle The price oracle to use for the vault.
/// @param asset The asset that the vault will hold.
/// @param oracleName The name to use in the vault's name metadata.
/// @param oracleSymbol The symbol suffix to use in the vault's symbol metadata.
struct CycloVaultConfig {
    IPriceOracleV2 priceOracle;
    address asset;
    string oracleName;
    string oracleSymbol;
}

/// @title CycloVault
/// Extends and simplifies ERC20PriceOracleReceiptVault for Cyclo deployments.
/// Ensures that for a given oracle and asset combination, the metadata is all
/// handled in a consistent way e.g. the name is "Cyclo <vault symbol>" and the
/// symbol is "cy<asset symbol>" with an optional ".<oracle symbol>" disambiguator.
contract CycloVault is ERC20PriceOracleReceiptVault {
    using LibIntOrAString for IntOrAString;

    /// @notice Oracle name used in metadata generation.
    string internal oracleName;
    /// @notice Oracle symbol used in metadata generation.
    string internal oracleSymbol;

    constructor(ReceiptVaultConstructionConfigV2 memory config) ERC20PriceOracleReceiptVault(config) {}

    /// @inheritdoc ERC20PriceOracleReceiptVault
    function initialize(bytes memory data) public virtual override returns (bytes32) {
        CycloVaultConfig memory config = abi.decode(data, (CycloVaultConfig));
        oracleName = config.oracleName;
        oracleSymbol = config.oracleSymbol;
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

    /// @inheritdoc ERC20
    function name() public view virtual override returns (string memory) {
        return string.concat(
            "Cyclo ", symbol(), bytes(oracleName).length == 0 ? "" : string.concat(" (", oracleName, " oracle)")
        );
    }

    /// @inheritdoc ERC20
    function symbol() public view virtual override returns (string memory) {
        console2.log(asset(), "asset");
        return string.concat(
            "cy", IERC20Metadata(asset()).symbol(), bytes(oracleSymbol).length == 0 ? "" : ".", oracleSymbol
        );
    }
}
