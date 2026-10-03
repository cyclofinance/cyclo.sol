// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {IPyth} from "pyth-sdk/IPyth.sol";
import {PythStructs} from "pyth-sdk/PythStructs.sol";
import {LibDecimalFloat, Float} from "rain.math.float/lib/LibDecimalFloat.sol";
import {IntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";

error UnsupportedChainId();

error UnsupportedFeedSymbol();

/// Chain IDs from https://chainlist.org/
/// Price feed contract addresses from https://docs.pyth.network/price-feeds/contract-addresses/evm
library LibPyth {
    uint256 constant CHAIN_ID_ARBITRUM = 42161;
    uint256 constant CHAIN_ID_BASE = 8453;

    IPyth constant PRICE_FEED_CONTRACT_ARBITRUM = IPyth(0xff1a0f4744e8582DF1aE09D5611b887B6a12925C);
    IPyth constant PRICE_FEED_CONTRACT_BASE = IPyth(0x8250f4aF4B972684F7b336503E2D6dFeDeB1487a);

    /// Crypto feeds.
    /// https://docs.pyth.network/price-feeds/core/price-feeds/price-feed-ids
    /// ARB/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_ARB_USD = 0x3fa4252848f9f0a1480be62745a4629d9eb1322aebab8a791e344b3b9c1adcf5;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ARB_USD =
        uint256(0x8E43727970746F2E4152422F5553440000000000000000000000000000000000);
    /// BTC/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_BTC_USD = 0xe62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_BTC_USD =
        uint256(0x8e43727970746f2e4254432f5553440000000000000000000000000000000000);
    /// WBTC/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_WBTC_USD = 0xc9d8b075a5c69303365ae23633d4e085199bf5c520a3b90fed1322a0342ffc33;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WBTC_USD =
        uint256(0x8F43727970746F2E574254432F55534400000000000000000000000000000000);
    /// CBBTC/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_CBBTC_USD = 0x2817d7bfe5c64b8ea956e9a26f573ef64e72e4d7891f2d6af9bcc93f7aff9a97;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_CBBTC_USD =
        uint256(0x9043727970746F2E43424254432F555344000000000000000000000000000000);
    /// DOT/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_DOT_USD = 0xca3eed9b267293f6595901c734c7525ce8ef49adafe8284606ceb307afa2ca5b;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_DOT_USD =
        uint256(0x8E43727970746F2E444F542F5553440000000000000000000000000000000000);
    /// ENA/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_ENA_USD = 0xb7910ba7322db020416fcac28b48c01212fd9cc8fbcbaf7d30477ed8605f6bd4;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ENA_USD =
        uint256(0x8E43727970746F2E454E412F5553440000000000000000000000000000000000);
    /// ETH/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_ETH_USD = 0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ETH_USD =
        uint256(0x8e43727970746f2e4554482f5553440000000000000000000000000000000000);
    /// WETH/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_WETH_USD = 0x9d4294bbcd1174d6f2003ec365831e64cc31d9f6f15a2b85399db8d5000960f6;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WETH_USD =
        uint256(0x8F43727970746F2E574554482F55534400000000000000000000000000000000);
    /// WSTETH/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_WSTETH_USD =
        0x6df640f3b8963d8f8358f791f352b8364513f6ab1cca5ed3f1f7b5448980e784;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WSTETH_USD =
        uint256(0x9143727970746F2E5753544554482F5553440000000000000000000000000000);
    /// LINK/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_LINK_USD = 0x8ac0c70fff57e9aefdf5edf44b51d62c2d433653cbb2cf5cc06bb115af04d221;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_LINK_USD =
        uint256(0x8F43727970746F2E4C494E4B2F55534400000000000000000000000000000000);
    /// PEPE/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_PEPE_USD = 0xd69731a2e74ac1ce884fc3890f7ee324b6deb66147055249568869ed700882e4;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_PEPE_USD =
        uint256(0x8F43727970746F2E504550452F55534400000000000000000000000000000000);
    /// PYTH/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_PYTH_USD = 0x0bbf28e9a841a1cc788f6a361b17ca072d0ea3098a1e5df1c3922d06719579ff;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_PYTH_USD =
        uint256(0x8F43727970746F2E505954482F55534400000000000000000000000000000000);
    /// UNI/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_UNI_USD = 0x78d185a741d07edb3412b09008b7c5cfb9bbbd7d568bf00ba737b456ba171501;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_UNI_USD =
        uint256(0x8E43727970746F2E554E492F5553440000000000000000000000000000000000);
    /// XAUT/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_XAUT_USD = 0x44465e17d2e9d390e70c999d5a11fda4f092847fcd2e3e5aa089d96c98a30e67;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_XAUT_USD =
        uint256(0x8F43727970746F2E584155542F55534400000000000000000000000000000000);
    /// XRP/USD
    bytes32 constant PRICE_FEED_ID_CRYPTO_XRP_USD = 0xec5d399846a9209f3fe5881d70aae9268c94339ff9817e8d18ff19fa05eea1c8;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_XRP_USD =
        uint256(0x8e43727970746f2e5852502f5553440000000000000000000000000000000000);

    /// Magnificent 7 share price feed IDs.
    /// Google.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_GOOG_USD =
        0xe65ff435be42630439c96396653a342829e877e2aafaeaf1a10d0ee5fd2cf3f2;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GOOG_USD =
        0x924571756974792e55532e474f4f472f55534400000000000000000000000000;
    /// Amazon.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_AMZN_USD =
        0xb5d0e0fa58a1f8b81498ae670ce93c872d14434b72c364885d4fa1b257cbb07a;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AMZN_USD =
        0x924571756974792e55532e414d5a4e2f55534400000000000000000000000000;
    /// Apple.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_AAPL_USD =
        0x49f6b65cb1de6b10eaf75e7c03ca029c306d0357e91b5311b175084a5ad55688;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AAPL_USD =
        0x924571756974792e55532e4141504c2f55534400000000000000000000000000;
    /// Microsoft.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_MSFT_USD =
        0xd0ca23c1cc005e004ccf1db5bf76aeb6a49218f43dac3d4b275e92de12ded4d1;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSFT_USD =
        0x924571756974792e55532e4d5346542f55534400000000000000000000000000;
    /// Tesla.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_TSLA_USD =
        0x16dad506d7db8da01c87581c87ca897a012a153557d4d578c3b9c9e1bc0632f1;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_TSLA_USD =
        0x924571756974792e55532e54534c412f55534400000000000000000000000000;
    /// Nvidia.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_NVDA_USD =
        0xb1073854ed24cbc755dc527418f52b7d271f6cc967bbf8d8129112b18860a593;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_NVDA_USD =
        0x924571756974792e55532e4e5644412f55534400000000000000000000000000;
    /// Meta Platforms (Facebook).
    bytes32 constant PRICE_FEED_ID_EQUITY_US_META_USD =
        0x78a3e3b8e676a8f73c439f5d749737034b139bbbe899ba5775216fba596607fe;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_META_USD =
        0x924571756974792e55532e4d4554412f55534400000000000000000000000000;
    /// Gamestop
    bytes32 constant PRICE_FEED_ID_EQUITY_US_GME_USD =
        0x6f9cd89ef1b7fd39f667101a91ad578b6c6ace4579d5f7f285a4b06aa4504be6;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GME_USD =
        0x914571756974792e55532e474d452f5553440000000000000000000000000000;
    /// MicroStrategy (MSTR)
    bytes32 constant PRICE_FEED_ID_EQUITY_US_MSTR_USD =
        0xe1e80251e5f5184f2195008382538e847fafc36f751896889dd3d1b1f6111f09;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSTR_USD =
        0x924571756974792e55532e4d5354522f55534400000000000000000000000000;
    /// Berkshire Hathaway Class B (BRK-B)
    bytes32 constant PRICE_FEED_ID_EQUITY_US_BRK_B_USD =
        0xe21c688b7fc65b4606a50f3635f466f6986db129bf16979875d160f9c508e8c7;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_BRK_B_USD =
        0x934571756974792e55532e42524b2d422f555344000000000000000000000000;
    /// SPDR Portfolio S&P 500 ETF (SPLG)
    bytes32 constant PRICE_FEED_ID_EQUITY_US_SPLG_USD =
        0x4dfbf28d72ab41a878afcd4c6d5e9593dca7cf65a0da739cbad9b7414004f82d;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_SPLG_USD =
        0x924571756974792e55532e53504c472f55534400000000000000000000000000;
    /// iShares Gold Trust (IAU)
    bytes32 constant PRICE_FEED_ID_EQUITY_US_IAU_USD =
        0xf703fbded84f7da4bd9ff4661b5d1ffefa8a9c90b7fa12f247edc8251efac914;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_IAU_USD =
        0x914571756974792e55532e4941552f5553440000000000000000000000000000;

    /// TODO replace with O(1) lookup table.
    function getPriceFeedContract(uint256 chainId) internal pure returns (IPyth) {
        if (chainId == CHAIN_ID_ARBITRUM) {
            return PRICE_FEED_CONTRACT_ARBITRUM;
        } else if (chainId == CHAIN_ID_BASE) {
            return PRICE_FEED_CONTRACT_BASE;
        } else {
            revert UnsupportedChainId();
        }
    }

    /// TODO replace with O(1) lookup table.
    function getPriceFeedId(IntOrAString feedSymbolIntOrAString) internal pure returns (bytes32) {
        uint256 feedSymbol = IntOrAString.unwrap(feedSymbolIntOrAString);
        if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ARB_USD) {
            return PRICE_FEED_ID_CRYPTO_ARB_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_BTC_USD) {
            return PRICE_FEED_ID_CRYPTO_BTC_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WBTC_USD) {
            return PRICE_FEED_ID_CRYPTO_WBTC_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_CBBTC_USD) {
            return PRICE_FEED_ID_CRYPTO_CBBTC_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_DOT_USD) {
            return PRICE_FEED_ID_CRYPTO_DOT_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ENA_USD) {
            return PRICE_FEED_ID_CRYPTO_ENA_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_ETH_USD) {
            return PRICE_FEED_ID_CRYPTO_ETH_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WETH_USD) {
            return PRICE_FEED_ID_CRYPTO_WETH_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_WSTETH_USD) {
            return PRICE_FEED_ID_CRYPTO_WSTETH_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_LINK_USD) {
            return PRICE_FEED_ID_CRYPTO_LINK_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_PEPE_USD) {
            return PRICE_FEED_ID_CRYPTO_PEPE_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_PYTH_USD) {
            return PRICE_FEED_ID_CRYPTO_PYTH_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_UNI_USD) {
            return PRICE_FEED_ID_CRYPTO_UNI_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_XAUT_USD) {
            return PRICE_FEED_ID_CRYPTO_XAUT_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_CRYPTO_XRP_USD) {
            return PRICE_FEED_ID_CRYPTO_XRP_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GOOG_USD) {
            return PRICE_FEED_ID_EQUITY_US_GOOG_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AMZN_USD) {
            return PRICE_FEED_ID_EQUITY_US_AMZN_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AAPL_USD) {
            return PRICE_FEED_ID_EQUITY_US_AAPL_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSFT_USD) {
            return PRICE_FEED_ID_EQUITY_US_MSFT_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_TSLA_USD) {
            return PRICE_FEED_ID_EQUITY_US_TSLA_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_NVDA_USD) {
            return PRICE_FEED_ID_EQUITY_US_NVDA_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_META_USD) {
            return PRICE_FEED_ID_EQUITY_US_META_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GME_USD) {
            return PRICE_FEED_ID_EQUITY_US_GME_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSTR_USD) {
            return PRICE_FEED_ID_EQUITY_US_MSTR_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_BRK_B_USD) {
            return PRICE_FEED_ID_EQUITY_US_BRK_B_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_SPLG_USD) {
            return PRICE_FEED_ID_EQUITY_US_SPLG_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_IAU_USD) {
            return PRICE_FEED_ID_EQUITY_US_IAU_USD;
        } else {
            revert UnsupportedFeedSymbol();
        }
    }

    function getPriceNoOlderThan(IntOrAString feedSymbol, Float staleAfter) internal view returns (Float, Float) {
        uint256 staleAfterUint = LibDecimalFloat.toFixedDecimalLossless(staleAfter, 0);
        bytes32 feedId = getPriceFeedId(feedSymbol);
        IPyth priceFeedContract = getPriceFeedContract(block.chainid);

        // Slither false positive because conf is returned for caller to handle.
        // slither-disable-next-line pyth-unchecked-confidence
        PythStructs.Price memory priceData = priceFeedContract.getPriceNoOlderThan(feedId, staleAfterUint);

        return (
            LibDecimalFloat.packLossless(priceData.price, priceData.expo),
            LibDecimalFloat.packLossless(int256(uint256(priceData.conf)), priceData.expo)
        );
    }
}
