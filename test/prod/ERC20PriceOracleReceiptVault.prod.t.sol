// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    ERC20PriceOracleReceiptVault,
    ReceiptVaultConstructionConfig
} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {PROD_CYCLO_CYSFLR_VAULT_EXPECTED_CODE} from "src/lib/LibCycloProdBytecode.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {
    PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE
} from "src/lib/LibCycloProdOracle.sol";
import {
    PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR,
    PROD_FLARE_VAULT_CYSFLR,
    PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR
} from "src/lib/LibCycloProdDeployment.sol";

contract ERC20PriceOracleReceiptVaultProdTest is Test {
    function testProdERC20PriceOracleReceiptVaultBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        address proxy = PROD_FLARE_VAULT_CYSFLR;
        bytes memory proxyCode = proxy.code;
        address implementation;
        assembly {
            implementation := mload(add(proxyCode, 30))
        }

        assertEq(implementation.code, PROD_CYCLO_CYSFLR_VAULT_EXPECTED_CODE);
        assertEq(implementation, PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR);

        bytes memory expectedProxyCode =
            abi.encodePacked(hex"363d3d373d3d3d363d73", implementation, hex"5af43d82803e903d91602b57fd5bf3");

        assertEq(proxyCode, expectedProxyCode);
    }

    function testProdERC20PriceOracleReceiptVaultPriceOracle() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).priceOracle()),
            PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2
        );
    }

    function testProdERC20PriceOracleReceiptVaultAsset() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(
            address(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).asset()), address(SFLR_CONTRACT)
        );
    }

    function testProdERC20PriceOracleReceiptVaultName() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).name(), "cysFLR");
    }

    function testProdERC20PriceOracleReceiptVaultSymbol() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR)).symbol(), "cysFLR");
    }

    function testProdERC20PriceOracleReceiptIsInitialized() external {
        LibCycloTestProd.createSelectFork(vm);

        ERC20PriceOracleReceiptVault vault = ERC20PriceOracleReceiptVault(payable(PROD_FLARE_VAULT_CYSFLR));
        vm.expectRevert("Initializable: contract is already initialized");
        vault.initialize("");
    }

    fallback() external payable {}

    receive() external payable {}
}
