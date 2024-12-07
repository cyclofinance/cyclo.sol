// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 thedavidmeister
pragma solidity ^0.8.25;

import {Vm} from "forge-std/Test.sol";

address constant PROD_CYCLO_RECEIPT_ADDRESS = 0xB306F9FC8555c77FCFDb59b8F8901E97B5F02DB4;

uint256 constant PROD_BLOCK_NUMBER = 34048823;

address constant PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS = 0x631aa5175b50B6bdB6fa53bda5a8856D60B282c8;

address constant PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS = 0xB3B391507B7779FD9e4bC9A01e8eC6887C2125d0;

address constant PROD_TWO_PRICE_ORACLE_V2_ADDRESS = 0xcB937201A352cE377d00cbdD3c1e6eC2B9837a5f;

library LibCycloProd {
    function createSelectFork(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_BLOCK_NUMBER);
    }
}
