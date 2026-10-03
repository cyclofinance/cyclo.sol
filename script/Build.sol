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
        GeneratedContract[] memory contracts = new GeneratedContract[](20);
        contracts[0] = GeneratedContract("CloneFactory", "CLONE_FACTORY", cloneFactoryCandidate());
        contracts[1] = GeneratedContract("CycloReceipt", "CYCLO_RECEIPT", cycloReceiptCandidate());
        contracts[2] = GeneratedContract("CycloVault", "CYCLO_VAULT", cycloVaultCandidate());
        contracts[3] =
            GeneratedContract("SceptreStakedFlrOracle", "SCEPTRE_STAKED_FLR_ORACLE", sceptreStakedFlrOracleCandidate());
        contracts[4] = GeneratedContract(
            "FtsoV2LTSFeedOracleFlrUsd", "FTSO_V2_LTS_FEED_ORACLE_FLR_USD", ftsoV2LTSFeedOracleFlrUsdCandidate()
        );
        contracts[5] = GeneratedContract(
            "FtsoV2LTSFeedOracleEthUsd", "FTSO_V2_LTS_FEED_ORACLE_ETH_USD", ftsoV2LTSFeedOracleEthUsdCandidate()
        );
        contracts[6] = GeneratedContract(
            "FtsoV2LTSFeedOracleXrpUsd", "FTSO_V2_LTS_FEED_ORACLE_XRP_USD", ftsoV2LTSFeedOracleXrpUsdCandidate()
        );
        contracts[7] = GeneratedContract(
            "FtsoV2LTSFeedOracleJouleUsd", "FTSO_V2_LTS_FEED_ORACLE_JOULE_USD", ftsoV2LTSFeedOracleJouleUsdCandidate()
        );
        contracts[8] = GeneratedContract("PythOracleWethUsd", "PYTH_ORACLE_WETH_USD", pythOracleWethUsdCandidate());
        contracts[9] = GeneratedContract("PythOracleWstethUsd", "PYTH_ORACLE_WSTETH_USD", pythOracleWstethUsdCandidate());
        contracts[10] = GeneratedContract("PythOracleWbtcUsd", "PYTH_ORACLE_WBTC_USD", pythOracleWbtcUsdCandidate());
        contracts[11] = GeneratedContract("PythOracleCbbtcUsd", "PYTH_ORACLE_CBBTC_USD", pythOracleCbbtcUsdCandidate());
        contracts[12] = GeneratedContract("PythOracleLinkUsd", "PYTH_ORACLE_LINK_USD", pythOracleLinkUsdCandidate());
        contracts[13] = GeneratedContract("PythOracleDotUsd", "PYTH_ORACLE_DOT_USD", pythOracleDotUsdCandidate());
        contracts[14] = GeneratedContract("PythOracleUniUsd", "PYTH_ORACLE_UNI_USD", pythOracleUniUsdCandidate());
        contracts[15] = GeneratedContract("PythOraclePepeUsd", "PYTH_ORACLE_PEPE_USD", pythOraclePepeUsdCandidate());
        contracts[16] = GeneratedContract("PythOraclePythUsd", "PYTH_ORACLE_PYTH_USD", pythOraclePythUsdCandidate());
        contracts[17] = GeneratedContract("PythOracleEnaUsd", "PYTH_ORACLE_ENA_USD", pythOracleEnaUsdCandidate());
        contracts[18] = GeneratedContract("PythOracleArbUsd", "PYTH_ORACLE_ARB_USD", pythOracleArbUsdCandidate());
        contracts[19] = GeneratedContract("PythOracleXautUsd", "PYTH_ORACLE_XAUT_USD", pythOracleXautUsdCandidate());
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
                LibRainDeploySnapshot.CANDIDATE,
                contracts[i].contractName,
                contracts[i].candidate.sourceCreationCode,
                contracts[i].candidate.snapshot.dependencies
            );
        }
    }
}
