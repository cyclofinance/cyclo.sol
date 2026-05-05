// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {
    ARBITRUM_ARB,
    ARBITRUM_CBBTC,
    ARBITRUM_DOT,
    ARBITRUM_ENA,
    ARBITRUM_LINK,
    ARBITRUM_PEPE,
    ARBITRUM_PYTH,
    ARBITRUM_UNI,
    ARBITRUM_WBTC,
    ARBITRUM_WETH,
    ARBITRUM_WSTETH,
    ARBITRUM_XAUT
} from "src/lib/LibCycloProdAssets.sol";
import {
    PROD_ARBITRUM_VAULT_CYARB_PYTH,
    PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYDOT_PYTH,
    PROD_ARBITRUM_VAULT_CYENA_PYTH,
    PROD_ARBITRUM_VAULT_CYLINK_PYTH,
    PROD_ARBITRUM_VAULT_CYPEPE_PYTH,
    PROD_ARBITRUM_VAULT_CYPYTH_PYTH,
    PROD_ARBITRUM_VAULT_CYUNI_PYTH,
    PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYWETH_PYTH,
    PROD_ARBITRUM_VAULT_CYWSTETH_PYTH,
    PROD_ARBITRUM_VAULT_CYXAUT_PYTH
} from "src/lib/LibCycloProdVault.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

/// Pins the on-chain `decimals()` of every Arbitrum cyToken vault and its
/// underlying ERC20 against the values hardcoded in
/// `cyclofinance/cyclo.site:src/lib/stores.ts`. Covers all entries in the
/// arbitrum config including those with `active: false`, since the stores.ts
/// claim is a structural invariant regardless of UI surface.
contract CycloSiteDecimalsProdArbitrumTest is Test {
    function setUp() public {
        LibCycloTestProd.createSelectForkArbitrum(vm);
    }

    function testCyWethPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYWETH_PYTH).decimals(), 18);
    }

    function testCyWethPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_WETH).decimals(), 18);
    }

    function testCyWstethPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).decimals(), 18);
    }

    function testCyWstethPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_WSTETH).decimals(), 18);
    }

    function testCyWbtcPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).decimals(), 8);
    }

    function testCyWbtcPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_WBTC).decimals(), 8);
    }

    function testCyCbbtcPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).decimals(), 8);
    }

    function testCyCbbtcPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_CBBTC).decimals(), 8);
    }

    function testCyLinkPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYLINK_PYTH).decimals(), 18);
    }

    function testCyLinkPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_LINK).decimals(), 18);
    }

    function testCyDotPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYDOT_PYTH).decimals(), 18);
    }

    function testCyDotPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_DOT).decimals(), 18);
    }

    function testCyUniPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYUNI_PYTH).decimals(), 18);
    }

    function testCyUniPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_UNI).decimals(), 18);
    }

    function testCyPepePythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).decimals(), 18);
    }

    function testCyPepePythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_PEPE).decimals(), 18);
    }

    function testCyEnaPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYENA_PYTH).decimals(), 18);
    }

    function testCyEnaPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_ENA).decimals(), 18);
    }

    function testCyArbPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYARB_PYTH).decimals(), 18);
    }

    function testCyArbPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_ARB).decimals(), 18);
    }

    function testCyXautPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).decimals(), 6);
    }

    function testCyXautPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_XAUT).decimals(), 6);
    }

    function testCyPythPythShareDecimals() external view {
        assertEq(IERC20Metadata(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).decimals(), 6);
    }

    function testCyPythPythUnderlyingDecimals() external view {
        assertEq(IERC20Metadata(ARBITRUM_PYTH).decimals(), 6);
    }
}
