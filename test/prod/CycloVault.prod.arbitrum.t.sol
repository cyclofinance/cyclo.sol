// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {CycloVaultTest} from "test/abstract/CycloVaultTest.sol";
import {LibCycloTestProd, DEFAULT_ALICE, PROD_TEST_BLOCK_NUMBER_ARBITRUM} from "test/lib/LibCycloTestProd.sol";
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
import {PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";

import {ICycloVault, CycloVaultConfig} from "test/interface/ICycloVault.sol";
import {ICloneableFactoryV2} from "test/interface/ICloneableFactoryV2.sol";
import {IERC20} from "forge-std-1.16.2/src/interfaces/IERC20.sol";
import {CREATION_CODE as CYCLO_VAULT_CREATION_CODE} from "src/generated/candidate/CycloVaultArbitrum.sol";

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

    function _vaultCreationCode() internal pure override returns (bytes memory) {
        return CYCLO_VAULT_CREATION_CODE;
    }

    function testProdCycloVaultBytecodeArbitrum() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            address(sCycloVault), sCycloVaultImplementation, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
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
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH).priceOracle()), PROD_PYTH_ORACLE_WETH_USD_ARBITRUM
        );
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).priceOracle()), PROD_PYTH_ORACLE_WSTETH_USD_ARBITRUM
        );
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).priceOracle()), PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM
        );
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).priceOracle()), PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM
        );
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH).priceOracle()), PROD_PYTH_ORACLE_LINK_USD_ARBITRUM
        );
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH).priceOracle()), PROD_PYTH_ORACLE_DOT_USD_ARBITRUM);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH).priceOracle()), PROD_PYTH_ORACLE_UNI_USD_ARBITRUM);
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).priceOracle()), PROD_PYTH_ORACLE_PEPE_USD_ARBITRUM
        );
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).priceOracle()), PROD_PYTH_ORACLE_PYTH_USD_ARBITRUM
        );
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH).priceOracle()), PROD_PYTH_ORACLE_ENA_USD_ARBITRUM);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH).priceOracle()), PROD_PYTH_ORACLE_ARB_USD_ARBITRUM);
        assertEq(
            address(ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).priceOracle()), PROD_PYTH_ORACLE_XAUT_USD_ARBITRUM
        );
    }

    function testProdCycloVaultAsset() external view {
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH).asset()), ARBITRUM_WETH);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).asset()), ARBITRUM_WSTETH);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).asset()), ARBITRUM_WBTC);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).asset()), ARBITRUM_CBBTC);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH).asset()), ARBITRUM_LINK);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH).asset()), ARBITRUM_DOT);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH).asset()), ARBITRUM_UNI);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).asset()), ARBITRUM_PEPE);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).asset()), ARBITRUM_PYTH);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH).asset()), ARBITRUM_ENA);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH).asset()), ARBITRUM_ARB);
        assertEq(address(ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).asset()), ARBITRUM_XAUT);
    }

    function testProdCycloVaultNameArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20.symbol.selector), abi.encode("FOO"));
        assertEq(sCycloVault.name(), "Cyclo cyFOO.to (TheOracle oracle)");

        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH).name(), "Cyclo cyWETH.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).name(), "Cyclo cywstETH.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).name(), "Cyclo cyWBTC.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).name(), "Cyclo cycbBTC.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH).name(), "Cyclo cyLINK.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH).name(), "Cyclo cyDOT.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH).name(), "Cyclo cyUNI.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).name(), "Cyclo cyPEPE.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).name(), "Cyclo cyPYTH.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH).name(), "Cyclo cyENA.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH).name(), "Cyclo cyARB.pyth (Pyth oracle)");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).name(), "Cyclo cyXAUt0.pyth (Pyth oracle)");
    }

    function testProdCycloVaultSymbolArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20.symbol.selector), abi.encode("FOO"));
        assertEq(sCycloVault.symbol(), "cyFOO.to");

        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH).symbol(), "cyWETH.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).symbol(), "cywstETH.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).symbol(), "cyWBTC.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).symbol(), "cycbBTC.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH).symbol(), "cyLINK.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH).symbol(), "cyDOT.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH).symbol(), "cyUNI.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).symbol(), "cyPEPE.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).symbol(), "cyPYTH.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH).symbol(), "cyENA.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH).symbol(), "cyARB.pyth");
        assertEq(ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).symbol(), "cyXAUt0.pyth");
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanDepositArbitrum(uint256 depositSeed) external {
        uint256 deposit = bound(depositSeed, 1, 2000000000000);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWSTETH_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYLINK_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYDOT_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYUNI_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYPEPE_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYPYTH_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYENA_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYARB_PYTH, deposit);

        deal(ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYXAUT_PYTH, deposit);
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanMintArbitrum(uint256 sharesSeed) public {
        uint256 shares = bound(sharesSeed, 1, type(uint128).max);

        ICycloVault vault = ICycloVault(PROD_ARBITRUM_VAULT_CYWETH_PYTH);
        uint256 assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYWSTETH_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYWSTETH_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYWBTC_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYLINK_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYLINK_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYDOT_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYDOT_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYUNI_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYUNI_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYPEPE_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYPEPE_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYPYTH_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYPYTH_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYENA_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYENA_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYARB_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYARB_PYTH, shares, assets);

        vault = ICycloVault(PROD_ARBITRUM_VAULT_CYXAUT_PYTH);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYXAUT_PYTH, shares, assets);
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
