// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {CycloVaultTest} from "test/abstract/CycloVaultTest.sol";
import {LibCycloTestProd, DEFAULT_ALICE, PROD_TEST_BLOCK_NUMBER_FLARE} from "test/lib/LibCycloTestProd.sol";
import {
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";
import {FLARE_FASSET_XRP, FLARE_JOULE, FLARE_STARGATE_WETH} from "src/lib/LibCycloProdAssets.sol";

import {
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP,
    PROD_FLARE_VAULT_CYJOULE,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V2} from "src/lib/LibCycloProdReceipt.sol";
import {PROD_FLARE_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";

import {ICycloVault, CycloVaultConfig} from "test/interface/ICycloVault.sol";
import {ICloneableFactoryV2} from "test/interface/ICloneableFactoryV2.sol";
import {IERC20} from "forge-std-1.16.2/src/interfaces/IERC20.sol";
import {FLARE_SFLR} from "src/lib/LibCycloProdAssets.sol";
import {CREATION_CODE as CYCLO_VAULT_CREATION_CODE} from "src/generated/candidate/CycloVaultFlare.sol";

contract CycloVaultProdFlareTest is CycloVaultTest {
    // This address has 2M FXRP on mainnet fork.
    address constant ALICE_FXRP = 0x1aac0E512f9Fd62a8A873Bac3E19373C8ba9D4BC;

    function _rpcEnvName() internal pure override returns (string memory) {
        return "RPC_URL_FLARE_FORK";
    }

    function _blockNumber() internal pure override returns (uint256) {
        return PROD_TEST_BLOCK_NUMBER_FLARE;
    }

    function _cloneFactory() internal pure override returns (ICloneableFactoryV2) {
        return ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1);
    }

    function _vaultCreationCode() internal pure override returns (bytes memory) {
        return CYCLO_VAULT_CREATION_CODE;
    }

    function testProdCycloVaultBytecode() external view {
        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            address(sCycloVault), sCycloVaultImplementation, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYWETH,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYFXRP,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYJOULE,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2,
            PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V2_CODEHASH
        );
    }

    function testProdCycloVaultPriceOracle() external view {
        assertEq(
            address(ICycloVault(PROD_FLARE_VAULT_CYSFLR).priceOracle()), PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2
        );
        assertEq(
            address(ICycloVault(PROD_FLARE_VAULT_CYWETH).priceOracle()), PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE
        );
        assertEq(
            address(ICycloVault(PROD_FLARE_VAULT_CYFXRP).priceOracle()), PROD_FLARE_FTSO_V2_LTS_XRP_USD_FEED_ORACLE
        );
        assertEq(
            address(ICycloVault(PROD_FLARE_VAULT_CYJOULE).priceOracle()), PROD_FLARE_FTSO_V2_LTS_JOULE_USD_FEED_ORACLE
        );
    }

    function testProdCycloVaultAsset() external view {
        assertEq(address(ICycloVault(PROD_FLARE_VAULT_CYSFLR).asset()), FLARE_SFLR);
        assertEq(address(ICycloVault(PROD_FLARE_VAULT_CYWETH).asset()), FLARE_STARGATE_WETH);
        assertEq(address(ICycloVault(PROD_FLARE_VAULT_CYFXRP).asset()), FLARE_FASSET_XRP);
        assertEq(address(ICycloVault(PROD_FLARE_VAULT_CYJOULE).asset()), FLARE_JOULE);
    }

    function testProdCycloVaultName() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20.symbol.selector), abi.encode("FOO"));
        assertEq(sCycloVault.name(), "Cyclo cyFOO.to (TheOracle oracle)");

        assertEq(ICycloVault(PROD_FLARE_VAULT_CYSFLR).name(), "cysFLR");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYWETH).name(), "Cyclo cyWETH");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYFXRP).name(), "Cyclo cyFXRP.ftso (FTSO oracle)");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYJOULE).name(), "Cyclo cyJOULE.ftso (FTSO oracle)");
    }

    function testProdCycloVaultSymbol() external {
        vm.mockCall(ASSET, abi.encodeWithSelector(IERC20.symbol.selector), abi.encode("FOO"));
        assertEq(sCycloVault.symbol(), "cyFOO.to");

        assertEq(ICycloVault(PROD_FLARE_VAULT_CYSFLR).symbol(), "cysFLR");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYWETH).symbol(), "cyWETH");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYFXRP).symbol(), "cyFXRP.ftso");
        assertEq(ICycloVault(PROD_FLARE_VAULT_CYJOULE).symbol(), "cyJOULE.ftso");
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanDeposit(uint256 depositSeed) external {
        uint256 deposit = bound(depositSeed, 1, 2000000000000);

        deal(ICycloVault(PROD_FLARE_VAULT_CYSFLR).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYSFLR, deposit);

        deal(ICycloVault(PROD_FLARE_VAULT_CYWETH).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYWETH, deposit);

        deposit = bound(depositSeed, 1, 2000000e6);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYFXRP, deposit, ALICE_FXRP);

        deal(ICycloVault(PROD_FLARE_VAULT_CYJOULE).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYJOULE, deposit);
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanMint(uint256 sharesSeed) public {
        uint256 shares = bound(sharesSeed, 1, type(uint128).max);

        ICycloVault vault = ICycloVault(PROD_FLARE_VAULT_CYSFLR);

        uint256 assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYSFLR, shares, assets);

        vault = ICycloVault(PROD_FLARE_VAULT_CYWETH);

        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYWETH, shares, assets);

        vault = ICycloVault(PROD_FLARE_VAULT_CYFXRP);
        shares = bound(sharesSeed, 1, 1000000e6);
        assets = vault.previewMint(shares, 0);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYFXRP, shares, assets, ALICE_FXRP);

        vault = ICycloVault(PROD_FLARE_VAULT_CYJOULE);
        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYJOULE, shares, assets, DEFAULT_ALICE);
    }

    function testProdCycloVaultcysFLRImplementationIsInitialized() external {
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR);
    }

    function testProdCycloVaultcysFLRIsInitialized() external {
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYSFLR);
    }

    function testProdCycloVaultcyWETHImplementationIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1, abi.encode(config));
    }

    function testProdCycloVaultcyWETHIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYWETH, abi.encode(config));
    }

    function testProdCycloVaultcyFXRPIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYFXRP, abi.encode(config));
    }

    function testProdCycloVaultcyJOULEIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYJOULE, abi.encode(config));
    }

    fallback() external payable {}

    receive() external payable {}
}
