// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Vm} from "forge-std/Vm.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {CycloVault} from "src/concrete/vault/CycloVault.sol";

uint256 constant FLARE_CHAIN_ID = 14;
uint256 constant ARBITRUM_CHAIN_ID = 42161;

string constant CYCLO_SITE_TOKENS_JSON_PATH = "./canonical/cyclo-site-tokens.json";

/// Mirrors `cyclofinance/cyclo.site:src/lib/stores.ts`'s `CyToken` shape.
/// Field order is alphabetical to match foundry's parseJson decoding rules.
struct TokenEntry {
    bool active;
    uint256 chainId;
    uint256 decimals;
    string name;
    string networkName;
    address receiptAddress;
    string symbol;
    address underlyingAddress;
    uint256 underlyingDecimals;
    string underlyingSymbol;
    address vaultAddress;
}

library LibCycloSiteTokens {
    function loadAll(Vm vm) internal view returns (TokenEntry[] memory) {
        string memory json = vm.readFile(CYCLO_SITE_TOKENS_JSON_PATH);
        bytes memory data = vm.parseJson(json, ".tokens");
        return abi.decode(data, (TokenEntry[]));
    }

    /// Asserts that for every entry on `expectedChainId`:
    ///   - the vault's on-chain `decimals()` matches the JSON's `decimals`
    ///   - the underlying's on-chain `decimals()` matches `underlyingDecimals`
    ///   - the vault's on-chain `symbol()` matches `symbol`
    ///   - the underlying's on-chain `symbol()` matches `underlyingSymbol`
    ///   - the vault's on-chain `asset()` matches the declared `underlyingAddress`
    ///   - the JSON's `name` mirrors the JSON's `symbol` (the site uses `name`
    ///     as a display label and we keep the two in sync; the on-chain
    ///     `vault.name()` is a longer rendered string and is not asserted)
    /// Reverts with the entry's `name` in the failure message so the operator
    /// can locate the drift quickly.
    function assertOnChainMatchesJson(Vm vm, uint256 expectedChainId) internal view {
        TokenEntry[] memory entries = loadAll(vm);
        uint256 verified = 0;
        for (uint256 i = 0; i < entries.length; i++) {
            TokenEntry memory entry = entries[i];
            if (entry.chainId != expectedChainId) continue;
            verified++;

            uint256 actualVaultDecimals = uint256(IERC20Metadata(entry.vaultAddress).decimals());
            require(actualVaultDecimals == entry.decimals, string.concat("vault decimals mismatch for ", entry.name));

            uint256 actualUnderlyingDecimals = uint256(IERC20Metadata(entry.underlyingAddress).decimals());
            require(
                actualUnderlyingDecimals == entry.underlyingDecimals,
                string.concat("underlying decimals mismatch for ", entry.name)
            );

            string memory actualVaultSymbol = IERC20Metadata(entry.vaultAddress).symbol();
            require(
                keccak256(bytes(actualVaultSymbol)) == keccak256(bytes(entry.symbol)),
                string.concat("vault symbol mismatch for ", entry.name)
            );

            string memory actualUnderlyingSymbol = IERC20Metadata(entry.underlyingAddress).symbol();
            require(
                keccak256(bytes(actualUnderlyingSymbol)) == keccak256(bytes(entry.underlyingSymbol)),
                string.concat("underlying symbol mismatch for ", entry.name)
            );

            address actualAsset = address(CycloVault(payable(entry.vaultAddress)).asset());
            require(actualAsset == entry.underlyingAddress, string.concat("vault.asset() mismatch for ", entry.name));

            require(
                keccak256(bytes(entry.name)) == keccak256(bytes(entry.symbol)),
                string.concat("JSON name/symbol mismatch for ", entry.name)
            );
        }
        require(verified > 0, "no JSON entries matched the requested chainId");
    }
}
