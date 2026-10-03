// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {LibRainDeploySnapshot} from "rain-deploy-0.1.11/src/lib/LibRainDeploySnapshot.sol";
import {DeploySuite} from "../../src/abstract/RainDeploySuitesBase.sol";
import {LibReleasedSuitesLibParis} from "../../script/LibReleasedSuitesLibParis.sol";

/// The expected text is rain-deploy 0.1.11's own
/// `testReleasedLibraryBlockDeclaresEveryRecord` fixture, verbatim, so the
/// paris respelling is held to the upstream writer's output.
contract LibReleasedSuitesLibParisTest is Test {
    string constant EMITTED_CONTRACT = "AddressRegistry";
    string constant EMITTED_LIBRARY = "LibAddressRegistryReleased";

    string constant EXPECTED_LIBRARY_HEADER = "/// @title LibAddressRegistryReleased\n"
        "/// @notice Every frozen release of `AddressRegistry`: one entry per file in\n"
        "/// the append-only `src/generated/<tag>/` record, in tag order.\n" "///\n"
        "/// The deploy address, code hash, creation code, runtime code and dependency\n"
        "/// list of each entry are aliased from that release's own frozen snapshot, so\n"
        "/// what a release deployed, and what it required to already be on chain, are\n"
        "/// read from the immutable file and from nowhere else. A dependency dropped\n"
        "/// from current source stays required by the releases cut with it, and one\n"
        "/// added is not imposed on releases cut without it.\n" "///\n"
        "/// The key and the artifact path are explorer and ordering metadata\n"
        "/// regenerated from the CURRENT declaration, and are not part of that\n"
        "/// record. A moved source path retroactively updates every entry's artifact\n"
        "/// path, which is intended: the alternative is parsing this generated file\n"
        "/// back in to preserve what it last said.\n" "library LibAddressRegistryReleased {\n"
        "    /// Every frozen release, in tag order.\n" "    /// @return The released suites.\n"
        "    function releasedSuites() internal pure returns (DeploySuite[] memory) {\n";

    string constant EXPECTED_FOOTER = "        return suites;\n    }\n}\n";

    function emitterTemplate() internal pure returns (DeploySuite memory) {
        return DeploySuite({
            suite: "address-registry",
            creationCode: "",
            storedDeployedAddress: address(0),
            storedBytecodeHash: bytes32(0),
            storedRuntimeCode: "",
            artifactPath: "src/concrete/AddressRegistry.sol:AddressRegistry",
            dependencies: new address[](0)
        });
    }

    function recordOf(uint256 count) internal pure returns (string[] memory paths) {
        paths = new string[](count);
        for (uint256 i = 0; i < count; i++) {
            paths[i] = string.concat(
                LibRainDeploySnapshot.LIB_FS_ROOT, "/0_0_", vm.toString(i + 1), "/", EMITTED_CONTRACT, ".sol"
            );
        }
    }

    function expectedEntry(string memory index, string memory tag) internal pure returns (string memory) {
        string memory head = string.concat(
            "        suites[",
            index,
            "] = DeploySuite({\n            suite: \"address-registry@",
            tag,
            "\",\n            creationCode: AddressRegistry_",
            tag,
            "_CREATION_CODE,\n            storedDeployedAddress: AddressRegistry_",
            tag
        );
        return string.concat(
            head,
            "_DEPLOYED_ADDRESS,\n            storedBytecodeHash: AddressRegistry_",
            tag,
            "_BYTECODE_HASH,\n            storedRuntimeCode: AddressRegistry_",
            tag,
            "_RUNTIME_CODE,\n            artifactPath: \"src/concrete/AddressRegistry.sol:AddressRegistry\",\n",
            "            dependencies: abi.decode(AddressRegistry_",
            tag,
            "_DEPENDENCIES, (address[]))\n        });\n"
        );
    }

    function emitted(uint256 count, DeploySuite memory template) internal pure returns (string memory) {
        return LibReleasedSuitesLibParis.libraryBlock(vm, EMITTED_LIBRARY, EMITTED_CONTRACT, recordOf(count), template);
    }

    function testLibraryBlockDeclaresNoRecord() external pure {
        assertEq(
            emitted(0, emitterTemplate()),
            string.concat(
                EXPECTED_LIBRARY_HEADER,
                "        DeploySuite[] memory suites = new DeploySuite[](0);\n",
                EXPECTED_FOOTER
            )
        );
    }

    function testLibraryBlockDeclaresOneRecord() external pure {
        assertEq(
            emitted(1, emitterTemplate()),
            string.concat(
                EXPECTED_LIBRARY_HEADER,
                "        DeploySuite[] memory suites = new DeploySuite[](1);\n",
                expectedEntry("0", "0_0_1"),
                EXPECTED_FOOTER
            )
        );
    }

    function testLibraryBlockDeclaresTwoRecords() external pure {
        assertEq(
            emitted(2, emitterTemplate()),
            string.concat(
                EXPECTED_LIBRARY_HEADER,
                "        DeploySuite[] memory suites = new DeploySuite[](2);\n",
                expectedEntry("0", "0_0_1"),
                expectedEntry("1", "0_0_2"),
                EXPECTED_FOOTER
            )
        );
    }

    function testEntriesTakeDependenciesFromTheFrozenRecord() external pure {
        DeploySuite memory declared = emitterTemplate();
        declared.dependencies = new address[](2);
        declared.dependencies[0] = address(0xdead);
        declared.dependencies[1] = address(0xbeef);

        string memory block_ = emitted(2, declared);
        assertTrue(vm.contains(block_, "dependencies: abi.decode(AddressRegistry_0_0_1_DEPENDENCIES, (address[]))"));
        assertTrue(vm.contains(block_, "dependencies: abi.decode(AddressRegistry_0_0_2_DEPENDENCIES, (address[]))"));
        assertFalse(vm.contains(block_, "dead"));
        assertFalse(vm.contains(block_, "beef"));
    }
}
