// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

import {
    PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS,
    PROD_SCEPTRE_STAKED_FLR_ORACLE_EXPECTED_CODE
} from "src/lib/LibCycloProd.sol";

import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {IPriceOracleV2} from "ethgild/interface/IPriceOracleV2.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";

contract SceptreStakedFlrOracleProdTest is Test {
    function testProdCycloSceptreStakedFlrOraclePrice() external {
        LibCycloTestProd.createSelectFork(vm);

        uint256 price = IPriceOracleV2(payable(PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS)).price();

        assertEq(price, 801087235808987251);
    }

    function testProdCycloSceptreStakedFlrOracleBytecode() external {
        LibCycloTestProd.createSelectFork(vm);

        assertEq(PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS.code, PROD_SCEPTRE_STAKED_FLR_ORACLE_EXPECTED_CODE);
    }

    fallback() external payable {}

    receive() external payable {}
}
