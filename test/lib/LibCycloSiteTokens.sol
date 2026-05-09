// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Vm} from "forge-std/Vm.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {IERC165Upgradeable as IERC165} from
    "openzeppelin-contracts-upgradeable/contracts/utils/introspection/IERC165Upgradeable.sol";
import {IERC1155Upgradeable as IERC1155} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC1155/IERC1155Upgradeable.sol";
import {CycloVault} from "src/concrete/vault/CycloVault.sol";
import {IReceiptV3} from "ethgild/interface/IReceiptV3.sol";
import {PROD_FLARE_VAULT_CYSFLR} from "src/lib/LibCycloProdVault.sol";

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
    ///   - the on-chain `block.chainid` matches `expectedChainId` (catches
    ///     mistakenly forking to the wrong chain)
    ///   - no two entries share the same `vaultAddress` or `receiptAddress`
    ///   - the entry's `networkName` matches `expectedNetworkName`
    ///   - `vaultAddress` is non-zero and has bytecode
    ///   - the vault's on-chain `name()` matches `name`
    ///   - the vault's on-chain `decimals()` matches the JSON's `decimals`
    ///   - the underlying's on-chain `decimals()` matches `underlyingDecimals`
    ///   - the vault's on-chain `symbol()` matches `symbol`
    ///   - the underlying's on-chain `symbol()` matches `underlyingSymbol`
    ///   - the vault's on-chain `asset()` matches the declared `underlyingAddress`
    ///   - the receipt supports the ERC1155 interface
    ///   - `receiptAddress.manager()` points back at the vault (works for every
    ///     entry, including `cysFLR`)
    ///   - the vault's on-chain `receipt()` matches the declared `receiptAddress`,
    ///     except for `cysFLR` whose older impl does not expose the getter
    ///     (tracked at cyclo.sol#43)
    /// Reverts with the entry's `name` in the failure message so the operator
    /// can locate the drift quickly.
    function assertOnChainMatchesJson(Vm vm, uint256 expectedChainId, string memory expectedNetworkName)
        internal
        view
    {
        require(block.chainid == expectedChainId, "fork is on wrong chain");

        TokenEntry[] memory entries = loadAll(vm);
        uint256 verified = 0;
        for (uint256 i = 0; i < entries.length; i++) {
            TokenEntry memory entry = entries[i];
            if (entry.chainId != expectedChainId) continue;
            verified++;

            for (uint256 j = i + 1; j < entries.length; j++) {
                if (entries[j].chainId != expectedChainId) continue;
                require(
                    entries[j].vaultAddress != entry.vaultAddress,
                    string.concat("duplicate vaultAddress for ", entry.name)
                );
                require(
                    entries[j].receiptAddress != entry.receiptAddress,
                    string.concat("duplicate receiptAddress for ", entry.name)
                );
            }

            require(
                keccak256(bytes(entry.networkName)) == keccak256(bytes(expectedNetworkName)),
                string.concat("networkName mismatch for ", entry.name)
            );

            require(entry.vaultAddress != address(0), string.concat("vaultAddress is zero for ", entry.name));
            require(
                entry.vaultAddress.code.length > 0,
                string.concat("vaultAddress has no bytecode for ", entry.name)
            );

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

            string memory actualVaultName = IERC20Metadata(entry.vaultAddress).name();
            require(
                keccak256(bytes(actualVaultName)) == keccak256(bytes(entry.name)),
                string.concat("vault name mismatch for ", entry.name)
            );

            address actualAsset = address(CycloVault(payable(entry.vaultAddress)).asset());
            require(actualAsset == entry.underlyingAddress, string.concat("vault.asset() mismatch for ", entry.name));

            require(
                IERC165(entry.receiptAddress).supportsInterface(type(IERC1155).interfaceId),
                string.concat("receipt does not support ERC1155 for ", entry.name)
            );

            address receiptManager = IReceiptV3(entry.receiptAddress).manager();
            require(
                receiptManager == entry.vaultAddress,
                string.concat("receipt.manager() does not point at vault for ", entry.name)
            );

            if (entry.vaultAddress != PROD_FLARE_VAULT_CYSFLR) {
                address actualReceipt = address(CycloVault(payable(entry.vaultAddress)).receipt());
                require(
                    actualReceipt == entry.receiptAddress,
                    string.concat("vault.receipt() mismatch for ", entry.name)
                );
            }
        }
        require(verified > 0, "no JSON entries matched the requested chainId");
    }
}
