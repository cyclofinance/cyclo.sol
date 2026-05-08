// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibCycloSiteTokens, TokenEntry, FLARE_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";
import {
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP,
    PROD_FLARE_VAULT_CYJOULE
} from "src/lib/LibCycloProdVault.sol";

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Flare entry's
/// on-chain shape matches the JSON. Also pins each entry's `vaultAddress`
/// to a known prod constant from `LibCycloProdVault.sol`, so a typo or
/// stray address in the JSON fails loudly here.
contract CycloSiteTokensProdFlareTest is Test {
    mapping(address => bool) internal knownVaults;

    function setUp() public {
        LibCycloTestProd.createSelectForkFlare(vm);
        knownVaults[PROD_FLARE_VAULT_CYSFLR] = true;
        knownVaults[PROD_FLARE_VAULT_CYWETH] = true;
        knownVaults[PROD_FLARE_VAULT_CYFXRP] = true;
        knownVaults[PROD_FLARE_VAULT_CYJOULE] = true;
    }

    function testCycloSiteTokensFlare() external view {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, FLARE_CHAIN_ID, "Flare");

        TokenEntry[] memory entries = LibCycloSiteTokens.loadAll(vm);
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId != FLARE_CHAIN_ID) continue;
            require(
                knownVaults[entries[i].vaultAddress],
                string.concat("JSON vaultAddress not a known Flare prod constant for ", entries[i].name)
            );
        }
    }
}
