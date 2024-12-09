// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std/Test.sol";

address constant PROD_CLONE_FACTORY_ADDRESS = 0x6c91656fDB7251e1B62342fb2494937Ee9025620;

address constant PROD_CYCLO_VAULT_IMPLEMENTATION_ADDRESS = 0x85BcD9E68CA0ae8BC88B3C907D18dea84766d009;

address constant PROD_CYCLO_VAULT_ADDRESS = 0xdf942e09B7BFD4118359b4eaF200251d29dD3375;

address constant PROD_CYCLO_RECEIPT_IMPLEMENTATION_ADDRESS = 0xCa5A3dF5FF38ECF31a0aE43Cd698961b3cDB2d5C;

address constant PROD_CYCLO_RECEIPT_ADDRESS = 0x71c7fD0fF9979302e048A97Af9f60403f0C2bef6;

uint256 constant PROD_BLOCK_NUMBER = 34242727;

address constant PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS = 0x852C2A49D6217fa7F10A13863AfFc29D9029771a;

address constant PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS = 0xaD9A70c5386b3b9c8992276fDFFA922762F27A73;

address constant PROD_TWO_PRICE_ORACLE_V2_ADDRESS = 0x9232a2Ae74A787Cd0030528920A03391A65F9e87;

library LibCycloProd {
    function createSelectFork(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_BLOCK_NUMBER);
    }
}
