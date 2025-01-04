// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {
    PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS,
    PROD_CYCLO_CYSFLR_VAULT_IMPLEMENTATION_ADDRESS,
    PROD_CYCLO_VAULT_ADDRESS,
    PROD_CYCLO_RECEIPT_IMPLEMENTATION_ADDRESS,
    PROD_CLONE_FACTORY_ADDRESS_V1,
    PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS,
    PROD_CYCLO_CYSFLR_VAULT_EXPECTED_CODE
} from "src/lib/LibCycloProd.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";

contract ERC20PriceOracleReceiptVaultProdTest is Test {
    function testProdERC20PriceOracleReceiptVaultBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        address proxy = PROD_CYCLO_VAULT_ADDRESS;
        bytes memory proxyCode = proxy.code;
        address implementation;
        assembly {
            implementation := mload(add(proxyCode, 30))
        }

        assertEq(implementation.code, PROD_CYCLO_CYSFLR_VAULT_EXPECTED_CODE);
        assertEq(implementation, PROD_CYCLO_CYSFLR_VAULT_IMPLEMENTATION_ADDRESS);

        bytes memory expectedProxyCode =
            abi.encodePacked(hex"363d3d373d3d3d363d73", implementation, hex"5af43d82803e903d91602b57fd5bf3");

        assertEq(proxyCode, expectedProxyCode);
    }

    function testProdERC20PriceOracleReceiptVaultPriceOracle() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_CYCLO_VAULT_ADDRESS)).priceOracle()),
            PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS
        );
    }

    function testProdERC20PriceOracleReceiptVaultAsset() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_CYCLO_VAULT_ADDRESS)).asset()), address(SFLR_CONTRACT)
        );
    }

    function testProdERC20PriceOracleReceiptVaultName() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_CYCLO_VAULT_ADDRESS)).name(), "cysFLR");
    }

    function testProdERC20PriceOracleReceiptVaultSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_CYCLO_VAULT_ADDRESS)).symbol(), "cysFLR");
    }

    fallback() external payable {}

    receive() external payable {}
}
