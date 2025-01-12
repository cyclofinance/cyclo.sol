// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";
import {
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_CYWETH,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
} from "src/lib/LibCycloProdVault.sol";
import {PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR} from "src/lib/LibCycloProdReceipt.sol";
import {CycloVaultConfig} from "src/concrete/vault/CycloVault.sol";

contract ERC20PriceOracleReceiptVaultProdTest is Test {
    function testProdERC20PriceOracleReceiptVaultBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHashBy1167Proxy(
            PROD_FLARE_VAULT_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR,
            PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH
        );
    }

    function testProdERC20PriceOracleReceiptVaultPriceOracle() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).priceOracle()),
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2
        );
        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYWETH)).priceOracle()),
            PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE
        );
    }

    function testProdERC20PriceOracleReceiptVaultAsset() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).asset()), address(SFLR_CONTRACT)
        );
        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYWETH)).asset()),
            0x1502FA4be69d526124D453619276FacCab275d3D
        );
    }

    function testProdCycloVaultName() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).name(), "cysFLR");
        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYWETH)).name(), "Cyclo cyWETH");
    }

    function testProdCycloVaultSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).symbol(), "cysFLR");
        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYWETH)).symbol(), "cyWETH");
    }

    function testProdCycloVaultcysFLRIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYSFLR);
    }

    function testProdCycloVaultcyWETHIsInitialized() external {
        CycloVaultConfig memory config;
        LibCycloTestProd.createSelectFork(vm);
        LibCycloTestProd.checkIsInitialized(vm, PROD_FLARE_VAULT_CYWETH, abi.encode(config));
    }

    fallback() external payable {}

    receive() external payable {}
}
