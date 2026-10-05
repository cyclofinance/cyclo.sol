// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test} from "forge-std-1.16.2/src/Test.sol";
import {ICycloVault, CycloVaultConfig} from "test/interface/ICycloVault.sol";
import {ICloneableFactoryV2} from "test/interface/ICloneableFactoryV2.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

/// A fresh vault cloned on a production fork from the recorded vault
/// implementation creation code, next to the production vaults.
abstract contract CycloVaultTest is Test {
    address constant ASSET = address(bytes20(keccak256(bytes("asset"))));
    address constant ORACLE = address(bytes20(keccak256(bytes("oracle"))));
    string constant ORACLE_NAME = "TheOracle";
    string constant ORACLE_SYMBOL = "to";

    ICycloVault internal sCycloVault;
    address internal sCycloVaultImplementation;

    function _cloneFactory() internal pure virtual returns (ICloneableFactoryV2);

    /// The recorded vault creation code for this chain, constructor
    /// arguments included.
    function _vaultCreationCode() internal pure virtual returns (bytes memory);

    function _rpcEnvName() internal pure virtual returns (string memory);

    function _blockNumber() internal pure virtual returns (uint256);

    function setUp() external {
        vm.createSelectFork(vm.envString(_rpcEnvName()), _blockNumber());

        sCycloVaultImplementation = LibCycloTestProd.deploy(_vaultCreationCode());
        sCycloVault = ICycloVault(
            _cloneFactory()
                .clone(
                    sCycloVaultImplementation,
                    abi.encode(
                        CycloVaultConfig({
                        priceOracle: ORACLE, asset: ASSET, oracleName: ORACLE_NAME, oracleSymbol: ORACLE_SYMBOL
                    })
                    )
                )
        );
        assertEq(sCycloVault.asset(), ASSET);
    }
}
