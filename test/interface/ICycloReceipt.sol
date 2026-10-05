// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

error ZeroReceiptId();

/// The `CycloReceipt` surface the prod tests call.
interface ICycloReceipt {
    function manager() external view returns (address);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function uri(uint256 id) external view returns (string memory);
}
