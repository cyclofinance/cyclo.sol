// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {RainDeployVerifySnapshot} from "rain-deploy-0.1.11/src/abstract/RainDeployVerifySnapshot.sol";
import {CycloDeploySuites} from "src/abstract/CycloDeploySuites.sol";
import {
    PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE,
    PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE
} from "src/lib/LibCycloProdOracle.sol";

contract CycloDeploySnapshotTest is CycloDeploySuites, RainDeployVerifySnapshot {
    /// `TwoPriceOracleV2` prices itself in its constructor; the price reaches
    /// no immutable, so any nonzero price constructs the recorded bytes.
    function setUp() external {
        vm.mockCall(PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE, abi.encodeWithSignature("price()"), abi.encode(1e18));
        vm.mockCall(PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE, abi.encodeWithSignature("price()"), abi.encode(1e18));
    }
}
