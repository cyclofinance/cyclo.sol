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
        // Filled by index: a 20-element array literal is evaluated on the stack and
        // overflows it.
        string[] memory names = new string[](20);
        string[] memory prefixes = new string[](20);
        names[0] = "CloneFactory";
        prefixes[0] = "CLONE_FACTORY";
        names[1] = "CycloReceipt";
        prefixes[1] = "CYCLO_RECEIPT";
        names[2] = "CycloVault";
        prefixes[2] = "CYCLO_VAULT";
        names[3] = "SceptreStakedFlrOracle";
        prefixes[3] = "SCEPTRE_STAKED_FLR_ORACLE";
        names[4] = "FtsoV2LTSFeedOracleFlrUsd";
        prefixes[4] = "FTSO_V2_LTS_FEED_ORACLE_FLR_USD";
        names[5] = "FtsoV2LTSFeedOracleEthUsd";
        prefixes[5] = "FTSO_V2_LTS_FEED_ORACLE_ETH_USD";
        names[6] = "FtsoV2LTSFeedOracleXrpUsd";
        prefixes[6] = "FTSO_V2_LTS_FEED_ORACLE_XRP_USD";
        names[7] = "FtsoV2LTSFeedOracleJouleUsd";
        prefixes[7] = "FTSO_V2_LTS_FEED_ORACLE_JOULE_USD";
        names[8] = "PythOracleWethUsd";
        prefixes[8] = "PYTH_ORACLE_WETH_USD";
        names[9] = "PythOracleWstethUsd";
        prefixes[9] = "PYTH_ORACLE_WSTETH_USD";
        names[10] = "PythOracleWbtcUsd";
        prefixes[10] = "PYTH_ORACLE_WBTC_USD";
        names[11] = "PythOracleCbbtcUsd";
        prefixes[11] = "PYTH_ORACLE_CBBTC_USD";
        names[12] = "PythOracleLinkUsd";
        prefixes[12] = "PYTH_ORACLE_LINK_USD";
        names[13] = "PythOracleDotUsd";
        prefixes[13] = "PYTH_ORACLE_DOT_USD";
        names[14] = "PythOracleUniUsd";
        prefixes[14] = "PYTH_ORACLE_UNI_USD";
        names[15] = "PythOraclePepeUsd";
        prefixes[15] = "PYTH_ORACLE_PEPE_USD";
        names[16] = "PythOraclePythUsd";
        prefixes[16] = "PYTH_ORACLE_PYTH_USD";
        names[17] = "PythOracleEnaUsd";
        prefixes[17] = "PYTH_ORACLE_ENA_USD";
        names[18] = "PythOracleArbUsd";
        prefixes[18] = "PYTH_ORACLE_ARB_USD";
        names[19] = "PythOracleXautUsd";
        prefixes[19] = "PYTH_ORACLE_XAUT_USD";
        // Same order as `candidateSuites()`, which is the one list of candidates.
        DeployCandidate[] memory candidates = candidateSuites();
        GeneratedContract[] memory contracts = new GeneratedContract[](candidates.length);
        for (uint256 i = 0; i < candidates.length; i++) {
            contracts[i] =
                GeneratedContract({contractName: names[i], constantPrefix: prefixes[i], candidate: candidates[i]});
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

    /// One contract's alias lib and released-suites lib. Its own frame, so the
    /// loop below stays within the stack.
    function writeLibs(GeneratedContract memory generated) internal {
        LibRainDeploySnapshot.writeAliasLib(
            vm,
            LibRainDeploySnapshot.LIB_DIR,
            generated.contractName,
            generated.constantPrefix,
            LibRainDeploySnapshot.CANDIDATE
        );
        LibRainDeploySnapshot.writeReleasedSuitesLib(
            vm, LibRainDeploySnapshot.LIB_DIR, recordRoot(), generated.contractName, generated.candidate.snapshot
        );
    }

    /// @inheritdoc BuildScript
    function regenerateLibs() internal override {
        GeneratedContract[] memory contracts = generatedContracts();
        for (uint256 i = 0; i < contracts.length; i++) {
            writeLibs(contracts[i]);
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
