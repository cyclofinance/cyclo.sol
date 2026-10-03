// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {RainDeployVerifySnapshot} from "rain-deploy-0.1.11/src/abstract/RainDeployVerifySnapshot.sol";
import {CycloDeploySuites} from "src/abstract/CycloDeploySuites.sol";

/// @title CycloDeploySnapshotTest
/// @notice Binds this repo's declaration to `RainDeployVerifySnapshot`: every
/// deploy-pin assertion over the suites that needs no network.
contract CycloDeploySnapshotTest is CycloDeploySuites, RainDeployVerifySnapshot {}
