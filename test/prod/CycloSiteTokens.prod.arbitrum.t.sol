// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {LibCycloSiteTokens, ARBITRUM_CHAIN_ID} from "test/lib/LibCycloSiteTokens.sol";

/// Reads `canonical/cyclo-site-tokens.json` and asserts every Arbitrum entry's
/// on-chain shape matches the JSON: vault `decimals()`, underlying
/// `decimals()`, vault `asset()` linkage to the declared underlying, and
/// vault `receipt()` linkage to the declared receipt. Covers entries with
/// `active: false` because the on-chain claim is structural regardless of
/// UI surface.
contract CycloSiteTokensProdArbitrumTest is Test {
    function setUp() public {
        LibCycloTestProd.createSelectForkArbitrum(vm);
    }

    function testCycloSiteTokensArbitrum() external view {
        LibCycloSiteTokens.assertOnChainMatchesJson(vm, ARBITRUM_CHAIN_ID);
    }
}
