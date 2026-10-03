// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_DOT_USD_ADDR,
    BYTECODE_HASH as PYTH_ORACLE_DOT_USD_HASH
} from "../generated/candidate/PythOracleDotUsd.sol";

library LibPythOracleDotUsdDeploy {
    address constant PYTH_ORACLE_DOT_USD_DEPLOYED_ADDRESS = PYTH_ORACLE_DOT_USD_ADDR;
    bytes32 constant PYTH_ORACLE_DOT_USD_DEPLOYED_CODEHASH = PYTH_ORACLE_DOT_USD_HASH;
}
