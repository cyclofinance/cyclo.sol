// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

address constant PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR = 0x35ea13bBEfF8115fb63E4164237922E491dd21BC;

/// @dev Matches following code at deploy.
/// ERC20PriceOracleReceiptVault fresh = new ERC20PriceOracleReceiptVault(
///     ReceiptVaultConstructionConfig({
///         factory: ICloneableFactoryV2(PROD_CLONE_FACTORY_ADDRESS_V1),
///         receiptImplementation: CycloReceipt(PROD_CYCLO_RECEIPT_IMPLEMENTATION_ADDRESS)
///     })
/// );
bytes32 constant PROD_FLARE_VAULT_IMPLEMENTATION_CYSFLR_CODEHASH = bytes32(0xfa0a43b059a0495e23517e71bbb526d66d11c4e10cbd591d791f02b4108fe2bf);

address constant PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR = 0x901E7A73F7389eA6e32e298353f0239481D8d939;

/// @dev Matches following code at deploy.
/// CycloReceipt fresh = new CycloReceipt();
bytes32 constant PROD_FLARE_RECEIPT_IMPLEMENTATION_CYSFLR_CODEHASH = bytes32(0xba482c84c826ff002e45a9cbcbc4b3388410d6ca3d95542aba2b729e411f5381);

address constant PROD_FLARE_CYCLO_VAULT_IMPLEMENTATION_V1 = 0x1D35c1392EF799253e61DaA143d055E6b3F1f8eA;

address constant PROD_FLARE_VAULT_CYSFLR = 0x19831cfB53A0dbeAD9866C43557C1D48DfF76567;
address constant PROD_FLARE_VAULT_CYWETH = 0xB771384475cc49AF079Cd21BEd845dcb13bC417a;

address constant PROD_FLARE_RECEIPT_CYSFLR = 0xd387FC43E19a63036d8FCeD559E81f5dDeF7ef09;
address constant PROD_FLARE_RECEIPT_CYWETH = 0xB61fa4cD42Af70A317398cD12db86458451229ac;
