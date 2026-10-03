// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {
    DEPLOYED_ADDRESS as CYCLO_VAULT_ADDR,
    BYTECODE_HASH as CYCLO_VAULT_HASH
} from "../generated/candidate/CycloVault.sol";

library LibCycloVaultDeploy {
    address constant CYCLO_VAULT_DEPLOYED_ADDRESS = CYCLO_VAULT_ADDR;
    bytes32 constant CYCLO_VAULT_DEPLOYED_CODEHASH = CYCLO_VAULT_HASH;
}
