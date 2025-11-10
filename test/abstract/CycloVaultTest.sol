// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {CycloVaultConfig, CycloVault, IPriceOracleV2} from "src/concrete/vault/CycloVault.sol";
import {ReceiptVaultConstructionConfigV2} from "ethgild/concrete/vault/ERC20PriceOracleReceiptVault.sol";
import {ICloneableFactoryV2} from "rain.factory/interface/ICloneableFactoryV2.sol";
import {IReceiptV3} from "ethgild/abstract/ReceiptVault.sol";

abstract contract CycloVaultTest is Test {
    address constant ASSET = address(bytes20(keccak256(bytes("asset"))));
    IPriceOracleV2 constant ORACLE = IPriceOracleV2(payable(address(bytes20(keccak256(bytes("oracle"))))));
    string constant ORACLE_NAME = "TheOracle";
    string constant ORACLE_SYMBOL = "to";

    CycloVault internal sCycloVault;
    CycloVault internal sCycloVaultImplementation;

    function _cloneFactory() internal pure virtual returns (ICloneableFactoryV2) {
        return ICloneableFactoryV2(address(0));
    }

    function _receiptImplementation() internal pure virtual returns (IReceiptV3) {
        return IReceiptV3(address(0));
    }

    function _rpcEnvName() internal pure virtual returns (string memory) {
        return "";
    }

    function _blockNumber() internal pure virtual returns (uint256) {
        return 0;
    }

    function setUp() external {
        vm.createSelectFork(vm.envString(_rpcEnvName()), _blockNumber());

        ReceiptVaultConstructionConfigV2 memory receiptVaultConstructionConfig = ReceiptVaultConstructionConfigV2({
            factory: _cloneFactory(),
            receiptImplementation: _receiptImplementation()
        });
        sCycloVaultImplementation = new CycloVault(receiptVaultConstructionConfig);
        sCycloVault = CycloVault(
            payable(
                _cloneFactory().clone(
                    address(sCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: ORACLE,
                            asset: ASSET,
                            oracleName: ORACLE_NAME,
                            oracleSymbol: ORACLE_SYMBOL
                        })
                    )
                )
            )
        );
        assertEq(sCycloVault.asset(), ASSET);
    }
}
