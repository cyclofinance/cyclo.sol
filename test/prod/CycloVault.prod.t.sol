// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {LibCycloTestProd, DEFAULT_ALICE} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";
import {FLARE_FASSET_XRP} from "src/lib/LibCycloProdAssets.sol";

import {
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_CYFXRP,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1,
    PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1
} from "src/lib/LibCycloProdReceipt.sol";
import {CycloVaultConfig, CycloVault} from "src/concrete/vault/CycloVault.sol";
import {PROD_FLARE_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";
import {IReceiptV2} from "ethgild/abstract/ReceiptVault.sol";
import {IERC20Upgradeable as IERC20} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/IERC20Upgradeable.sol";

import {console2} from "forge-std/Test.sol";

contract CycloVaultProdTest is Test {
    function testProdCycloVaultBytecode() external {
        ReceiptVaultConstructionConfig memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfig({
            factory: ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1),
            receiptImplementation: IReceiptV2(PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1)
        });
        CycloVault cycloVault = new CycloVault(receiptVaultConstructionConfig);
        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            address(cycloVault), PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1_CODEHASH
        );

        LibCycloTestProd.createSelectFork(vm);

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
    }

    function testProdCycloVaultPriceOracle() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(CycloVault(payable(PROD_FLARE_VAULT_CYSFLR)).priceOracle()),
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2
        );
        assertEq(
            address(CycloVault(payable(PROD_FLARE_VAULT_CYWETH)).priceOracle()),
            PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE
        );
    }

    function testProdCycloVaultAsset() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(address(CycloVault(payable(PROD_FLARE_VAULT_CYSFLR)).asset()), address(SFLR_CONTRACT));
        assertEq(
            address(CycloVault(payable(PROD_FLARE_VAULT_CYWETH)).asset()), 0x1502FA4be69d526124D453619276FacCab275d3D
        );
    }

    function testProdCycloVaultName() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYSFLR)).name(), "cysFLR");
        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYWETH)).name(), "Cyclo cyWETH");
        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYFXRP)).name(), "Cyclo cyFXRP");
    }

    function testProdCycloVaultSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYSFLR)).symbol(), "cysFLR");
        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYWETH)).symbol(), "cyWETH");
        assertEq(CycloVault(payable(PROD_FLARE_VAULT_CYFXRP)).symbol(), "cyFXRP");
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanDeposit(uint256 depositSeed) external {
        uint256 deposit = bound(depositSeed, 1, 2000000000000);
        LibCycloTestProd.createSelectFork(vm);

        deal(CycloVault(payable(PROD_FLARE_VAULT_CYSFLR)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYSFLR, deposit);

        deal(CycloVault(payable(PROD_FLARE_VAULT_CYWETH)).asset(), DEFAULT_ALICE, deposit);
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYWETH, deposit);

        // This address has 2M FXRP on mainnet fork.
        deposit = bound(depositSeed, 1, 2000000e6);
        address aliceFXRP = 0x1aac0E512f9Fd62a8A873Bac3E19373C8ba9D4BC;
        LibCycloTestProd.checkDeposit(vm, PROD_FLARE_VAULT_CYFXRP, deposit, aliceFXRP);
    }

    /// forge-config: default.fuzz.runs = 1
    function testProdCycloVaultCanMint(uint256 shares) public {
        shares = bound(shares, 1, type(uint128).max);
        LibCycloTestProd.createSelectFork(vm);

        CycloVault vault = CycloVault(payable(PROD_FLARE_VAULT_CYSFLR));

        uint256 assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYSFLR, shares, assets);

        vault = CycloVault(payable(PROD_FLARE_VAULT_CYWETH));

        assets = vault.previewMint(shares, 0);
        deal(vault.asset(), DEFAULT_ALICE, assets);
        LibCycloTestProd.checkMint(vm, PROD_FLARE_VAULT_CYWETH, shares, assets);
    }

    function testProdCycloVaultcysFLRImplementationIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR);
    }

    function testProdCycloVaultcysFLRIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYSFLR);
    }

    function testProdCycloVaultcyWETHImplementationIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1, abi.encode(config));
    }

    function testProdCycloVaultcyWETHIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYWETH, abi.encode(config));
    }

    fallback() external payable {}

    receive() external payable {}
}
