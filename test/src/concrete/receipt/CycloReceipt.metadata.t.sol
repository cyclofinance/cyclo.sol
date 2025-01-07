// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {Base64} from "solady/utils/Base64.sol";
import {CycloReceipt, CYCLO_RECEIPT_SVG_URI} from "src/concrete/receipt/CycloReceipt.sol";
import {DATA_URI_BASE64_PREFIX} from "ethgild/concrete/receipt/Receipt.sol";
import {PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS} from "src/lib/LibCycloProd.sol";
import {PROD_CYSFLR_RECEIPT_SYMBOL, PROD_CYSFLR_RECEIPT_NAME} from "test/lib/LibCycloTestProd.sol";
import {ZeroReceiptId} from "ethgild/error/ErrReceipt.sol";
import {CycloReceiptFactoryTest} from "test/abstract/CycloReceiptFactoryTest.sol";
import {
    CycloVault,
    CycloVaultConfig,
    ReceiptVaultConstructionConfig,
    IPriceOracleV2
} from "src/concrete/vault/CycloVault.sol";
import {SFLR_CONTRACT} from "rain.flare/lib/sflr/LibSceptreStakedFlare.sol";
import {IERC20MetadataUpgradeable as IERC20Metadata} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";

contract CycloReceiptMetadataTest is CycloReceiptFactoryTest {
    function checkCycloReceiptURIZeroId(address cycloReceipt) internal {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        vm.expectRevert(abi.encodeWithSelector(ZeroReceiptId.selector));
        receipt.uri(0);
    }

    function checkCycloReceiptURIV1(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        string memory uri = receipt.uri(0.01544e18);
        MetadataWithImage memory metadata = decodeMetadataURIWithImage(uri);

        assertEq(metadata.decimals, 18);
        assertEq(
            metadata.description,
            "1 of these receipts can be burned alongside 1 cysFLR to redeem 64.766839378238341968 sFLR. Reedem at https://cyclo.finance."
        );
        assertEq(metadata.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(metadata.name, "Receipt for Cyclo lock at 0.01544 USD per sFLR.");
    }

    function checkCycloReceiptURIV2(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        string memory uri = receipt.uri(0.01544e18);
        MetadataWithImage memory metadata = decodeMetadataURIWithImage(uri);

        assertEq(metadata.decimals, 18);
        assertEq(
            metadata.description,
            "1 of these receipts can be burned alongside 1 cysFLR to redeem 64.766839378238341968 of sFLR. Redeem at https://cyclo.finance."
        );
        assertEq(metadata.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(metadata.name, "Receipt for Cyclo lock at 0.01544 USD per sFLR.");
    }

    function checkCycloReceiptName(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.name(), PROD_CYSFLR_RECEIPT_NAME);
    }

    function checkCycloReceiptSymbol(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.symbol(), PROD_CYSFLR_RECEIPT_SYMBOL);
    }

    function testCycloReceiptURI() external {
        CycloVault vault = CycloVault(
            payable(
                iFactory.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptURIV2(address(vault.receipt()));
    }

    function testCycloReceiptName() external {
        CycloVault vault = CycloVault(
            payable(
                iFactory.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptName(address(vault.receipt()));
    }

    function testCycloReceiptSymbol() external {
        CycloVault vault = CycloVault(
            payable(
                iFactory.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_ADDRESS)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptSymbol(address(vault.receipt()));
    }
}
