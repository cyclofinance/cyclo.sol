// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {DeployCandidate, DeploySuite, RainDeploySuitesBase} from "./RainDeploySuitesBase.sol";
import {LibReleasedSuites} from "../lib/LibReleasedSuites.sol";

/// @title CycloDeploySuites
/// @notice The suites this repo deploys. None yet: the production deployments
/// predate the registry and are recorded as bytecode under `src/legacy/`, and
/// the next contract sources arrive with the rain-vats upgrade.
abstract contract CycloDeploySuites is RainDeploySuitesBase {
    /// @inheritdoc RainDeploySuitesBase
    function releasedSuites() internal pure override returns (DeploySuite[] memory) {
        return LibReleasedSuites.releasedSuites();
    }

    /// @inheritdoc RainDeploySuitesBase
    function candidateSuites() internal pure override returns (DeployCandidate[] memory) {
        return new DeployCandidate[](0);
    }
}
