// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {ReceiptFactoryTest} from "ethgild/../test/abstract/ReceiptFactoryTest.sol";
import {CycloReceipt} from "src/concrete/receipt/CycloReceipt.sol";

contract CycloReceiptFactoryTest is ReceiptFactoryTest {
    CycloReceipt internal immutable iCycloReceiptImplementation;

    constructor() {
        iCycloReceiptImplementation = new CycloReceipt();
    }
}