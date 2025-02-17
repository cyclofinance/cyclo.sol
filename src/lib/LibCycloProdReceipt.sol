// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

/// @dev cysFLR was deployed before the versioning so it's a special case.
address constant PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR = 0x901E7A73F7389eA6e32e298353f0239481D8d939;
bytes32 constant PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH =
    bytes32(0x2e16cdca7de5a779a2841613067b52bd6a0936629bf2f0c3ac9faeeb410c2669);

address constant PROD_FLARE_RECEIPT_CYSFLR = 0xd387FC43E19a63036d8FCeD559E81f5dDeF7ef09;
address constant PROD_FLARE_RECEIPT_CYWETH = 0xBE2615A0fcB54A49A1eB472be30d992599FE0968;

address constant PROD_FLARE_CYCLO_RECEIPT_IMPLEMENTATION_V1 = 0x3aCEB4F257c169f9143524FF11092f268294fC7c;
bytes32 constant PROD_FLARE_CYCLO_RECEIPT_CODEHASH_V1 =
    bytes32(0x540ddd9c597f7aca1391ea7ffe978def7b9e1d678a7ee9d3ba097cb69a5ff208);
