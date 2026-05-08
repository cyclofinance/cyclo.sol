// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibCycloSiteTokens, TokenEntry, ARBITRUM_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";
import {
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

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Arbitrum entry's
/// on-chain shape matches the JSON. Also pins each entry's `vaultAddress`
/// to a known prod constant from `LibCycloProdVault.sol`, so a typo or
/// stray address in the JSON fails loudly here.
contract CycloSiteTokensProdArbitrumTest is Test {
    mapping(address => bool) internal knownVaults;

    function setUp() public {
        LibCycloTestProd.createSelectForkArbitrum(vm);
        knownVaults[PROD_ARBITRUM_VAULT_CYWETH_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYWSTETH_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYWBTC_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYCBBTC_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYLINK_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYDOT_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYUNI_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYPEPE_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYPYTH_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYENA_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYARB_PYTH] = true;
        knownVaults[PROD_ARBITRUM_VAULT_CYXAUT_PYTH] = true;
    }

    function testCycloSiteTokensArbitrum() external view {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, ARBITRUM_CHAIN_ID, "Arbitrum One");

        TokenEntry[] memory entries = LibCycloSiteTokens.loadAll(vm);
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].chainId != ARBITRUM_CHAIN_ID) continue;
            require(
                knownVaults[entries[i].vaultAddress],
                string.concat("JSON vaultAddress not a known Arbitrum prod constant for ", entries[i].name)
            );
        }
    }
}
