// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

/// `CycloVaultConfig` as the vaults decode their clone initialization data.
struct CycloVaultConfig {
    address priceOracle;
    address asset;
    string oracleName;
    string oracleSymbol;
}

/// The `CycloVault` surface the prod tests call.
interface ICycloVault {
    function priceOracle() external view returns (address);
    function asset() external view returns (address);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function receipt() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function previewDeposit(uint256 assets, uint256 minShareRatio) external returns (uint256);
    function previewMint(uint256 shares, uint256 minShareRatio) external returns (uint256);
    function deposit(uint256 assets, address receiver, uint256 depositMinShareRatio, bytes calldata receiptInformation)
        external
        returns (uint256);
    function mint(uint256 shares, address receiver, uint256 mintMinShareRatio, bytes calldata receiptInformation)
        external
        returns (uint256);
}
