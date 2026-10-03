// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {
    DEPLOYED_ADDRESS as CYCLO_RECEIPT_ADDR,
    BYTECODE_HASH as CYCLO_RECEIPT_HASH
} from "../generated/candidate/CycloReceipt.sol";

library LibCycloReceiptDeploy {
    address constant CYCLO_RECEIPT_DEPLOYED_ADDRESS = CYCLO_RECEIPT_ADDR;
    bytes32 constant CYCLO_RECEIPT_DEPLOYED_CODEHASH = CYCLO_RECEIPT_HASH;
}
