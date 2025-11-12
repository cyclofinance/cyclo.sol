// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {CycloVaultTest} from "test/abstract/CycloVaultTest.sol";
import {LibCycloTestProd, DEFAULT_ALICE, PROD_TEST_BLOCK_NUMBER_ARBITRUM} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {
    PROD_PYTH_ORACLE_WETH_USD_ARBITRUM,
    PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM,
    PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM
} from "src/lib/LibCycloProdOracle.sol";
import {ARBITRUM_WETH, ARBITRUM_WBTC, ARBITRUM_CBBTC} from "src/lib/LibCycloProdAssets.sol";

import {
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH,
    PROD_ARBITRUM_VAULT_CYWETH_PYTH,
    PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
    PROD_ARBITRUM_VAULT_CYCBBTC_PYTH
} from "src/lib/LibCycloProdVault.sol";
import {PROD_ARBITRUM_CYCLO_RECEIPT_IMPLEMENTATION_V2} from "src/lib/LibCycloProdReceipt.sol";
import {CycloVaultConfig, CycloVault} from "src/concrete/vault/CycloVault.sol";
import {PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {IReceiptV3} from "ethgild/abstract/ReceiptVault.sol";

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
            PROD_ARBITRUM_VAULT_CYWBTC_PYTH,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_ARBITRUM_VAULT_CYCBBTC_PYTH,
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
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_WBTC_USD_ARBITRUM
        );
        assertEq(
            address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).priceOracle()),
            PROD_PYTH_ORACLE_CBBTC_USD_ARBITRUM
        );
    }

    function testProdCycloVaultAsset() external view {
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).asset()), ARBITRUM_WETH);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).asset()), ARBITRUM_WBTC);
        assertEq(address(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).asset()), ARBITRUM_CBBTC);
    }

    function testProdCycloVaultNameArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("FOO"));
        assertEq(CycloVault(payable(sCycloVault)).name(), "Cyclo cyFOO.to (TheOracle oracle)");

        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).name(), "Cyclo cyWETH.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).name(), "Cyclo cyWBTC.pyth (Pyth oracle)");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).name(), "Cyclo cycbBTC.pyth (Pyth oracle)");
    }

    function testProdCycloVaultSymbolArbitrum() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("FOO"));
        assertEq(CycloVault(payable(sCycloVault)).symbol(), "cyFOO.to");

        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).symbol(), "cyWETH.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).symbol(), "cyWBTC.pyth");
        assertEq(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).symbol(), "cycbBTC.pyth");
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanDepositArbitrum(uint256 depositSeed) external {
        uint256 deposit = bound(depositSeed, 1, 2000000000000);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, deposit);

        deal(CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, deposit);
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanMintArbitrum(uint256 sharesSeed) public {
        uint256 shares = bound(sharesSeed, 1, type(uint128).max);

        CycloVault vault = CycloVault(payable(PROD_ARBITRUM_VAULT_CYWETH_PYTH));
        uint256 assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, shares, assets);

        vault = CycloVault(payable(PROD_ARBITRUM_VAULT_CYWBTC_PYTH));
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, shares, assets);

        vault = CycloVault(payable(PROD_ARBITRUM_VAULT_CYCBBTC_PYTH));
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, shares, assets);
    }

    function testProdCycloVaultImplementationIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_CYCLO_VAULT_IMPLEMENTATION_V2, abi.encode(config));
    }

    function testProdCycloVaultcyWETHIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYWETH_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyWBTCIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYWBTC_PYTH, abi.encode(config));
    }

    function testProdCycloVaultcyCBBTCIsInitializedArbitrum() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_ARBITRUM_VAULT_CYCBBTC_PYTH, abi.encode(config));
    }

    fallback() external payable {}

    receive() external payable {}
}
