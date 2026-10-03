// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Vm} from "forge-std-1.16.2/src/Vm.sol";
import {LibRainDeploySnapshot} from "rain-deploy-0.1.11/src/lib/LibRainDeploySnapshot.sol";
import {
    LibCodeGen,
    RAIN_COPYRIGHT_TEXT,
    RAIN_SPDX_LICENSE_IDENTIFIER
} from "rain-sol-codegen-0.1.37/src/lib/LibCodeGen.sol";
import {DeploySuite} from "../src/abstract/RainDeploySuitesBase.sol";

/// @title LibReleasedSuitesLibParis
/// @notice `LibRainDeploySnapshot.writeReleasedSuitesLib` with its library
/// block built in smaller pieces. The upstream block is one `string.concat`
/// of nineteen parts, which the legacy codegen cannot hold on the stack
/// under `evm_version = "paris"`, and paris is what reproduces the bytecode
/// this repo has on chain. Same text, byte for byte. Delete once the repo
/// leaves paris: https://github.com/cyclofinance/cyclo.sol/issues/58
library LibReleasedSuitesLibParis {
    function entry(Vm vm, uint256 index, string memory path, DeploySuite memory template)
        internal
        pure
        returns (string memory)
    {
        string memory prefix = LibRainDeploySnapshot.releasedConstantPrefix(vm, path);
        string memory head = string.concat(
            "        suites[",
            vm.toString(index),
            "] = DeploySuite({\n            suite: \"",
            template.suite,
            "@",
            LibRainDeploySnapshot.tagForRecordPath(vm, path),
            "\",\n            creationCode: ",
            prefix,
            "_CREATION_CODE,\n            storedDeployedAddress: ",
            prefix
        );
        return string.concat(
            head,
            "_DEPLOYED_ADDRESS,\n            storedBytecodeHash: ",
            prefix,
            "_BYTECODE_HASH,\n            storedRuntimeCode: ",
            prefix,
            "_RUNTIME_CODE,\n            artifactPath: \"",
            template.artifactPath,
            "\",\n            dependencies: abi.decode(",
            prefix,
            "_DEPENDENCIES, (address[]))\n        });\n"
        );
    }

    function libraryBlock(
        Vm vm,
        string memory libraryName,
        string memory contractName,
        string[] memory paths,
        DeploySuite memory template
    ) internal pure returns (string memory) {
        string memory entries = "";
        for (uint256 i = 0; i < paths.length; i++) {
            entries = string.concat(entries, entry(vm, i, paths[i], template));
        }

        string memory doc = string.concat(
            "/// @title ",
            libraryName,
            "\n/// @notice Every frozen release of `",
            contractName,
            "`: one entry per file in\n" "/// the append-only `src/generated/<tag>/` record, in tag order.\n///\n"
            "/// The deploy address, code hash, creation code, runtime code and dependency\n"
            "/// list of each entry are aliased from that release's own frozen snapshot, so\n"
            "/// what a release deployed, and what it required to already be on chain, are\n"
            "/// read from the immutable file and from nowhere else. A dependency dropped\n"
            "/// from current source stays required by the releases cut with it, and one\n"
            "/// added is not imposed on releases cut without it.\n///\n"
            "/// The key and the artifact path are explorer and ordering metadata\n"
            "/// regenerated from the CURRENT declaration, and are not part of that\n"
            "/// record. A moved source path retroactively updates every entry's artifact\n"
            "/// path, which is intended: the alternative is parsing this generated file\n"
            "/// back in to preserve what it last said.\nlibrary ",
            libraryName
        );
        return string.concat(
            doc,
            " {\n    /// Every frozen release, in tag order.\n" "    /// @return The released suites.\n"
            "    function releasedSuites() internal pure returns (DeploySuite[] memory) {\n"
            "        DeploySuite[] memory suites = new DeploySuite[](",
            vm.toString(paths.length),
            ");\n",
            entries,
            "        return suites;\n    }\n}\n"
        );
    }

    function writeReleasedSuitesLib(
        Vm vm,
        string memory libDir,
        string memory recordRoot,
        string memory contractName,
        DeploySuite memory template
    ) internal returns (string memory) {
        string memory libraryName = LibRainDeploySnapshot.releasedLibraryName(contractName);
        string memory path = LibRainDeploySnapshot.pathForLib(libDir, libraryName);
        string memory body;
        {
            string[] memory paths = LibRainDeploySnapshot.recordPathsForContract(vm, recordRoot, contractName);
            body = string.concat(
                LibRainDeploySnapshot.releasedImportBlock(vm, paths),
                libraryBlock(vm, libraryName, contractName, paths, template)
            );
        }
        //forge-lint: disable-next-line(unsafe-cheatcode)
        vm.writeFile(
            path, string.concat(LibCodeGen.filePrefix(RAIN_SPDX_LICENSE_IDENTIFIER, RAIN_COPYRIGHT_TEXT), "\n", body)
        );
        return path;
    }
}
