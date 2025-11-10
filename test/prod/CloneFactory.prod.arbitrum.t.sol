// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";

import {
    PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1,
    PROD_ARBITRUM_CLONE_FACTORY_CODEHASH_V1
} from "src/lib/LibCycloProdCloneFactory.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CloneFactoryProdArbitrumTest is Test {
    function testProdCloneFactoryBytecodeArbitrum() external {
        CloneFactory fresh = new CloneFactory();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_ARBITRUM_CLONE_FACTORY_CODEHASH_V1);

        LibCycloTestProd.createSelectForkArbitrum(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_ARBITRUM_CLONE_FACTORY_ADDRESS_V1, PROD_ARBITRUM_CLONE_FACTORY_CODEHASH_V1
        );
    }
}
