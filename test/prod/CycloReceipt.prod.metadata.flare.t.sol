// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {
    PROD_FLARE_RECEIPT_CYSFLR,
    PROD_FLARE_RECEIPT_CYWETH,
    PROD_FLARE_RECEIPT_CYFXRP,
    PROD_FLARE_RECEIPT_CYJOULE
} from "src/lib/LibCycloProdReceipt.sol";
import {CycloReceiptMetadataTest} from "test/abstract/CycloReceiptMetadataTest.sol";
import {LibCycloTestProd} from "test/lib/LibCycloTestProd.sol";

import {ICycloVault, CycloVaultConfig} from "test/interface/ICycloVault.sol";
import {ICloneableFactoryV2} from "test/interface/ICloneableFactoryV2.sol";
import {IERC20} from "forge-std-1.16.2/src/interfaces/IERC20.sol";
import {FLARE_SFLR} from "src/lib/LibCycloProdAssets.sol";
import {PROD_FLARE_CLONE_FACTORY_ADDRESS_V1} from "src/lib/LibCycloProdCloneFactory.sol";
import {PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2} from "src/lib/LibCycloProdOracle.sol";
import {CREATION_CODE as CYCLO_VAULT_CREATION_CODE} from "src/generated/candidate/CycloVaultFlare.sol";

contract CycloReceiptProdMetadataFlareTest is CycloReceiptMetadataTest {
    function testProdCycloReceiptURI() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptURIV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYWETH, "cyWETH", "WETH", 18);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYFXRP, "cyFXRP.ftso", "FXRP", 6);
        checkCycloReceiptURIV2(PROD_FLARE_RECEIPT_CYJOULE, "cyJOULE.ftso", "JOULE", 18);
    }

    function testProdCycloReceiptName() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptNameV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYFXRP, "FXRP.ftso");
        checkCycloReceiptNameV2(PROD_FLARE_RECEIPT_CYJOULE, "JOULE.ftso");
    }

    function testProdCycloReceiptSymbol() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptSymbolV1(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYWETH, "WETH");
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYFXRP, "FXRP.ftso");
        checkCycloReceiptSymbolV2(PROD_FLARE_RECEIPT_CYJOULE, "JOULE.ftso");
    }

    function testProdCycloReceiptURIZeroIdReverts() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptURIZeroId(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptURIZeroId(PROD_FLARE_RECEIPT_CYWETH);
        checkCycloReceiptURIZeroId(PROD_FLARE_RECEIPT_CYFXRP);
        checkCycloReceiptURIZeroId(PROD_FLARE_RECEIPT_CYJOULE);
    }

    function testProdCycloReceiptURIVariesWithId() external {
        LibCycloTestProd.createSelectForkFlare(vm);

        checkCycloReceiptURIVariesWithId(PROD_FLARE_RECEIPT_CYSFLR);
        checkCycloReceiptURIVariesWithId(PROD_FLARE_RECEIPT_CYWETH);
        checkCycloReceiptURIVariesWithId(PROD_FLARE_RECEIPT_CYFXRP);
        checkCycloReceiptURIVariesWithId(PROD_FLARE_RECEIPT_CYJOULE);
    }

    /// A fresh vault cloned from the recorded implementation by the production
    /// factory, priced by the production cysFLR oracle.
    function freshReceipt() internal returns (address) {
        LibCycloTestProd.createSelectForkFlare(vm);
        ICycloVault vault = ICycloVault(
            ICloneableFactoryV2(PROD_FLARE_CLONE_FACTORY_ADDRESS_V1)
                .clone(
                    LibCycloTestProd.deploy(CYCLO_VAULT_CREATION_CODE),
                    abi.encode(
                        CycloVaultConfig({
                        priceOracle: PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2,
                        asset: FLARE_SFLR,
                        oracleName: "",
                        oracleSymbol: ""
                    })
                    )
                )
        );
        vm.mockCall(FLARE_SFLR, abi.encodeWithSelector(IERC20.symbol.selector), abi.encode("sFLR"));
        vm.mockCall(FLARE_SFLR, abi.encodeWithSelector(IERC20.decimals.selector), abi.encode(18));
        return vault.receipt();
    }

    function testCycloReceiptURI() external {
        checkCycloReceiptURIV2(freshReceipt(), "cysFLR", "sFLR", 18);
    }

    function testCycloReceiptName() external {
        checkCycloReceiptNameV2(freshReceipt(), "sFLR");
    }

    function testCycloReceiptSymbol() external {
        checkCycloReceiptSymbolV2(freshReceipt(), "sFLR");
    }
}
