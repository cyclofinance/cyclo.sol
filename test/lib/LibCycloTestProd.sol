// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std-1.16.2/src/Vm.sol";
import {console2} from "forge-std-1.16.2/src/console2.sol";
import {LibExtrospectBytecode} from "rain-extrospection-0.1.14/src/lib/LibExtrospectBytecode.sol";
import {LibExtrospectERC1167Proxy} from "rain-extrospection-0.1.14/src/lib/LibExtrospectERC1167Proxy.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER_FLARE = 51262162;

uint256 constant PROD_TEST_BLOCK_NUMBER_ARBITRUM = 455000000;

library LibCycloTestProd {
    function createSelectForkFlare(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_TEST_BLOCK_NUMBER_FLARE);
    }

    function createSelectForkArbitrum(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_ARBITRUM_FORK"), PROD_TEST_BLOCK_NUMBER_ARBITRUM);
    }

    /// `CREATE` the recorded creation code with its constructor arguments,
    /// exactly as the production deployments were created.
    function deployLegacy(bytes memory creationCode, bytes memory constructorArgs) internal returns (address) {
        bytes memory initCode = abi.encodePacked(creationCode, constructorArgs);
        address deployed;
        assembly ("memory-safe") {
            deployed := create(0, add(initCode, 0x20), mload(initCode))
        }
        require(deployed != address(0), "legacy create failed");
        return deployed;
    }

    function checkBytecodeHash(bytes memory bytecode, bytes32 expected) internal pure {
        bytes32 actual = keccak256(bytecode);
        if (expected != actual) {
            console2.logBytes32(expected);
            console2.logBytes32(actual);
            revert("bytecode hash mismatch");
        }
    }

    /// Deployed code carries the 53-byte ipfs+solc appendix; the recorded
    /// creation code was compiled with `bytecode_hash = "none"` and carries
    /// the 12-byte solc-only one. Either is trimmed before hashing.
    //forge-lint: disable-next-line(mixed-case-function)
    function checkCBORTrimmedBytecodeHash(address account, bytes32 expected) internal view {
        bytes memory bytecode = account.code;
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
}
