// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {ReceiptFactoryTest} from "ethgild/../test/abstract/ReceiptFactoryTest.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";
import {CycloVault, ReceiptVaultConstructionConfig} from "src/concrete/vault/CycloVault.sol";

contract CycloReceiptFactoryTest is ReceiptFactoryTest {
    CycloReceipt internal immutable iCycloReceiptImplementation;
    CycloVault internal immutable iCycloVaultImplementation;

    constructor() {
        iCycloReceiptImplementation = new CycloReceipt();
        iCycloVaultImplementation = new CycloVault(
            ReceiptVaultConstructionConfig({factory: iFactory, receiptImplementation: iCycloReceiptImplementation})
        );
    }
}
