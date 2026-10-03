// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {
    DEPLOYED_ADDRESS as CLONE_FACTORY_ADDR,
    BYTECODE_HASH as CLONE_FACTORY_HASH
} from "../generated/candidate/CloneFactory.sol";

library LibCloneFactoryDeploy {
    address constant CLONE_FACTORY_DEPLOYED_ADDRESS = CLONE_FACTORY_ADDR;
    bytes32 constant CLONE_FACTORY_DEPLOYED_CODEHASH = CLONE_FACTORY_HASH;
}
