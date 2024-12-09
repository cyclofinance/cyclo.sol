// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";

import {
    LibCycloProd,
    PROD_CLONE_FACTORY_ADDRESS
} from "test/lib/LibCycloProd.sol";

contract CloneFactoryProdTest is Test {
    function testProdCycloReceiptBytecode() external {
        LibCycloProd.createSelectFork(vm);

        CloneFactory fresh = new CloneFactory();

        assertEq(address(fresh).code, PROD_CLONE_FACTORY_ADDRESS.code);
    }
}
