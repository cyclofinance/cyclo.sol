// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {CycloVaultTest} from "test/abstract/CycloVaultTest.sol";
import {LibCycloTestProd, DEFAULT_ALICE, PROD_TEST_BLOCK_NUMBER_ARBITRUM} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
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
import {
    ARBITRUM_WETH,
    ARBITRUM_WSTETH,
    ARBITRUM_WBTC,
    ARBITRUM_CBBTC,
    ARBITRUM_LINK,
    ARBITRUM_DOT,
    ARBITRUM_UNI,
    ARBITRUM_PEPE,
    ARBITRUM_PYTH,
    ARBITRUM_ENA,
    ARBITRUM_ARB,
    ARBITRUM_XAUT
} from "src/lib/LibCycloProdAssets.sol";

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
import {PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2} from "src/lib/LibCycloProdReceipt.sol";
import {CycloVaultConfig, CycloVault} from "src/concrete/vault/CycloVault.sol";
import {PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {IReceiptV3} from "ethgild/abstract/ReceiptVault.sol";
import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";

contract CycloVaultProdArbitrumTest is CycloVaultTest {
    function _rpcEnvName() internal pure override returns (string memory) {
        return "RPC_URL_ARBITRUM_FORK";
    }

    function _blockNumber() internal pure override returns (uint256) {
        return PROD_TEST_BLOCK_NUMBER_ARBITRUM;
    }

    function _cloneFactory() internal pure override returns (ICloneableFactoryV2) {
        return ICloneableFactoryV2(PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1);
    }

    function _receiptImplementation() internal pure override returns (IReceiptV3) {
        return IReceiptV3(PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2);
    }

    function testProdCycloVaultBytecodeArbitrum() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            address(sCycloVault),
            address(sCycloVaultImplementation),
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYWETH_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYWSTETH_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYLINK_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYDOT_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYUNI_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYPEPE_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYPYTH_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYENA_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYARB_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYXAUT_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testProdCycloVaultPriceOracleArbitrum() external view {
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_WETH_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYLINK_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_LINK_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYDOT_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_DOT_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYUNI_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_UNI_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPEPE_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPYTH_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYENA_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_ENA_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYARB_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_ARB_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYXAUT_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM
        );
    }

    function testProdCycloVaultAsset() external view {
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).asset()), ARBITRUM_WETH);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH)).asset()), ARBITRUM_WSTETH);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).asset()), ARBITRUM_WBTC);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).asset()), ARBITRUM_CBBTC);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYLINK_PYTH)).asset()), ARBITRUM_LINK);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYDOT_PYTH)).asset()), ARBITRUM_DOT);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYUNI_PYTH)).asset()), ARBITRUM_UNI);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPEPE_PYTH)).asset()), ARBITRUM_PEPE);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPYTH_PYTH)).asset()), ARBITRUM_PYTH);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYENA_PYTH)).asset()), ARBITRUM_ENA);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYARB_PYTH)).asset()), ARBITRUM_ARB);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYXAUT_PYTH)).asset()), ARBITRUM_XAUT);
    }

    function testProdCycloVaultNameArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("FOO"));
        assertEq(CycloVault(payable(sCycloVault)).name(), "Cyclo cyFOO.to (TheOracle oracle)");

        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).name(), "Cyclo cyWETH.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH)).name(), "Cyclo cywstETH.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).name(), "Cyclo cyWBTC.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).name(), "Cyclo cycbBTC.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYLINK_PYTH)).name(), "Cyclo cyLINK.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYDOT_PYTH)).name(), "Cyclo cyDOT.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYUNI_PYTH)).name(), "Cyclo cyUNI.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPEPE_PYTH)).name(), "Cyclo cyPEPE.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPYTH_PYTH)).name(), "Cyclo cyPYTH.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYENA_PYTH)).name(), "Cyclo cyENA.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYARB_PYTH)).name(), "Cyclo cyARB.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYXAUT_PYTH)).name(), "Cyclo cyXAUt0.pyth (Pyth oracle)");
    }

    function testProdCycloVaultSymbolArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("FOO"));
        assertEq(CycloVault(payable(sCycloVault)).symbol(), "cyFOO.to");

        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).symbol(), "cyWETH.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH)).symbol(), "cywstETH.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).symbol(), "cyWBTC.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).symbol(), "cycbBTC.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYLINK_PYTH)).symbol(), "cyLINK.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYDOT_PYTH)).symbol(), "cyDOT.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYUNI_PYTH)).symbol(), "cyUNI.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPEPE_PYTH)).symbol(), "cyPEPE.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPYTH_PYTH)).symbol(), "cyPYTH.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYENA_PYTH)).symbol(), "cyENA.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYARB_PYTH)).symbol(), "cyARB.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYXAUT_PYTH)).symbol(), "cyXAUt0.pyth");
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanDepositArbitrum(uint256 depositSeed) external {
        uint256 deposit = bound(depositSeed, 1, 2000000000000);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWSTETH_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYLINK_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYLINK_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYDOT_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYDOT_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYUNI_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYUNI_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPEPE_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYPEPE_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYPYTH_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYPYTH_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYENA_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYENA_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYARB_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYARB_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYXAUT_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYXAUT_PYTH, deposit);
    }

    /// Mints `shares` from `vault` if its Pyth feed is fresh at the pinned
    /// block. If the feed is stale, asserts the full revert chain we observe:
    /// `previewMint` panics with divide-by-zero (0x12) because
    /// `ERC20PriceOracleReceiptVault._nextId()` swallows the oracle revert in a
    /// try/catch and returns id=0, then `_calculateMint` divides by zero. The
    /// underlying cause is pinned by calling the oracle directly and asserting
    /// `StalePrice()` (Pyth selector 0x19abf40e).
    function _checkMintForVault(address vault_, address oracle_, uint256 shares) internal {
        CycloVault vault = CycloVault(payable(vault_));
        try vault.previewMint(shares, 0) returns (uint256 expectedAssets) {
            deal(vault.asset(), DEFAULT_ALICE, expectedAssets);
            LibCycloTestProd.checkMint(vm, vault_, shares, expectedAssets);
        } catch (bytes memory err) {
            require(
                keccak256(err) == keccak256(abi.encodeWithSignature("Panic(uint256)", uint256(0x12))),
                "previewMint reverted with something other than divide-by-zero"
            );
            vm.expectRevert(abi.encodeWithSignature("StalePrice()"));
            IPriceOracleV2(payable(oracle_)).price();
        }
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanMintArbitrum(uint256 sharesSeed) public {
        uint256 shares = bound(sharesSeed, 1, type(uint128).max);

        _checkMintForVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH, PROD_PYTH_ORACLE_WETH_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH, PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH, PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH, PROD_PYTH_ORACLE_LINK_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH, PROD_PYTH_ORACLE_DOT_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH, PROD_PYTH_ORACLE_UNI_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH, PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH, PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYENA_PYTH, PROD_PYTH_ORACLE_ENA_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYARB_PYTH, PROD_PYTH_ORACLE_ARB_USD_ARBITRUM, shares);
        _checkMintForVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH, PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM, shares);
    }

    function testProdCycloVaultImplementationIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2, abi.encode(config));
    }

    function testProdCycloVaultcyWETHIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyWSTETHIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYWSTETH_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyWBTCIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyCBBTCIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyLINKIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYLINK_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyDOTIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYDOT_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyUNIIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYUNI_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyPEPEIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYPEPE_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyPYTHIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYPYTH_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyENAIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYENA_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyARBIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYARB_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyXAUTIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYXAUT_PYTH, abi.encode(config));
    }

    fallback() external payable {}

    receive() external payable {}
}
