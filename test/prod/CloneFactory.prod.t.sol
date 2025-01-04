// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";

import {PROD_CLONE_FACTORY_ADDRESS_V1, PROD_CLONE_FACTORY_EXPECTED_CODE_V1} from "src/lib/LibCycloProd.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CloneFactoryProdTest is Test {
    function testProdCloneFactoryBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(PROD_CLONE_FACTORY_EXPECTED_CODE_V1, PROD_CLONE_FACTORY_ADDRESS_V1.code);
    }
}
