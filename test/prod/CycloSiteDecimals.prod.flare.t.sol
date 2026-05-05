// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {FLARE_FASSET_XRP, FLARE_STARGATE_WETH} from "src/lib/LibCycloProdAssets.sol";
import {
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP
} from "src/lib/LibCycloProdVault.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

/// Pins the on-chain `decimals()` of every Flare cyToken vault and its
/// underlying ERC20 against the values hardcoded in
/// `cyclofinance/cyclo.site:src/lib/stores.ts`. Drift between this test and
/// stores.ts is caught at CI time on either repo: changing stores.ts without
/// updating this test (or vice versa) fails one side and the discrepancy
/// surfaces in PR review.
contract CycloSiteDecimalsProdFlareTest is Test {
    function setUp() public {
        LibCycloTestProd.createSelectForkFlare(vm);
    }

    function testCysFlrShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_FLARE_VAULT_CYSFLR).decimals(), 18);
    }

    function testCysFlrUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(address(SFLR_CONTRACT)).decimals(), 18);
    }

    function testCyWethShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_FLARE_VAULT_CYWETH).decimals(), 18);
    }

    function testCyWethUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(FLARE_STARGATE_WETH).decimals(), 18);
    }

    function testCyFxrpShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_FLARE_VAULT_CYFXRP).decimals(), 6);
    }

    function testCyFxrpUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(FLARE_FASSET_XRP).decimals(), 6);
    }
}
