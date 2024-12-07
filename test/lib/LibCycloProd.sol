// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std/Test.sol";

address constant PROD_CYCLO_VAULT_ADDRESS = 0x6Eb062Ba625ccafeD34450d80f24Ba11bcef374C;

address constant PROD_CYCLO_RECEIPT_ADDRESS = 0x6A512b5cD7DF91fA8193E89BD8BD5264519BbF85;

address constant PROD_CYCLO_RECEIPT_INITIAL_OWNER = 0xDF1802C9Ab5ED41615cC8Db10Ee8c1c0EA56dBc7;

uint256 constant PROD_BLOCK_NUMBER = 34149210;

address constant PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS = 0x73417897c897cEaFb97488595D2606cB47AcEbb5;

address constant PROD_FTSO_V2_LTS_FEED_ORACLE_ADDRESS = 0x8d66b9f67694973253bf9670C395bD02dc2Ec396;

address constant PROD_TWO_PRICE_ORACLE_V2_ADDRESS = 0x79E34B6f964a1179B38e71D001905376Eea46694;

library LibCycloProd {
    function createSelectFork(Vm vm) internal {
        vm.createSelectFork(vm.envString("RPC_URL_FLARE_FORK"), PROD_BLOCK_NUMBER);
    }
}
