// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {Base64} from "solady/utils/Base64.sol";
import {CycloReceipt, CYCLO_RECEIPT_SVG_URI} from "src/concrete/receipt/CycloReceipt.sol";
import {DATA_URI_BASE64_PREFIX} from "ethgild/concrete/receipt/Receipt.sol";
import {PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2} from "src/lib/LibCycloProdOracle.sol";
import {PROD_CYSFLR_RECEIPT_SYMBOL, PROD_CYSFLR_RECEIPT_NAME} from "test/lib/LibCycloTestProd.sol";
import {ZeroReceiptId} from "ethgild/error/ErrReceipt.sol";
import {CycloReceiptFactoryTest} from "test/abstract/CycloReceiptFactoryTest.sol";
import {
    CycloVault,
    CycloVaultConfig,
    ReceiptVaultConstructionConfigV2,
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

    function checkCycloReceiptURIV2(address cycloReceipt, string memory assetSymbol) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);

        string memory uri = receipt.uri(0.01544e18);
        MetadataWithImage memory metadata = decodeMetadataURIWithImage(uri);

        assertEq(metadata.decimals, 18);
        assertEq(
            metadata.description,
            string.concat(
                "1 of these receipts can be burned alongside 1 cy",
                assetSymbol,
                " to redeem 64.766839378238341968 of ",
                assetSymbol,
                ". Redeem at https://cyclo.finance."
            )
        );
        assertEq(metadata.image, CYCLO_RECEIPT_SVG_URI);
        assertEq(metadata.name, string.concat("Receipt for Cyclo lock at 0.01544 USD per ", assetSymbol, "."));
    }

    function checkCycloReceiptNameV1(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.name(), PROD_CYSFLR_RECEIPT_NAME);
    }

    function checkCycloReceiptNameV2(address cycloReceipt, string memory assetSymbol) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.name(), string.concat("cy", assetSymbol, " Receipt"));
    }

    function checkCycloReceiptSymbolV1(address cycloReceipt) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.symbol(), PROD_CYSFLR_RECEIPT_SYMBOL);
    }

    function checkCycloReceiptSymbolV2(address cycloReceipt, string memory assetSymbol) internal view {
        CycloReceipt receipt = CycloReceipt(cycloReceipt);
        assertEq(receipt.symbol(), string.concat("cy", assetSymbol, " RCPT"));
    }

    function testCycloReceiptURI() external {
        CycloVault vault = CycloVault(
            payable(
                I_FACTORY.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptURIV2(address(vault.receipt()), "sFLR");
    }

    function testCycloReceiptName() external {
        CycloVault vault = CycloVault(
            payable(
                I_FACTORY.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptNameV2(address(vault.receipt()), "sFLR");
    }

    function testCycloReceiptSymbol() external {
        CycloVault vault = CycloVault(
            payable(
                I_FACTORY.clone(
                    address(iCycloVaultImplementation),
                    abi.encode(
                        CycloVaultConfig({
                            priceOracle: IPriceOracleV2(payable(PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2)),
                            asset: address(SFLR_CONTRACT)
                        })
                    )
                )
            )
        );

        vm.mockCall(address(SFLR_CONTRACT), abi.encodeWithSelector(IERC20Metadata.symbol.selector), abi.encode("sFLR"));

        checkCycloReceiptSymbolV2(address(vault.receipt()), "sFLR");
    }
}
