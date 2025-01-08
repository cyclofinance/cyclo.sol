// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std/Test.sol";

uint256 constant PROD_TEST_BLOCK_NUMBER = 35762126;

string constant PROD_CYSFLR_RECEIPT_SYMBOL = "cysFLR RCPT";
string constant PROD_CYSFLR_RECEIPT_NAME = "cysFLR Receipt";

library LibCycloTestProd {
    function createSelectFork(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_TEST_BLOCK_NUMBER);
    }
}
