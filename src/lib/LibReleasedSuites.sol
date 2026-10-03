// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {DeploySuite} from "../abstract/RainDeploySuitesBase.sol";

library LibReleasedSuites {
    function releasedSuites() internal pure returns (DeploySuite[] memory) {
        return new DeploySuite[](0);
    }
}
