// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
} from "src/lib/LibCycloProdOracle.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";

contract SceptreStakedFlrOracleProdTest is Test {
    function testProdCycloSceptreStakedFlrOraclePrice() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        uint256 price = IPriceOracleV2(payable(PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE)).price();
        assertEq(price, 0.602722619977280327e18);
    }

    function testProdCycloSceptreStakedFlrOracleBytecode() external {
        SceptreStakedFlrOracle fresh = new SceptreStakedFlrOracle();

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(address(fresh), PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH);

        LibCycloTestProd.createSelectForkFlare(vm);

        LibCycloTestProd.checkCBORTrimmedBytecodeHash(
            PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE, PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH
        );
    }

    fallback() external payable {}

    receive() external payable {}
}
