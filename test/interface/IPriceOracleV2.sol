// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

/// The price oracle surface the prod tests call.
interface IPriceOracleV2 {
    function price() external payable returns (uint256);
}
