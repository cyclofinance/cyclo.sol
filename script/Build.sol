// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {BuildScript} from "rain-deploy-0.1.11/src/abstract/BuildScript.sol";
import {LibRainDeploySnapshot} from "rain-deploy-0.1.11/src/lib/LibRainDeploySnapshot.sol";
import {DeploySuite} from "../src/abstract/RainDeploySuitesBase.sol";
import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE
} from "../src/lib/LibCycloProdOracle.sol";

/// One recorded production contract.
struct Recorded {
    /// Names its snapshot under `src/generated/` and its generated libs.
    string contractName;
    /// Prefix for the constants its alias lib exports.
    string constantPrefix;
    /// Its suite key in `CycloDeploySuites`.
    string suite;
    /// Where its source lived when it was compiled, for explorers.
    string artifactPath;
}

/// @title Build
/// @notice Regenerates the snapshots and libs of every production contract.
/// The production contracts predate the registry and their sources are not in
/// this repo, so each snapshot is regenerated from the creation code and
/// dependencies it already records; `cutRelease()` freezes them into
/// `src/generated/<tag>/`. The bytes are read from the snapshot files rather
/// than compiled in: all of them together exceed the initcode limit of the
/// script contract itself.
contract Build is BuildScript {
    function recorded() internal pure returns (Recorded[] memory r) {
        r = new Recorded[](21);
        r[0] = Recorded(
            "CycloReceipt", "CYCLO_RECEIPT", "cyclo-receipt", "src/concrete/receipt/CycloReceipt.sol:CycloReceipt"
        );
        r[1] = Recorded(
            "CycloVaultFlare", "CYCLO_VAULT_FLARE", "cyclo-vault-flare", "src/concrete/vault/CycloVault.sol:CycloVault"
        );
        r[2] = Recorded(
            "CycloVaultArbitrum",
            "CYCLO_VAULT_ARBITRUM",
            "cyclo-vault-arbitrum",
            "src/concrete/vault/CycloVault.sol:CycloVault"
        );
        r[3] = Recorded(
            "SceptreStakedFlrOracle",
            "SCEPTRE_STAKED_FLR_ORACLE",
            "sceptre-staked-flr-oracle",
            "src/concrete/oracle/SceptreStakedFlrOracle.sol:SceptreStakedFlrOracle"
        );
        r[4] = Recorded(
            "FtsoV2LTSFeedOracleFlrUsd",
            "FTSO_V2_LTS_FEED_ORACLE_FLR_USD",
            "ftso-feed-oracle-flr-usd",
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle"
        );
        r[5] = Recorded(
            "FtsoV2LTSFeedOracleEthUsd",
            "FTSO_V2_LTS_FEED_ORACLE_ETH_USD",
            "ftso-feed-oracle-eth-usd",
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle"
        );
        r[6] = Recorded(
            "FtsoV2LTSFeedOracleXrpUsd",
            "FTSO_V2_LTS_FEED_ORACLE_XRP_USD",
            "ftso-feed-oracle-xrp-usd",
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle"
        );
        r[7] = Recorded(
            "FtsoV2LTSFeedOracleJouleUsd",
            "FTSO_V2_LTS_FEED_ORACLE_JOULE_USD",
            "ftso-feed-oracle-joule-usd",
            "src/concrete/oracle/FtsoV2LTSFeedOracle.sol:FtsoV2LTSFeedOracle"
        );
        r[8] = Recorded(
            "PythOracleWethUsd",
            "PYTH_ORACLE_WETH_USD",
            "pyth-oracle-weth-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[9] = Recorded(
            "PythOracleWstethUsd",
            "PYTH_ORACLE_WSTETH_USD",
            "pyth-oracle-wsteth-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[10] = Recorded(
            "PythOracleWbtcUsd",
            "PYTH_ORACLE_WBTC_USD",
            "pyth-oracle-wbtc-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[11] = Recorded(
            "PythOracleCbbtcUsd",
            "PYTH_ORACLE_CBBTC_USD",
            "pyth-oracle-cbbtc-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[12] = Recorded(
            "PythOracleLinkUsd",
            "PYTH_ORACLE_LINK_USD",
            "pyth-oracle-link-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[13] = Recorded(
            "PythOracleDotUsd",
            "PYTH_ORACLE_DOT_USD",
            "pyth-oracle-dot-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[14] = Recorded(
            "PythOracleUniUsd",
            "PYTH_ORACLE_UNI_USD",
            "pyth-oracle-uni-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[15] = Recorded(
            "PythOraclePepeUsd",
            "PYTH_ORACLE_PEPE_USD",
            "pyth-oracle-pepe-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[16] = Recorded(
            "PythOraclePythUsd",
            "PYTH_ORACLE_PYTH_USD",
            "pyth-oracle-pyth-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[17] = Recorded(
            "PythOracleEnaUsd",
            "PYTH_ORACLE_ENA_USD",
            "pyth-oracle-ena-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[18] = Recorded(
            "PythOracleArbUsd",
            "PYTH_ORACLE_ARB_USD",
            "pyth-oracle-arb-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[19] = Recorded(
            "PythOracleXautUsd",
            "PYTH_ORACLE_XAUT_USD",
            "pyth-oracle-xaut-usd",
            "src/concrete/oracle/PythOracle.sol:PythOracle"
        );
        r[20] = Recorded(
            "TwoPriceOracleV2FlrUsdSflr",
            "TWO_PRICE_ORACLE_V2_FLR_USD_SFLR",
            "two-price-oracle-flr-usd-sflr",
            "src/concrete/oracle/TwoPriceOracleV2.sol:TwoPriceOracleV2"
        );
    }

    /// @inheritdoc BuildScript
    function snapshotContractNames() internal pure override returns (string[] memory names) {
        Recorded[] memory r = recorded();
        names = new string[](r.length);
        for (uint256 i = 0; i < r.length; i++) {
            names[i] = r[i].contractName;
        }
    }

    /// One `bytes` constant out of a snapshot file, as the snapshot writer
    /// spells it.
    function readBytesConstant(string memory snapshot, string memory name) internal pure returns (bytes memory) {
        string memory afterName = vm.split(snapshot, string.concat("bytes constant ", name, " =\n    hex\""))[1];
        return vm.parseBytes(string.concat("0x", vm.split(afterName, "\"")[0]));
    }

    /// @inheritdoc BuildScript
    function regenerateSnapshots() internal override {
        // `TwoPriceOracleV2` prices itself against its two oracles in its
        // constructor. Neither has code offline; the price only feeds a dry run
        // and reaches no immutable, so any nonzero price leaves the bytes
        // unchanged.
        vm.mockCall(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE, abi.encodeWithSignature("price()"), abi.encode(1e18));
        vm.mockCall(PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE, abi.encodeWithSignature("price()"), abi.encode(1e18));

        Recorded[] memory r = recorded();
        for (uint256 i = 0; i < r.length; i++) {
            string memory snapshot = vm.readFile(
                LibRainDeploySnapshot.pathForSnapshot(recordRoot(), LibRainDeploySnapshot.CANDIDATE, r[i].contractName)
            );
            LibRainDeploySnapshot.writeSnapshot(
                vm,
                recordRoot(),
                LibRainDeploySnapshot.CANDIDATE,
                r[i].contractName,
                readBytesConstant(snapshot, "CREATION_CODE"),
                abi.decode(readBytesConstant(snapshot, "DEPENDENCIES"), (address[]))
            );
        }
    }

    function template(Recorded memory r) internal pure returns (DeploySuite memory suite) {
        suite.suite = r.suite;
        suite.artifactPath = r.artifactPath;
    }

    /// @inheritdoc BuildScript
    function regenerateLibs() internal override {
        Recorded[] memory r = recorded();
        for (uint256 i = 0; i < r.length; i++) {
            LibRainDeploySnapshot.writeAliasLib(
                vm,
                LibRainDeploySnapshot.LIB_DIR,
                r[i].contractName,
                r[i].constantPrefix,
                LibRainDeploySnapshot.CANDIDATE
            );
            LibRainDeploySnapshot.writeReleasedSuitesLib(
                vm, LibRainDeploySnapshot.LIB_DIR, recordRoot(), r[i].contractName, template(r[i])
            );
        }
        LibRainDeploySnapshot.writeReleasedSuitesAggregate(vm, LibRainDeploySnapshot.LIB_DIR, snapshotContractNames());
    }
}
