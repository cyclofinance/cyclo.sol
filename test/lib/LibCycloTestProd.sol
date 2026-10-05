// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std-1.16.2/src/Vm.sol";
import {console2} from "forge-std-1.16.2/src/console2.sol";
import {IERC20} from "forge-std-1.16.2/src/interfaces/IERC20.sol";
import {LibExtrospectBytecode} from "rain-extrospection-0.1.14/src/lib/LibExtrospectBytecode.sol";
import {LibExtrospectERC1167Proxy} from "rain-extrospection-0.1.14/src/lib/LibExtrospectERC1167Proxy.sol";
import {ICloneableV2} from "test/interface/ICloneableV2.sol";
import {ICycloVault} from "test/interface/ICycloVault.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER_FLARE = 51262162;

uint256 constant PROD_TEST_BLOCK_NUMBER_ARBITRUM = 455000000;

string constant PROD_CYSFLR_RECEIPT_SYMBOL = "cysFLR RCPT";
string constant PROD_CYSFLR_RECEIPT_NAME = "cysFLR Receipt";

address constant DEFAULT_ALICE = address(uint160(uint256(keccak256("ALICE"))));

library LibCycloTestProd {
    function createSelectForkFlare(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_TEST_BLOCK_NUMBER_FLARE);
    }

    function createSelectForkArbitrum(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_ARBITRUM_FORK"), PROD_TEST_BLOCK_NUMBER_ARBITRUM);
    }

    /// `CREATE` a recorded creation code, constructor arguments included.
    function deploy(bytes memory creationCode) internal returns (address deployed) {
        assembly ("memory-safe") {
            deployed := create(0, add(creationCode, 0x20), mload(creationCode))
        }
        require(deployed != address(0), "create failed");
    }

    function checkBytecodeHash(bytes memory bytecode, bytes32 expected) internal pure {
        bytes32 actual = keccak256(bytecode);
        if (expected != actual) {
            console2.logBytes32(expected);
            console2.logBytes32(actual);
            revert("bytecode hash mismatch");
        }
    }

    //forge-lint: disable-next-line(mixed-case-function)
    function checkCBORTrimmedBytecodeHash(address account, bytes32 expected) internal view {
        checkCBORTrimmedBytecodeHash(account.code, expected);
    }

    /// Deployed code carries the 53-byte ipfs+solc appendix; the recorded
    /// code carries the 12-byte solc-only one. Either is trimmed before
    /// hashing.
    //forge-lint: disable-next-line(mixed-case-function)
    function checkCBORTrimmedBytecodeHash(bytes memory bytecode, bytes32 expected) internal pure {
        if (!LibExtrospectBytecode.tryTrimSolidityCBORMetadata(bytecode)) {
            uint256 length = bytecode.length;
            require(
                length >= 12 && bytecode[length - 12] == 0xa1 && bytecode[length - 1] == 0x0a, "metadata not trimmed"
            );
            assembly ("memory-safe") {
                mstore(bytecode, sub(length, 12))
            }
        }
        checkBytecodeHash(bytecode, expected);
    }

    //forge-lint: disable-next-line(mixed-case-function)
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
        ICycloVault vault = ICycloVault(proxy);
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

    function checkMint(Vm vm, address proxy, uint256 shares, uint256 expectedAssets, address alice) internal {
        ICycloVault vault = ICycloVault(proxy);
        IERC20 asset = IERC20(vault.asset());
        vm.startPrank(alice);
        asset.approve(proxy, expectedAssets);
        uint256 assetBalanceBefore = asset.balanceOf(proxy);
        uint256 sharesBalanceBefore = vault.balanceOf(alice);
        uint256 assets = vault.mint(shares, alice, 0, hex"");
        require(assets == expectedAssets, "assets mismatch");
        require(asset.balanceOf(proxy) == assetBalanceBefore + expectedAssets, "asset balance mismatch");
        require(vault.balanceOf(alice) == sharesBalanceBefore + shares, "alice shares balance mismatch");
        vm.stopPrank();
    }

    function checkMint(Vm vm, address proxy, uint256 shares, uint256 expectedAssets) internal {
        checkMint(vm, proxy, shares, expectedAssets, DEFAULT_ALICE);
    }
}
