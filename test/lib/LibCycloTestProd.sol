// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm, console2} from "forge-std/Test.sol";
import {LibExtrospectBytecode} from "rain.extrospection/lib/LibExtrospectBytecode.sol";
import {LibExtrospectERC1167Proxy} from "rain.extrospection/lib/LibExtrospectERC1167Proxy.sol";
import {ICloneableV2} from "rain.factory/interface/ICloneableV2.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER = 36027887;

string constant PROD_CYSFLR_RECEIPT_SYMBOL = "cysFLR RCPT";
string constant PROD_CYSFLR_RECEIPT_NAME = "cysFLR Receipt";

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
}
