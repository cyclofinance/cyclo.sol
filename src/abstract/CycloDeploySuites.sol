// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {DeployCandidate, DeploySuite, RainDeploySuitesBase} from "./RainDeploySuitesBase.sol";
import {LibReleasedSuites} from "../lib/LibReleasedSuites.sol";
import {CloneFactory} from "rain.factory/concrete/CloneFactory.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {IReceiptV3} from "ethgild/interface/IReceiptV3.sol";
import {ReceiptVaultConstructionConfigV2} from "ethgild/abstract/ReceiptVault.sol";
import {CycloReceipt} from "../concrete/receipt/CycloReceipt.sol";
import {CycloVault} from "../concrete/vault/CycloVault.sol";
import {SceptreStakedFlrOracle} from "ethgild/concrete/oracle/SceptreStakedFlrOracle.sol";
import {FtsoV2LTSFeedOracle, FtsoV2LTSFeedOracleConfig} from "ethgild/concrete/oracle/FtsoV2LTSFeedOracle.sol";
import {PythOracle, PythOracleConfig} from "ethgild/concrete/oracle/PythOracle.sol";
import {
    FLR_USD_FEED_ID,
    ETH_USD_FEED_ID,
    XRP_USD_FEED_ID,
    JOULE_USD_FEED_ID
} from "rain.flare/lib/lts/LibFtsoV2LTS.sol";
import {LibPyth} from "rain.pyth/lib/pyth/LibPyth.sol";
import {PROD_ORACLE_DEFAULT_STALE_AFTER} from "../lib/LibCycloProdOracle.sol";
import {LibCloneFactoryDeploy} from "../lib/LibCloneFactoryDeploy.sol";
import {LibCycloReceiptDeploy} from "../lib/LibCycloReceiptDeploy.sol";
import {
    CREATION_CODE as CLONE_FACTORY_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as CLONE_FACTORY_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/CloneFactory.sol";
import {
    CREATION_CODE as CYCLO_RECEIPT_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as CYCLO_RECEIPT_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/CycloReceipt.sol";
import {
    CREATION_CODE as CYCLO_VAULT_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as CYCLO_VAULT_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/CycloVault.sol";
import {LibCycloVaultDeploy} from "../lib/LibCycloVaultDeploy.sol";
import {
    CREATION_CODE as SCEPTRE_STAKED_FLR_ORACLE_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as SCEPTRE_STAKED_FLR_ORACLE_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/SceptreStakedFlrOracle.sol";
import {LibSceptreStakedFlrOracleDeploy} from "../lib/LibSceptreStakedFlrOracleDeploy.sol";
import {
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/FtsoV2LTSFeedOracleFlrUsd.sol";
import {LibFtsoV2LTSFeedOracleFlrUsdDeploy} from "../lib/LibFtsoV2LTSFeedOracleFlrUsdDeploy.sol";
import {
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/FtsoV2LTSFeedOracleEthUsd.sol";
import {LibFtsoV2LTSFeedOracleEthUsdDeploy} from "../lib/LibFtsoV2LTSFeedOracleEthUsdDeploy.sol";
import {
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/FtsoV2LTSFeedOracleXrpUsd.sol";
import {LibFtsoV2LTSFeedOracleXrpUsdDeploy} from "../lib/LibFtsoV2LTSFeedOracleXrpUsdDeploy.sol";
import {
    CREATION_CODE as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/FtsoV2LTSFeedOracleJouleUsd.sol";
import {LibFtsoV2LTSFeedOracleJouleUsdDeploy} from "../lib/LibFtsoV2LTSFeedOracleJouleUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_WETH_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_WETH_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleWethUsd.sol";
import {LibPythOracleWethUsdDeploy} from "../lib/LibPythOracleWethUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_WSTETH_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_WSTETH_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleWstethUsd.sol";
import {LibPythOracleWstethUsdDeploy} from "../lib/LibPythOracleWstethUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_WBTC_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_WBTC_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleWbtcUsd.sol";
import {LibPythOracleWbtcUsdDeploy} from "../lib/LibPythOracleWbtcUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_CBBTC_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_CBBTC_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleCbbtcUsd.sol";
import {LibPythOracleCbbtcUsdDeploy} from "../lib/LibPythOracleCbbtcUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_LINK_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_LINK_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleLinkUsd.sol";
import {LibPythOracleLinkUsdDeploy} from "../lib/LibPythOracleLinkUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_DOT_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_DOT_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleDotUsd.sol";
import {LibPythOracleDotUsdDeploy} from "../lib/LibPythOracleDotUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_UNI_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_UNI_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleUniUsd.sol";
import {LibPythOracleUniUsdDeploy} from "../lib/LibPythOracleUniUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_PEPE_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_PEPE_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOraclePepeUsd.sol";
import {LibPythOraclePepeUsdDeploy} from "../lib/LibPythOraclePepeUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_PYTH_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_PYTH_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOraclePythUsd.sol";
import {LibPythOraclePythUsdDeploy} from "../lib/LibPythOraclePythUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_ENA_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_ENA_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleEnaUsd.sol";
import {LibPythOracleEnaUsdDeploy} from "../lib/LibPythOracleEnaUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_ARB_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_ARB_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleArbUsd.sol";
import {LibPythOracleArbUsdDeploy} from "../lib/LibPythOracleArbUsdDeploy.sol";
import {
    CREATION_CODE as PYTH_ORACLE_XAUT_USD_CREATION_CODE_CANDIDATE,
    RUNTIME_CODE as PYTH_ORACLE_XAUT_USD_RUNTIME_CODE_CANDIDATE
} from "../generated/candidate/PythOracleXautUsd.sol";
import {LibPythOracleXautUsdDeploy} from "../lib/LibPythOracleXautUsdDeploy.sol";

/// @title CycloDeploySuites
/// @notice Everything this repo deploys deterministically, declared ONCE: the
/// rolling candidates below, and the released side read from the generated
/// `LibReleasedSuites`, which `script/Build.sol` emits from the frozen record.
///
/// Every candidate's creation code is chain-independent. `TwoPriceOracleV2`
/// is not a suite: its constructor dry-runs the price against Flare's FTSO,
/// so it only constructs on Flare, and vault clones are operations on a
/// deployed implementation, not deployments. Both stay in
/// `script/CreateVault.sol`.
abstract contract CycloDeploySuites is RainDeploySuitesBase {
    /// @inheritdoc RainDeploySuitesBase
    function releasedSuites() internal pure override returns (DeploySuite[] memory) {
        return LibReleasedSuites.releasedSuites();
    }

    /// @inheritdoc RainDeploySuitesBase
    function candidateSuites() internal pure override returns (DeployCandidate[] memory) {
        DeployCandidate[] memory candidates = new DeployCandidate[](20);
        candidates[0] = cloneFactoryCandidate();
        candidates[1] = cycloReceiptCandidate();
        candidates[2] = cycloVaultCandidate();
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

    /// The `ICloneableFactoryV2` the vault implementation clones receipts
    /// through, from the pinned `rain.factory` source. The org's deterministic
    /// `CloneFactory` is `ICloneableFactoryV4` and has no `clone(address,bytes)`.
    function cloneFactoryCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "clone-factory",
            CLONE_FACTORY_CREATION_CODE_CANDIDATE,
            LibCloneFactoryDeploy.CLONE_FACTORY_DEPLOYED_ADDRESS,
            LibCloneFactoryDeploy.CLONE_FACTORY_DEPLOYED_CODEHASH,
            CLONE_FACTORY_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/lib/rain.factory/src/concrete/CloneFactory.sol:CloneFactory",
            new address[](0),
            type(CloneFactory).creationCode
        );
    }

    function cycloReceiptCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "cyclo-receipt",
            CYCLO_RECEIPT_CREATION_CODE_CANDIDATE,
            LibCycloReceiptDeploy.CYCLO_RECEIPT_DEPLOYED_ADDRESS,
            LibCycloReceiptDeploy.CYCLO_RECEIPT_DEPLOYED_CODEHASH,
            CYCLO_RECEIPT_RUNTIME_CODE_CANDIDATE,
            "src/concrete/receipt/CycloReceipt.sol:CycloReceipt",
            new address[](0),
            type(CycloReceipt).creationCode
        );
    }

    /// The vault implementation, constructed against the deterministic clone
    /// factory and receipt implementation above, so the creation code is the
    /// same on every network. Both must already be on chain.
    function cycloVaultCandidate() internal pure returns (DeployCandidate memory) {
        address[] memory dependencies = new address[](2);
        dependencies[0] = LibCloneFactoryDeploy.CLONE_FACTORY_DEPLOYED_ADDRESS;
        dependencies[1] = LibCycloReceiptDeploy.CYCLO_RECEIPT_DEPLOYED_ADDRESS;
        return candidate(
            "cyclo-vault",
            CYCLO_VAULT_CREATION_CODE_CANDIDATE,
            LibCycloVaultDeploy.CYCLO_VAULT_DEPLOYED_ADDRESS,
            LibCycloVaultDeploy.CYCLO_VAULT_DEPLOYED_CODEHASH,
            CYCLO_VAULT_RUNTIME_CODE_CANDIDATE,
            "src/concrete/vault/CycloVault.sol:CycloVault",
            dependencies,
            abi.encodePacked(
                type(CycloVault).creationCode,
                abi.encode(
                    ReceiptVaultConstructionConfigV2({
                        factory: ICloneableFactoryV2(LibCloneFactoryDeploy.CLONE_FACTORY_DEPLOYED_ADDRESS),
                        receiptImplementation: IReceiptV3(LibCycloReceiptDeploy.CYCLO_RECEIPT_DEPLOYED_ADDRESS)
                    })
                )
            )
        );
    }

    function sceptreStakedFlrOracleCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "sceptre-staked-flr-oracle",
            SCEPTRE_STAKED_FLR_ORACLE_CREATION_CODE_CANDIDATE,
            LibSceptreStakedFlrOracleDeploy.SCEPTRE_STAKED_FLR_ORACLE_DEPLOYED_ADDRESS,
            LibSceptreStakedFlrOracleDeploy.SCEPTRE_STAKED_FLR_ORACLE_DEPLOYED_CODEHASH,
            SCEPTRE_STAKED_FLR_ORACLE_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/SceptreStakedFlrOracle.sol:SceptreStakedFlrOracle",
            new address[](0),
            type(SceptreStakedFlrOracle).creationCode
        );
    }

    function ftsoV2LTSFeedOracleCreationCode(bytes21 feedId) internal pure returns (bytes memory) {
        return abi.encodePacked(
            type(FtsoV2LTSFeedOracle).creationCode,
            abi.encode(FtsoV2LTSFeedOracleConfig({feedId: feedId, staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER}))
        );
    }

    function pythOracleCreationCode(bytes32 priceFeedId) internal pure returns (bytes memory) {
        return abi.encodePacked(
            type(PythOracle).creationCode,
            abi.encode(
                PythOracleConfig({
                    priceFeedId: priceFeedId,
                    staleAfter: PROD_ORACLE_DEFAULT_STALE_AFTER,
                    pythContract: LibPyth.PRICE_FEED_CONTRACT_ARBITRUM
                })
            )
        );
    }

    function ftsoV2LTSFeedOracleFlrUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-lts-feed-oracle-flr-usd",
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_CREATION_CODE_CANDIDATE,
            LibFtsoV2LTSFeedOracleFlrUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_FLR_USD_DEPLOYED_ADDRESS,
            LibFtsoV2LTSFeedOracleFlrUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_FLR_USD_DEPLOYED_CODEHASH,
            FTSO_V2_LTS_FEED_ORACLE_FLR_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            new address[](0),
            ftsoV2LTSFeedOracleCreationCode(FLR_USD_FEED_ID)
        );
    }

    function ftsoV2LTSFeedOracleEthUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-lts-feed-oracle-eth-usd",
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_CREATION_CODE_CANDIDATE,
            LibFtsoV2LTSFeedOracleEthUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_ETH_USD_DEPLOYED_ADDRESS,
            LibFtsoV2LTSFeedOracleEthUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_ETH_USD_DEPLOYED_CODEHASH,
            FTSO_V2_LTS_FEED_ORACLE_ETH_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            new address[](0),
            ftsoV2LTSFeedOracleCreationCode(ETH_USD_FEED_ID)
        );
    }

    function ftsoV2LTSFeedOracleXrpUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-lts-feed-oracle-xrp-usd",
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_CREATION_CODE_CANDIDATE,
            LibFtsoV2LTSFeedOracleXrpUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_XRP_USD_DEPLOYED_ADDRESS,
            LibFtsoV2LTSFeedOracleXrpUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_XRP_USD_DEPLOYED_CODEHASH,
            FTSO_V2_LTS_FEED_ORACLE_XRP_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            new address[](0),
            ftsoV2LTSFeedOracleCreationCode(XRP_USD_FEED_ID)
        );
    }

    function ftsoV2LTSFeedOracleJouleUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "ftso-lts-feed-oracle-joule-usd",
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_CREATION_CODE_CANDIDATE,
            LibFtsoV2LTSFeedOracleJouleUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPLOYED_ADDRESS,
            LibFtsoV2LTSFeedOracleJouleUsdDeploy.FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_DEPLOYED_CODEHASH,
            FTSO_V2_LTS_FEED_ORACLE_JOULE_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle",
            new address[](0),
            ftsoV2LTSFeedOracleCreationCode(JOULE_USD_FEED_ID)
        );
    }

    function pythOracleWethUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-weth-usd",
            PYTH_ORACLE_WETH_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleWethUsdDeploy.PYTH_ORACLE_WETH_USD_DEPLOYED_ADDRESS,
            LibPythOracleWethUsdDeploy.PYTH_ORACLE_WETH_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_WETH_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_WETH_USD)
        );
    }

    function pythOracleWstethUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-wsteth-usd",
            PYTH_ORACLE_WSTETH_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleWstethUsdDeploy.PYTH_ORACLE_WSTETH_USD_DEPLOYED_ADDRESS,
            LibPythOracleWstethUsdDeploy.PYTH_ORACLE_WSTETH_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_WSTETH_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_WSTETH_USD)
        );
    }

    function pythOracleWbtcUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-wbtc-usd",
            PYTH_ORACLE_WBTC_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleWbtcUsdDeploy.PYTH_ORACLE_WBTC_USD_DEPLOYED_ADDRESS,
            LibPythOracleWbtcUsdDeploy.PYTH_ORACLE_WBTC_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_WBTC_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_WBTC_USD)
        );
    }

    function pythOracleCbbtcUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-cbbtc-usd",
            PYTH_ORACLE_CBBTC_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleCbbtcUsdDeploy.PYTH_ORACLE_CBBTC_USD_DEPLOYED_ADDRESS,
            LibPythOracleCbbtcUsdDeploy.PYTH_ORACLE_CBBTC_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_CBBTC_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_CBBTC_USD)
        );
    }

    function pythOracleLinkUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-link-usd",
            PYTH_ORACLE_LINK_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleLinkUsdDeploy.PYTH_ORACLE_LINK_USD_DEPLOYED_ADDRESS,
            LibPythOracleLinkUsdDeploy.PYTH_ORACLE_LINK_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_LINK_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_LINK_USD)
        );
    }

    function pythOracleDotUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-dot-usd",
            PYTH_ORACLE_DOT_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleDotUsdDeploy.PYTH_ORACLE_DOT_USD_DEPLOYED_ADDRESS,
            LibPythOracleDotUsdDeploy.PYTH_ORACLE_DOT_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_DOT_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_DOT_USD)
        );
    }

    function pythOracleUniUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-uni-usd",
            PYTH_ORACLE_UNI_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleUniUsdDeploy.PYTH_ORACLE_UNI_USD_DEPLOYED_ADDRESS,
            LibPythOracleUniUsdDeploy.PYTH_ORACLE_UNI_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_UNI_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_UNI_USD)
        );
    }

    function pythOraclePepeUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-pepe-usd",
            PYTH_ORACLE_PEPE_USD_CREATION_CODE_CANDIDATE,
            LibPythOraclePepeUsdDeploy.PYTH_ORACLE_PEPE_USD_DEPLOYED_ADDRESS,
            LibPythOraclePepeUsdDeploy.PYTH_ORACLE_PEPE_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_PEPE_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_PEPE_USD)
        );
    }

    function pythOraclePythUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-pyth-usd",
            PYTH_ORACLE_PYTH_USD_CREATION_CODE_CANDIDATE,
            LibPythOraclePythUsdDeploy.PYTH_ORACLE_PYTH_USD_DEPLOYED_ADDRESS,
            LibPythOraclePythUsdDeploy.PYTH_ORACLE_PYTH_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_PYTH_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_PYTH_USD)
        );
    }

    function pythOracleEnaUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-ena-usd",
            PYTH_ORACLE_ENA_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleEnaUsdDeploy.PYTH_ORACLE_ENA_USD_DEPLOYED_ADDRESS,
            LibPythOracleEnaUsdDeploy.PYTH_ORACLE_ENA_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_ENA_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_ENA_USD)
        );
    }

    function pythOracleArbUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-arb-usd",
            PYTH_ORACLE_ARB_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleArbUsdDeploy.PYTH_ORACLE_ARB_USD_DEPLOYED_ADDRESS,
            LibPythOracleArbUsdDeploy.PYTH_ORACLE_ARB_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_ARB_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_ARB_USD)
        );
    }

    function pythOracleXautUsdCandidate() internal pure returns (DeployCandidate memory) {
        return candidate(
            "pyth-oracle-xaut-usd",
            PYTH_ORACLE_XAUT_USD_CREATION_CODE_CANDIDATE,
            LibPythOracleXautUsdDeploy.PYTH_ORACLE_XAUT_USD_DEPLOYED_ADDRESS,
            LibPythOracleXautUsdDeploy.PYTH_ORACLE_XAUT_USD_DEPLOYED_CODEHASH,
            PYTH_ORACLE_XAUT_USD_RUNTIME_CODE_CANDIDATE,
            "lib/ethgild/src/concrete/oracle/PythOracle.sol:PythOracle",
            new address[](0),
            pythOracleCreationCode(LibPyth.PRICE_FEED_ID_CRYPTO_XAUT_USD)
        );
    }
}
