// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std/StdCheats.sol";
import {console2} from "forge-std/Test.sol";
import {LibExtrospectBytecode} from "rain.extrospection/lib/LibExtrospectBytecode.sol";
import {LibExtrospectERC1167Proxy} from "rain.extrospection/lib/LibExtrospectERC1167Proxy.sol";
import {ICloneableV2} from "rain.factory/interface/ICloneableV2.sol";
import {CycloVaultConfig, CycloVault} from "src/concrete/vault/CycloVault.sol";
import {IERC20Upgradeable as IERC20} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/IERC20Upgradeable.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER = 49661969;

string constant PROD_CYSFLR_RECEIPT_SYMBOL = "cysFLR RCPT";
string constant PROD_CYSFLR_RECEIPT_NAME = "cysFLR Receipt";

address constant DEFAULT_ALICE = address(uint160(uint256(keccak256("ALICE"))));

library LibCycloTestProd {
    function createSelectFork(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_TEST_BLOCK_NUMBER);
    }

    function checkCBORTrimmedBytecodeHash(address account, bytes32 expected) internal view {
        bytes memory bytecode = account.code;
        bool didTrim = LibExtrospectBytecode.trimSolidityCBORMetadata(bytecode);
        require(didTrim, "metadata not trimmed");
        bytes32 actual = keccak256(bytecode);
        if (expected != actual) {
            console2.logBytes32(expected);
            console2.logBytes32(actual);
            revert("bytecode hash mismatch");
        }
    }

    function checkCBORTrimmedBytecodeHashBy1167Proxy(
        address proxy,
        address expectedImplementation,
        bytes32 expectedImplementationHash
    ) internal view {
        (bool isProxy, address implementation) = LibExtrospectERC1167Proxy.isERC1167Proxy(proxy.code);
        require(isProxy, "not a proxy");
        require(implementation == expectedImplementation, "implementation mismatch");
        checkCBORTrimmedBytecodeHash(expectedImplementation, expectedImplementationHash);
    }

    function checkIsInitialized(Vm vm, address proxy, bytes memory data) internal {
        vm.expectRevert("Initializable: contract is already initialized");
        ICloneableV2(proxy).initialize(data);
    }

    function checkIsInitialized(Vm vm, address proxy) internal {
        checkIsInitialized(vm, proxy, "");
    }

    function checkDeposit(Vm vm, address proxy, uint256 deposit, address alice) internal {
        CycloVault vault = CycloVault(payable(proxy));
        IERC20 asset = IERC20(vault.asset());
        vm.startPrank(alice);
        asset.approve(proxy, deposit);
        uint256 aliceAssetBalanceBefore = asset.balanceOf(alice);
        uint256 assetBalanceBefore = asset.balanceOf(proxy);
        uint256 expectedShares = vault.previewDeposit(deposit, 0);
        vm.assume(expectedShares > 0);
        uint256 shares = vault.deposit(deposit, alice, 0, hex"");
        require(shares == expectedShares, "shares mismatch");
        require(asset.balanceOf(proxy) == assetBalanceBefore + deposit, "asset balance mismatch");
        require(asset.balanceOf(alice) == aliceAssetBalanceBefore - deposit, "ALICE asset balance mismatch");
        vm.stopPrank();
    }

    function checkDeposit(Vm vm, address proxy, uint256 deposit) internal {
        checkDeposit(vm, proxy, deposit, DEFAULT_ALICE);
    }

    function checkMint(Vm vm, address proxy, uint256 shares, uint256 expectedAssets) internal {
        CycloVault vault = CycloVault(payable(proxy));

        IERC20 asset = IERC20(vault.asset());

        vm.startPrank(DEFAULT_ALICE);
        asset.approve(proxy, expectedAssets);
        uint256 assetBalanceBefore = asset.balanceOf(proxy);
        uint256 sharesBalanceBefore = vault.balanceOf(DEFAULT_ALICE);
        uint256 assets = vault.mint(shares, DEFAULT_ALICE, 0, hex"");
        require(assets == expectedAssets, "assets mismatch");
        require(asset.balanceOf(proxy) == assetBalanceBefore + expectedAssets, "asset balance mismatch");
        require(vault.balanceOf(DEFAULT_ALICE) == sharesBalanceBefore + shares, "DEFAULT_ALICE shares balance mismatch");
        vm.stopPrank();
    }
}
