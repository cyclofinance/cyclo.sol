// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {BuildScript} from "rain-deploy-0.1.11/src/abstract/BuildScript.sol";
import {LibRainDeploySnapshot} from "rain-deploy-0.1.11/src/lib/LibRainDeploySnapshot.sol";
import {DeployCandidate} from "../src/abstract/RainDeploySuitesBase.sol";
import {CycloDeploySuites} from "../src/abstract/CycloDeploySuites.sol";

/// One contract's generated files: the rolling snapshot, the alias lib that
/// re-exports its pins and the released-suites lib emitted from its record.
struct GeneratedContract {
    /// Places the snapshot inside `src/generated/<dir>/` and names both
    /// generated libs.
    string contractName;
    /// Prefix for the constants the alias lib exports.
    string constantPrefix;
    /// Snapshots are written from its `sourceCreationCode` and
    /// `snapshot.dependencies`; the released lib takes its suite key and
    /// artifact path from its `snapshot`.
    DeployCandidate candidate;
}

/// @title Build
/// @notice Generates the deploy pins for every contract this repo deploys.
/// `run()` rewrites the rolling `src/generated/candidate/` snapshots and the
/// libs under `src/lib/`; `cutRelease()` freezes the candidates into
/// `src/generated/<tag>/` first.
contract Build is BuildScript, CycloDeploySuites {
    function generatedContracts() internal pure returns (GeneratedContract[] memory) {
        string[20] memory names = [
            "CloneFactory",
            "CycloReceipt",
            "CycloVault",
            "SceptreStakedFlrOracle",
            "FtsoV2LTSFeedOracleFlrUsd",
            "FtsoV2LTSFeedOracleEthUsd",
            "FtsoV2LTSFeedOracleXrpUsd",
            "FtsoV2LTSFeedOracleJouleUsd",
            "PythOracleWethUsd",
            "PythOracleWstethUsd",
            "PythOracleWbtcUsd",
            "PythOracleCbbtcUsd",
            "PythOracleLinkUsd",
            "PythOracleDotUsd",
            "PythOracleUniUsd",
            "PythOraclePepeUsd",
            "PythOraclePythUsd",
            "PythOracleEnaUsd",
            "PythOracleArbUsd",
            "PythOracleXautUsd"
        ];
        string[20] memory prefixes = [
            "CLONE_FACTORY",
            "CYCLO_RECEIPT",
            "CYCLO_VAULT",
            "SCEPTRE_STAKED_FLR_ORACLE",
            "FTSO_V2_LTS_FEED_ORACLE_FLR_USD",
            "FTSO_V2_LTS_FEED_ORACLE_ETH_USD",
            "FTSO_V2_LTS_FEED_ORACLE_XRP_USD",
            "FTSO_V2_LTS_FEED_ORACLE_JOULE_USD",
            "PYTH_ORACLE_WETH_USD",
            "PYTH_ORACLE_WSTETH_USD",
            "PYTH_ORACLE_WBTC_USD",
            "PYTH_ORACLE_CBBTC_USD",
            "PYTH_ORACLE_LINK_USD",
            "PYTH_ORACLE_DOT_USD",
            "PYTH_ORACLE_UNI_USD",
            "PYTH_ORACLE_PEPE_USD",
            "PYTH_ORACLE_PYTH_USD",
            "PYTH_ORACLE_ENA_USD",
            "PYTH_ORACLE_ARB_USD",
            "PYTH_ORACLE_XAUT_USD"
        ];
        // Same order as `candidateSuites()`, which is the one list of candidates.
        DeployCandidate[] memory candidates = candidateSuites();
        GeneratedContract[] memory contracts = new GeneratedContract[](candidates.length);
        for (uint256 i = 0; i < candidates.length; i++) {
            contracts[i] = GeneratedContract({contractName: names[i], constantPrefix: prefixes[i], candidate: candidates[i]});
        }
        return contracts;
    }

    /// @inheritdoc BuildScript
    function snapshotContractNames() internal pure override returns (string[] memory) {
        GeneratedContract[] memory contracts = generatedContracts();
        string[] memory names = new string[](contracts.length);
        for (uint256 i = 0; i < contracts.length; i++) {
            names[i] = contracts[i].contractName;
        }
        return names;
    }

    /// @inheritdoc BuildScript
    function regenerateLibs() internal override {
        GeneratedContract[] memory contracts = generatedContracts();
        for (uint256 i = 0; i < contracts.length; i++) {
            LibRainDeploySnapshot.writeAliasLib(
                vm,
                LibRainDeploySnapshot.LIB_DIR,
                contracts[i].contractName,
                contracts[i].constantPrefix,
                LibRainDeploySnapshot.CANDIDATE
            );
            LibRainDeploySnapshot.writeReleasedSuitesLib(
                vm,
                LibRainDeploySnapshot.LIB_DIR,
                recordRoot(),
                contracts[i].contractName,
                contracts[i].candidate.snapshot
            );
        }
        LibRainDeploySnapshot.writeReleasedSuitesAggregate(vm, LibRainDeploySnapshot.LIB_DIR, snapshotContractNames());
    }

    /// @inheritdoc BuildScript
    function regenerateSnapshots() internal override {
        GeneratedContract[] memory contracts = generatedContracts();
        for (uint256 i = 0; i < contracts.length; i++) {
            LibRainDeploySnapshot.writeSnapshot(
                vm,
                recordRoot(),
                LibRainDeploySnapshot.CANDIDATE,
                contracts[i].contractName,
                contracts[i].candidate.sourceCreationCode,
                contracts[i].candidate.snapshot.dependencies
            );
        }
    }
}
