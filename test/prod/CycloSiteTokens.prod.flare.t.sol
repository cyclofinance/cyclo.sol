// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";
import {LibCycloSiteTokens, TokenEntry, FLARE_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";
import {CycloVault} from "src/concrete/vault/CycloVault.sol";
import {
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP,
    PROD_FLARE_VAULT_CYJOULE
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2,
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_RECEIPT_CYFXRP
} from "src/lib/LibCycloProdReceipt.sol";
import {
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Flare entry's
/// on-chain shape matches the JSON. Pins per-entry deployment details against
/// the prod constants in `LibCycloProd*.sol`:
///   - vaultAddress → expected vault impl + codehash (1167 proxy check)
///   - vaultAddress → expected priceOracle
///   - receiptAddress → expected receipt impl + codehash (1167 proxy check)
contract CycloSiteTokensProdFlareTest is Test {
    mapping(address => bool) internal knownVaults;
    mapping(address => bool) internal expectedActive;
    mapping(address => address) internal expectedVaultImpl;
    mapping(address => bytes32) internal expectedVaultCodehash;
    mapping(address => address) internal expectedVaultOracle;
    mapping(address => address) internal expectedReceiptImpl;
    mapping(address => bytes32) internal expectedReceiptCodehash;

    function setUp() public {
        LibCycloTestProd.createSelectForkFlare(vm);

        knownVaults[PROD_FLARE_VAULT_CYSFLR] = true;
        knownVaults[PROD_FLARE_VAULT_CYWETH] = true;
        knownVaults[PROD_FLARE_VAULT_CYFXRP] = true;
        knownVaults[PROD_FLARE_VAULT_CYJOULE] = true;

        expectedActive[PROD_FLARE_VAULT_CYSFLR] = true;
        expectedActive[PROD_FLARE_VAULT_CYWETH] = true;
        expectedActive[PROD_FLARE_VAULT_CYFXRP] = true;

        expectedVaultImpl[PROD_FLARE_VAULT_CYSFLR] = PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR;
        expectedVaultCodehash[PROD_FLARE_VAULT_CYSFLR] = PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH;
        expectedVaultImpl[PROD_FLARE_VAULT_CYWETH] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1;
        expectedVaultCodehash[PROD_FLARE_VAULT_CYWETH] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH;
        expectedVaultImpl[PROD_FLARE_VAULT_CYFXRP] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2;
        expectedVaultCodehash[PROD_FLARE_VAULT_CYFXRP] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH;
        expectedVaultImpl[PROD_FLARE_VAULT_CYJOULE] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2;
        expectedVaultCodehash[PROD_FLARE_VAULT_CYJOULE] = PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH;

        expectedVaultOracle[PROD_FLARE_VAULT_CYSFLR] = PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2;
        expectedVaultOracle[PROD_FLARE_VAULT_CYWETH] = PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE;
        expectedVaultOracle[PROD_FLARE_VAULT_CYFXRP] = PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE;

        expectedReceiptImpl[PROD_FLARE_RECEIPT_CYSFLR] = PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR;
        expectedReceiptCodehash[PROD_FLARE_RECEIPT_CYSFLR] = PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH;
        expectedReceiptImpl[PROD_FLARE_RECEIPT_CYWETH] = PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1;
        expectedReceiptCodehash[PROD_FLARE_RECEIPT_CYWETH] = PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1;
        expectedReceiptImpl[PROD_FLARE_RECEIPT_CYFXRP] = PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2;
        expectedReceiptCodehash[PROD_FLARE_RECEIPT_CYFXRP] = PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V2;
    }

    function testCycloSiteTokensFlare() external {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, FLARE_CHAIN_ID, "Flare");

        TokenEntry[] memory entries = LibCycloSiteTokens.loadAll(vm);
        uint256 chainEntries = 0;
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId == FLARE_CHAIN_ID) chainEntries++;
        }
        require(chainEntries == 3, "expected exactly 3 Flare entries in JSON");

        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId != FLARE_CHAIN_ID) continue;
            TokenEntry memory entry = entries[i];

            require(
                knownVaults[entry.vaultAddress],
                string.concat("JSON vaultAddress not a known Flare prod constant for ", entry.name)
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
                string.concat("receiptAddress not a known Flare prod constant for ", entry.name)
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

        // Reverse coverage: every prod vault constant must appear in the JSON,
        // unless explicitly excluded. cyJOULE has been retired from the cyclo.site
        // listing but its constant is kept for historical bytecode tests.
        _assertProdConstantInJson(entries, PROD_FLARE_VAULT_CYSFLR);
        _assertProdConstantInJson(entries, PROD_FLARE_VAULT_CYWETH);
        _assertProdConstantInJson(entries, PROD_FLARE_VAULT_CYFXRP);
        // PROD_FLARE_VAULT_CYJOULE — intentionally excluded from JSON.
    }

    function _assertProdConstantInJson(TokenEntry[] memory entries, address vault) internal pure {
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].vaultAddress == vault) return;
        }
        revert("prod vault constant missing from JSON");
    }
}
