// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {ReceiptFactoryTest} from "ethgild/../test/abstract/ReceiptFactoryTest.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {CycloVault, ReceiptVaultConstructionConfigV2} from "src/concrete/vault/CycloVault.sol";

contract CycloReceiptFactoryTest is ReceiptFactoryTest {
    CycloReceipt internal immutable I_CYCLO_RECEIPT_IMPLEMENTATION;
    CycloVault internal immutable I_CYCLO_VAULT_IMPLEMENTATION;

    constructor() {
        I_CYCLO_RECEIPT_IMPLEMENTATION = new CycloReceipt();
        I_CYCLO_VAULT_IMPLEMENTATION = new CycloVault(
            ReceiptVaultConstructionConfigV2({factory: I_FACTORY, receiptImplementation: I_CYCLO_RECEIPT_IMPLEMENTATION})
        );
    }
}
