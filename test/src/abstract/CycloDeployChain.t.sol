// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {RainDeployVerifyChain} from "rain-deploy-0.1.11/src/abstract/RainDeployVerifyChain.sol";
import {CycloDeploySuites} from "src/abstract/CycloDeploySuites.sol";

/// @title CycloDeployChainTest
/// @notice Binds this repo's declaration to `RainDeployVerifyChain`: every
/// release is live, with the code it froze, on every supported network.
contract CycloDeployChainTest is CycloDeploySuites, RainDeployVerifyChain {}
