// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibCycloSiteTokens, TokenEntry, ARBITRUM_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";
import {CycloVault, CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";
import {
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_ARBITRUM_VAULT_CYWETH_PYTH,
    PROD_ARBITRUM_VAULT_CYWSTETH_PYTH,
    PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYLINK_PYTH,
    PROD_ARBITRUM_VAULT_CYDOT_PYTH,
    PROD_ARBITRUM_VAULT_CYUNI_PYTH,
    PROD_ARBITRUM_VAULT_CYPEPE_PYTH,
    PROD_ARBITRUM_VAULT_CYPYTH_PYTH,
    PROD_ARBITRUM_VAULT_CYENA_PYTH,
    PROD_ARBITRUM_VAULT_CYARB_PYTH,
    PROD_ARBITRUM_VAULT_CYXAUT_PYTH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2,
    PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
    PROD_ARBITRUM_RECEIPT_CYLINK_PYTH,
    PROD_ARBITRUM_RECEIPT_CYDOT_PYTH,
    PROD_ARBITRUM_RECEIPT_CYUNI_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH,
    PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH,
    PROD_ARBITRUM_RECEIPT_CYENA_PYTH,
    PROD_ARBITRUM_RECEIPT_CYARB_PYTH,
    PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_PYTH_ORACLE_WETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM,
    PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM,
    PROD_PYTH_ORACLE_LINK_USD_ARBITRUM,
    PROD_PYTH_ORACLE_DOT_USD_ARBITRUM,
    PROD_PYTH_ORACLE_UNI_USD_ARBITRUM,
    PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM,
    PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_ENA_USD_ARBITRUM,
    PROD_PYTH_ORACLE_ARB_USD_ARBITRUM,
    PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM
} from "src/lib/LibCycloProdOracle.sol";

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Arbitrum entry's
/// on-chain shape matches the JSON. Pins per-entry deployment details against
/// the prod constants in `LibCycloProd*.sol`:
///   - vaultAddress → expected vault impl + codehash (1167 proxy check)
///   - vaultAddress → expected priceOracle
///   - receiptAddress → expected receipt impl + codehash (1167 proxy check)
contract CycloSiteTokensProdArbitrumTest is Test {
    mapping(address => bool) internal knownVaults;
    mapping(address => bool) internal expectedActive;
    mapping(address => address) internal expectedVaultImpl;
    mapping(address => bytes32) internal expectedVaultCodehash;
    mapping(address => address) internal expectedVaultOracle;
    mapping(address => address) internal expectedReceiptImpl;
    mapping(address => bytes32) internal expectedReceiptCodehash;

    function setUp() public {
        LibCycloTestProd.createSelectForkArbitrum(vm);

        // Every Arbitrum cyToken vault is a 1167 proxy to the V2 impl.
        address[12] memory vaults = [
            PROD_ARBITRUM_VAULT_CYWETH_PYTH,
            PROD_ARBITRUM_VAULT_CYWSTETH_PYTH,
            PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
            PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
            PROD_ARBITRUM_VAULT_CYLINK_PYTH,
            PROD_ARBITRUM_VAULT_CYDOT_PYTH,
            PROD_ARBITRUM_VAULT_CYUNI_PYTH,
            PROD_ARBITRUM_VAULT_CYPEPE_PYTH,
            PROD_ARBITRUM_VAULT_CYPYTH_PYTH,
            PROD_ARBITRUM_VAULT_CYENA_PYTH,
            PROD_ARBITRUM_VAULT_CYARB_PYTH,
            PROD_ARBITRUM_VAULT_CYXAUT_PYTH
        ];
        for (uint256 i = 0; i < vaults.length; i++) {
            knownVaults[vaults[i]] = true;
            expectedVaultImpl[vaults[i]] = PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2;
            expectedVaultCodehash[vaults[i]] = PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH;
        }

        expectedActive[PROD_ARBITRUM_VAULT_CYWETH_PYTH] = true;
        expectedActive[PROD_ARBITRUM_VAULT_CYWBTC_PYTH] = true;
        expectedActive[PROD_ARBITRUM_VAULT_CYARB_PYTH] = true;

        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYWETH_PYTH] = PROD_PYTH_ORACLE_WETH_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYWSTETH_PYTH] = PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYWBTC_PYTH] = PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYCBBTC_PYTH] = PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYLINK_PYTH] = PROD_PYTH_ORACLE_LINK_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYDOT_PYTH] = PROD_PYTH_ORACLE_DOT_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYUNI_PYTH] = PROD_PYTH_ORACLE_UNI_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYPEPE_PYTH] = PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYPYTH_PYTH] = PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYENA_PYTH] = PROD_PYTH_ORACLE_ENA_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYARB_PYTH] = PROD_PYTH_ORACLE_ARB_USD_ARBITRUM;
        expectedVaultOracle[PROD_ARBITRUM_VAULT_CYXAUT_PYTH] = PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM;

        // Every Arbitrum receipt is a 1167 proxy to the V2 receipt impl.
        address[12] memory receipts = [
            PROD_ARBITRUM_RECEIPT_CYWETH_PYTH,
            PROD_ARBITRUM_RECEIPT_CYWSTETH_PYTH,
            PROD_ARBITRUM_RECEIPT_CYWBTC_PYTH,
            PROD_ARBITRUM_RECEIPT_CYCBBTC_PYTH,
            PROD_ARBITRUM_RECEIPT_CYLINK_PYTH,
            PROD_ARBITRUM_RECEIPT_CYDOT_PYTH,
            PROD_ARBITRUM_RECEIPT_CYUNI_PYTH,
            PROD_ARBITRUM_RECEIPT_CYPEPE_PYTH,
            PROD_ARBITRUM_RECEIPT_CYPYTH_PYTH,
            PROD_ARBITRUM_RECEIPT_CYENA_PYTH,
            PROD_ARBITRUM_RECEIPT_CYARB_PYTH,
            PROD_ARBITRUM_RECEIPT_CYXAUT_PYTH
        ];
        for (uint256 i = 0; i < receipts.length; i++) {
            expectedReceiptImpl[receipts[i]] = PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2;
            expectedReceiptCodehash[receipts[i]] = PROD_ARBITRUM_CYCLO_RECEIPT_CODEHASH_V2;
        }
    }

    function testCycloSiteTokensArbitrum() external {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, ARBITRUM_CHAIN_ID, "Arbitrum One");

        TokenEntry[] memory entries = LibCycloSiteTokens.loadAll(vm);
        uint256 chainEntries = 0;
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId == ARBITRUM_CHAIN_ID) chainEntries++;
        }
        require(chainEntries == 12, "expected exactly 12 Arbitrum entries in JSON");

        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId != ARBITRUM_CHAIN_ID) continue;
            TokenEntry memory entry = entries[i];

            require(
                knownVaults[entry.vaultAddress],
                string.concat("JSON vaultAddress not a known Arbitrum prod constant for ", entry.name)
            );

            require(
                entry.active == expectedActive[entry.vaultAddress],
                string.concat("active flag mismatch for ", entry.name)
            );

            LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
                entry.vaultAddress, expectedVaultImpl[entry.vaultAddress], expectedVaultCodehash[entry.vaultAddress]
            );

            require(
                address(CycloVault(payable(entry.vaultAddress)).priceOracle()) == expectedVaultOracle[entry.vaultAddress],
                string.concat("priceOracle mismatch for ", entry.name)
            );

            require(
                expectedReceiptImpl[entry.receiptAddress] != address(0),
                string.concat("receiptAddress not a known Arbitrum prod constant for ", entry.name)
            );
            LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
                entry.receiptAddress,
                expectedReceiptImpl[entry.receiptAddress],
                expectedReceiptCodehash[entry.receiptAddress]
            );

            // Vaults take a `CycloVaultConfig` struct, receipts take an
            // address (the manager). With well-formed data the OZ
            // `initializer` modifier fires before the body decodes data,
            // producing the canonical "already initialized" revert string.
            CycloVaultConfig memory vaultConfig;
            LibCycloTestProd.checkIsInitialized(vm, entry.vaultAddress, abi.encode(vaultConfig));
            LibCycloTestProd.checkIsInitialized(vm, entry.receiptAddress, abi.encode(entry.vaultAddress));
        }

        // Reverse coverage: every prod vault constant must appear in the JSON.
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYWETH_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYWSTETH_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYWBTC_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYLINK_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYDOT_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYUNI_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYPEPE_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYPYTH_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYENA_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYARB_PYTH);
        _assertProdConstantInJson(entries, PROD_ARBITRUM_VAULT_CYXAUT_PYTH);
    }

    function _assertProdConstantInJson(TokenEntry[] memory entries, address vault) internal pure {
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].vaultAddress == vault) return;
        }
        revert("prod vault constant missing from JSON");
    }
}
