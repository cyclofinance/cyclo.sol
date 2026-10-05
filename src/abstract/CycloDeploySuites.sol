// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {DeployCandidate, DeploySuite, RainDeploySuitesBase} from "./RainDeploySuitesBase.sol";
import {LibReleasedSuites} from "../lib/LibReleasedSuites.sol";

import {
    DEPLOYED_ADDRESS as CYCLO_RECEIPT_ADDRESS,
    BYTECODE_HASH as CYCLO_RECEIPT_HASH,
    CREATION_CODE as CYCLO_RECEIPT_CREATION,
    RUNTIME_CODE as CYCLO_RECEIPT_RUNTIME,
    DEPENDENCIES as CYCLO_RECEIPT_DEPENDENCIES
} from "../generated/candidate/CycloReceipt.sol";
import {
    DEPLOYED_ADDRESS as CYCLO_VAULT_FLARE_ADDRESS,
    BYTECODE_HASH as CYCLO_VAULT_FLARE_HASH,
    CREATION_CODE as CYCLO_VAULT_FLARE_CREATION,
    RUNTIME_CODE as CYCLO_VAULT_FLARE_RUNTIME,
    DEPENDENCIES as CYCLO_VAULT_FLARE_DEPENDENCIES
} from "../generated/candidate/CycloVaultFlare.sol";
import {
    DEPLOYED_ADDRESS as CYCLO_VAULT_ARBITRUM_ADDRESS,
    BYTECODE_HASH as CYCLO_VAULT_ARBITRUM_HASH,
    CREATION_CODE as CYCLO_VAULT_ARBITRUM_CREATION,
    RUNTIME_CODE as CYCLO_VAULT_ARBITRUM_RUNTIME,
    DEPENDENCIES as CYCLO_VAULT_ARBITRUM_DEPENDENCIES
} from "../generated/candidate/CycloVaultArbitrum.sol";
import {
    DEPLOYED_ADDRESS as SCEPTRE_STAKED_FLR_ORACLE_ADDRESS,
    BYTECODE_HASH as SCEPTRE_STAKED_FLR_ORACLE_HASH,
    CREATION_CODE as SCEPTRE_STAKED_FLR_ORACLE_CREATION,
    RUNTIME_CODE as SCEPTRE_STAKED_FLR_ORACLE_RUNTIME,
    DEPENDENCIES as SCEPTRE_STAKED_FLR_ORACLE_DEPENDENCIES
} from "../generated/candidate/SceptreStakedFlrOracle.sol";
import {
    DEPLOYED_ADDRESS as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_ADDRESS,
    BYTECODE_HASH as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_HASH,
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_CREATION,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME,
    DEPENDENCIES as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_DEPENDENCIES
} from "../generated/candidate/FtsoV2LTSFeedOracleFlrUsd.sol";
import {
    DEPLOYED_ADDRESS as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_ADDRESS,
    BYTECODE_HASH as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_HASH,
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_CREATION,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME,
    DEPENDENCIES as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_DEPENDENCIES
} from "../generated/candidate/FtsoV2LTSFeedOracleEthUsd.sol";
import {
    DEPLOYED_ADDRESS as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_ADDRESS,
    BYTECODE_HASH as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_HASH,
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_CREATION,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME,
    DEPENDENCIES as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_DEPENDENCIES
} from "../generated/candidate/FtsoV2LTSFeedOracleXrpUsd.sol";
import {
    DEPLOYED_ADDRESS as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_ADDRESS,
    BYTECODE_HASH as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_HASH,
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_CREATION,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME,
    DEPENDENCIES as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPENDENCIES
} from "../generated/candidate/FtsoV2LTSFeedOracleJouleUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_WETH_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_WETH_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_WETH_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_WETH_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_WETH_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleWethUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_WSTETH_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_WSTETH_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_WSTETH_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_WSTETH_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_WSTETH_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleWstethUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_WBTC_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_WBTC_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_WBTC_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_WBTC_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_WBTC_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleWbtcUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_CBBTC_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_CBBTC_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_CBBTC_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_CBBTC_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_CBBTC_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleCbbtcUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_LINK_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_LINK_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_LINK_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_LINK_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_LINK_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleLinkUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_DOT_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_DOT_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_DOT_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_DOT_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_DOT_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleDotUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_UNI_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_UNI_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_UNI_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_UNI_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_UNI_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleUniUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_PEPE_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_PEPE_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_PEPE_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_PEPE_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_PEPE_USD_DEPENDENCIES
} from "../generated/candidate/PythOraclePepeUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_PYTH_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_PYTH_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_PYTH_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_PYTH_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_PYTH_USD_DEPENDENCIES
} from "../generated/candidate/PythOraclePythUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_ENA_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_ENA_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_ENA_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_ENA_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_ENA_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleEnaUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_ARB_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_ARB_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_ARB_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_ARB_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_ARB_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleArbUsd.sol";
import {
    DEPLOYED_ADDRESS as PYTH_ORACLE_XAUT_USD_ADDRESS,
    BYTECODE_HASH as PYTH_ORACLE_XAUT_USD_HASH,
    CREATION_CODE as PYTH_ORACLE_XAUT_USD_CREATION,
    RUNTIME_CODE as PYTH_ORACLE_XAUT_USD_RUNTIME,
    DEPENDENCIES as PYTH_ORACLE_XAUT_USD_DEPENDENCIES
} from "../generated/candidate/PythOracleXautUsd.sol";
import {
    DEPLOYED_ADDRESS as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_ADDRESS,
    BYTECODE_HASH as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_HASH,
    CREATION_CODE as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_CREATION,
    RUNTIME_CODE as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_RUNTIME,
    DEPENDENCIES as TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_DEPENDENCIES
} from "../generated/candidate/TwoPriceOracleV2FlrUsdSflr.sol";

/// @title CycloDeploySuites
/// @notice One candidate per production deployment, constructed with the
/// arguments that deployment was constructed with. The production contracts
/// predate the registry and were created with plain `CREATE`, so each
/// candidate's source is its own recorded creation code: the record is the
/// bytes, and `LibCycloProdReproduction` matches them to production.
abstract contract CycloDeploySuites is RainDeploySuitesBase {
    /// @inheritdoc RainDeploySuitesBase
    function releasedSuites() internal pure override returns (DeploySuite[] memory) {
        return LibReleasedSuites.releasedSuites();
    }

    /// @inheritdoc RainDeploySuitesBase
    function candidateSuites() internal pure override returns (DeployCandidate[] memory) {
        DeployCandidate[] memory candidates = new DeployCandidate[](21);
        candidates[0] = cycloReceiptCandidate();
        candidates[1] = cycloVaultFlareCandidate();
        candidates[2] = cycloVaultArbitrumCandidate();
        candidates[3] = sceptreStakedFlrOracleCandidate();
        candidates[4] = ftsoV2LTSFeedOracleFlrUsdCandidate();
        candidates[5] = ftsoV2LTSFeedOracleEthUsdCandidate();
        candidates[6] = ftsoV2LTSFeedOracleXrpUsdCandidate();
        candidates[7] = ftsoV2LTSFeedOracleJouleUsdCandidate();
        candidates[8] = pythOracleWethUsdCandidate();
        candidates[9] = pythOracleWstethUsdCandidate();
        candidates[10] = pythOracleWbtcUsdCandidate();
        candidates[11] = pythOracleCbbtcUsdCandidate();
        candidates[12] = pythOracleLinkUsdCandidate();
        candidates[13] = pythOracleDotUsdCandidate();
        candidates[14] = pythOracleUniUsdCandidate();
        candidates[15] = pythOraclePepeUsdCandidate();
        candidates[16] = pythOraclePythUsdCandidate();
        candidates[17] = pythOracleEnaUsdCandidate();
        candidates[18] = pythOracleArbUsdCandidate();
        candidates[19] = pythOracleXautUsdCandidate();
        candidates[20] = twoPriceOracleV2FlrUsdSflrCandidate();
        return candidates;
    }

    function candidate(
        string memory suite,
        bytes memory creationCode,
        address storedDeployedAddress,
        bytes32 storedBytecodeHash,
        bytes memory storedRuntimeCode,
        string memory artifactPath,
        address[] memory dependencies,
        bytes memory sourceCreationCode
    ) internal pure returns (DeployCandidate memory) {
        return DeployCandidate({
            snapshot: DeploySuite({
                suite: suite,
                creationCode: creationCode,
                storedDeployedAddress: storedDeployedAddress,
                storedBytecodeHash: storedBytecodeHash,
                storedRuntimeCode: storedRuntimeCode,
                artifactPath: artifactPath,
                dependencies: dependencies
            }),
            sourceCreationCode: sourceCreationCode
        });
    }

    function cycloReceiptCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "cyclo-receipt",
            CYCLO_RECEIPT_CREATION,
            CYCLO_RECEIPT_ADDRESS,
            CYCLO_RECEIPT_HASH,
            CYCLO_RECEIPT_RUNTIME,
            "src/concrete/receipt/CycloReceipt.sol:CycloReceipt",
            abi.decode(CYCLO_RECEIPT_DEPENDENCIES, (address[])),
            CYCLO_RECEIPT_CREATION
        );
    }

    function cycloVaultFlareCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "cyclo-vault-flare",
            CYCLO_VAULT_FLARE_CREATION,
            CYCLO_VAULT_FLARE_ADDRESS,
            CYCLO_VAULT_FLARE_HASH,
            CYCLO_VAULT_FLARE_RUNTIME,
            "src/concrete/vault/CycloVault.sol:CycloVault",
            abi.decode(CYCLO_VAULT_FLARE_DEPENDENCIES, (address[])),
            CYCLO_VAULT_FLARE_CREATION
        );
    }

    function cycloVaultArbitrumCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "cyclo-vault-arbitrum",
            CYCLO_VAULT_ARBITRUM_CREATION,
            CYCLO_VAULT_ARBITRUM_ADDRESS,
            CYCLO_VAULT_ARBITRUM_HASH,
            CYCLO_VAULT_ARBITRUM_RUNTIME,
            "src/concrete/vault/CycloVault.sol:CycloVault",
            abi.decode(CYCLO_VAULT_ARBITRUM_DEPENDENCIES, (address[])),
            CYCLO_VAULT_ARBITRUM_CREATION
        );
    }

    function sceptreStakedFlrOracleCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "sceptre-staked-flr-oracle",
            SCEPTRE_STAKED_FLR_ORACLE_CREATION,
            SCEPTRE_STAKED_FLR_ORACLE_ADDRESS,
            SCEPTRE_STAKED_FLR_ORACLE_HASH,
            SCEPTRE_STAKED_FLR_ORACLE_RUNTIME,
            "src/concrete/oracle/SceptreStakedFlrOracle.sol:SceptreStakedFlrOracle",
            abi.decode(SCEPTRE_STAKED_FLR_ORACLE_DEPENDENCIES, (address[])),
            SCEPTRE_STAKED_FLR_ORACLE_CREATION
        );
    }

    function ftsoV2LTSFeedOracleFlrUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-feed-oracle-flr-usd",
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_CREATION,
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_ADDRESS,
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_HASH,
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME,
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            abi.decode(FTSO_V2_LTS_FEED_ORACLE_FLR_USD_DEPENDENCIES, (address[])),
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_CREATION
        );
    }

    function ftsoV2LTSFeedOracleEthUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-feed-oracle-eth-usd",
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_CREATION,
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_ADDRESS,
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_HASH,
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME,
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            abi.decode(FTSO_V2_LTS_FEED_ORACLE_ETH_USD_DEPENDENCIES, (address[])),
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_CREATION
        );
    }

    function ftsoV2LTSFeedOracleXrpUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-feed-oracle-xrp-usd",
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_CREATION,
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_ADDRESS,
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_HASH,
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME,
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            abi.decode(FTSO_V2_LTS_FEED_ORACLE_XRP_USD_DEPENDENCIES, (address[])),
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_CREATION
        );
    }

    function ftsoV2LTSFeedOracleJouleUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-feed-oracle-joule-usd",
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_CREATION,
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_ADDRESS,
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_HASH,
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME,
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            abi.decode(FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPENDENCIES, (address[])),
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_CREATION
        );
    }

    function pythOracleWethUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-weth-usd",
            PYTH_ORACLE_WETH_USD_CREATION,
            PYTH_ORACLE_WETH_USD_ADDRESS,
            PYTH_ORACLE_WETH_USD_HASH,
            PYTH_ORACLE_WETH_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_WETH_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_WETH_USD_CREATION
        );
    }

    function pythOracleWstethUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-wsteth-usd",
            PYTH_ORACLE_WSTETH_USD_CREATION,
            PYTH_ORACLE_WSTETH_USD_ADDRESS,
            PYTH_ORACLE_WSTETH_USD_HASH,
            PYTH_ORACLE_WSTETH_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_WSTETH_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_WSTETH_USD_CREATION
        );
    }

    function pythOracleWbtcUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-wbtc-usd",
            PYTH_ORACLE_WBTC_USD_CREATION,
            PYTH_ORACLE_WBTC_USD_ADDRESS,
            PYTH_ORACLE_WBTC_USD_HASH,
            PYTH_ORACLE_WBTC_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_WBTC_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_WBTC_USD_CREATION
        );
    }

    function pythOracleCbbtcUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-cbbtc-usd",
            PYTH_ORACLE_CBBTC_USD_CREATION,
            PYTH_ORACLE_CBBTC_USD_ADDRESS,
            PYTH_ORACLE_CBBTC_USD_HASH,
            PYTH_ORACLE_CBBTC_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_CBBTC_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_CBBTC_USD_CREATION
        );
    }

    function pythOracleLinkUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-link-usd",
            PYTH_ORACLE_LINK_USD_CREATION,
            PYTH_ORACLE_LINK_USD_ADDRESS,
            PYTH_ORACLE_LINK_USD_HASH,
            PYTH_ORACLE_LINK_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_LINK_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_LINK_USD_CREATION
        );
    }

    function pythOracleDotUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-dot-usd",
            PYTH_ORACLE_DOT_USD_CREATION,
            PYTH_ORACLE_DOT_USD_ADDRESS,
            PYTH_ORACLE_DOT_USD_HASH,
            PYTH_ORACLE_DOT_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_DOT_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_DOT_USD_CREATION
        );
    }

    function pythOracleUniUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-uni-usd",
            PYTH_ORACLE_UNI_USD_CREATION,
            PYTH_ORACLE_UNI_USD_ADDRESS,
            PYTH_ORACLE_UNI_USD_HASH,
            PYTH_ORACLE_UNI_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_UNI_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_UNI_USD_CREATION
        );
    }

    function pythOraclePepeUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-pepe-usd",
            PYTH_ORACLE_PEPE_USD_CREATION,
            PYTH_ORACLE_PEPE_USD_ADDRESS,
            PYTH_ORACLE_PEPE_USD_HASH,
            PYTH_ORACLE_PEPE_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_PEPE_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_PEPE_USD_CREATION
        );
    }

    function pythOraclePythUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-pyth-usd",
            PYTH_ORACLE_PYTH_USD_CREATION,
            PYTH_ORACLE_PYTH_USD_ADDRESS,
            PYTH_ORACLE_PYTH_USD_HASH,
            PYTH_ORACLE_PYTH_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_PYTH_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_PYTH_USD_CREATION
        );
    }

    function pythOracleEnaUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-ena-usd",
            PYTH_ORACLE_ENA_USD_CREATION,
            PYTH_ORACLE_ENA_USD_ADDRESS,
            PYTH_ORACLE_ENA_USD_HASH,
            PYTH_ORACLE_ENA_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_ENA_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_ENA_USD_CREATION
        );
    }

    function pythOracleArbUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-arb-usd",
            PYTH_ORACLE_ARB_USD_CREATION,
            PYTH_ORACLE_ARB_USD_ADDRESS,
            PYTH_ORACLE_ARB_USD_HASH,
            PYTH_ORACLE_ARB_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_ARB_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_ARB_USD_CREATION
        );
    }

    function pythOracleXautUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-xaut-usd",
            PYTH_ORACLE_XAUT_USD_CREATION,
            PYTH_ORACLE_XAUT_USD_ADDRESS,
            PYTH_ORACLE_XAUT_USD_HASH,
            PYTH_ORACLE_XAUT_USD_RUNTIME,
            "src/concrete/oracle/PythOracle.sol:PythOracle",
            abi.decode(PYTH_ORACLE_XAUT_USD_DEPENDENCIES, (address[])),
            PYTH_ORACLE_XAUT_USD_CREATION
        );
    }

    function twoPriceOracleV2FlrUsdSflrCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "two-price-oracle-flr-usd-sflr",
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_CREATION,
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_ADDRESS,
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_HASH,
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_RUNTIME,
            "src/concrete/oracle/TwoPriceOracleV2.sol:TwoPriceOracleV2",
            abi.decode(TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_DEPENDENCIES, (address[])),
            TWO_PRICE_ORACLE_V2_FLR_USD_SFLR_CREATION
        );
    }
}
