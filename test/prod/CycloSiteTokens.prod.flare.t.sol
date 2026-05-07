// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibCycloSiteTokens, FLARE_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Flare entry's
/// on-chain shape matches the JSON: vault `decimals()`, underlying
/// `decimals()`, vault `asset()` linkage to the declared underlying, and
/// vault `receipt()` linkage to the declared receipt. The JSON is the single
/// source of truth shared with `cyclofinance/cyclo.site` — drift from
/// stores.ts shows up here as a failing test.
contract CycloSiteTokensProdFlareTest is Test {
    function setUp() public {
        LibCycloTestProd.createSelectForkFlare(vm);
    }

    function testCycloSiteTokensFlare() external view {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, FLARE_CHAIN_ID, "Flare");
    }
}
