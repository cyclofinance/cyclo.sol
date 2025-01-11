// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm, console2} from "forge-std/Test.sol";
import {LibExtrospectBytecode} from "rain.extrospection/lib/LibExtrospectBytecode.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER = 35762126;

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
}
