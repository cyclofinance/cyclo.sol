// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";

import {
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V1,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V1,
    PROD_FLARE_CLONE_FACTORY_ADDRESS_V2,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_V2,
    PROD_FLARE_CLONE_FACTORY_ADDRESS_LATEST,
    PROD_FLARE_CLONE_FACTORY_CODEHASH_LATEST
} from "script/lib/LibCycloProdCloneFactory.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

contract CloneFactoryProdTest is Test {
    function testProdCloneFactoryBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        CloneFactory fresh = new CloneFactory();
        assertEq(PROD_FLARE_CLONE_FACTORY_CODEHASH_LATEST, address(fresh).codehash, "latest fresh mismatch");
        assertEq(
            PROD_FLARE_CLONE_FACTORY_ADDRESS_LATEST.codehash,
            PROD_FLARE_CLONE_FACTORY_CODEHASH_LATEST,
            "latest prod mismatch"
        );

        assertEq(PROD_FLARE_CLONE_FACTORY_CODEHASH_V1, PROD_FLARE_CLONE_FACTORY_ADDRESS_V1.codehash);
        assertEq(PROD_FLARE_CLONE_FACTORY_CODEHASH_V2, PROD_FLARE_CLONE_FACTORY_ADDRESS_V2.codehash);
    }
}
