// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {
    DEPLOYED_ADDRESS as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_ADDR,
    BYTECODE_HASH as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_HASH
} from "../generated/candidate/FtsoV2LTSFeedOracleJouleUsd.sol";

library LibFtsoV2LTSFeedOracleJouleUsdDeploy {
    address constant FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPLOYED_ADDRESS = FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_ADDR;
    bytes32 constant FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPLOYED_CODEHASH = FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_HASH;
}
