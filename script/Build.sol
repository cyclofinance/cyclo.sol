// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {BuildScript} from "rain-deploy-0.1.11/src/abstract/BuildScript.sol";
import {LibRainDeploySnapshot} from "rain-deploy-0.1.11/src/lib/LibRainDeploySnapshot.sol";
import {DeployCandidate} from "../src/abstract/RainDeploySuitesBase.sol";
import {CycloDeploySuites} from "../src/abstract/CycloDeploySuites.sol";

/// @title Build
/// @notice Generates the deploy pins for every contract this repo deploys.
/// `run()` rewrites the rolling `src/generated/candidate/` snapshots and the
/// libs under `src/lib/`; `cutRelease()` freezes the candidates into
/// `src/generated/<tag>/` first. With no candidates declared, only the empty
/// `LibReleasedSuites` aggregate is written.
contract Build is BuildScript, CycloDeploySuites {
    /// @inheritdoc BuildScript
    function snapshotContractNames() internal pure override returns (string[] memory) {
        DeployCandidate[] memory candidates = candidateSuites();
        return new string[](candidates.length);
    }

    /// @inheritdoc BuildScript
    function regenerateLibs() internal override {
        LibRainDeploySnapshot.writeReleasedSuitesAggregate(vm, LibRainDeploySnapshot.LIB_DIR, snapshotContractNames());
    }

    /// @inheritdoc BuildScript
    function regenerateSnapshots() internal override {}
}
