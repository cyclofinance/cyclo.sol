// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

address constant PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE = 0x0D8F6a13a76a216ef9E9a4bc388306E612AC2728;
/// @dev Matches following code at deploy.
/// SceptreStakedFlrOracle fresh = new SceptreStakedFlrOracle();
bytes32 constant PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH =
    bytes32(0xa540caf937ff11518862c386712aea4f956d2a02af340deb4f0a54a9a7cbf241);

address constant PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE = 0xA7A10eA8707886F98887C913233ad38d54f4796e;
/// @dev Matches following code at deploy.
/// FtsoV2LTSFeedOracle fresh =
/// new FtsoV2LTSFeedOracle(FtsoV2LTSFeedOracleConfig({feedId: FLR_USD_FEED_ID, staleAfter: 30 minutes}));
bytes32 constant PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH =
    bytes32(0x8b685c142559c4ccbe78bf63366b8e8f098c4a8f9f2c7f9c1adbe99a229c13e2);

address constant PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE = 0x2278CF12eA5Eed8C14242B7b92D7e70711CB6485;

address constant PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2 = 0x0a408517bf87714c634b48e0C2534887996E1BC9;
/// @dev Matches following code at deploy.
/// TwoPriceOracleV2 fresh = new TwoPriceOracleV2(
///     TwoPriceOracleConfigV2({
///         base: IPriceOracleV2(payable(PROD_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_ADDRESS)),
///         quote: IPriceOracleV2(payable(PROD_SCEPTRE_STAKED_FLR_ORACLE_ADDRESS))
///     })
/// );
bytes32 constant PROD_FLARE_TWO_PRICE_ORACLE_FLR_USD__SFLR_V2_CODEHASH =
    bytes32(0xffcbd80d69d21dd4c2a68188b5944d9263fac88fccea8aefef1e6f309df35c3f);
