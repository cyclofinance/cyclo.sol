// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

// 30 mins.
uint256 constant PROD_ORACLE_DEFAULT_STALE_AFTER = 30 minutes;

address constant PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE = 0x0D8F6a13a76a216ef9E9a4bc388306E612AC2728;
/// @dev Matches following code at deploy.
/// SceptreStakedFlrOracle fresh = new SceptreStakedFlrOracle();
bytes32 constant PROD_FLARE_SCEPTRE_STAKED_FLR_ORACLE_CODEHASH =
    bytes32(0x88baf7bda4fb19c787270f66a6deb756d7a336e8e5f6ed737d592b20095b98db);

address constant PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE = 0xA7A10eA8707886F98887C913233ad38d54f4796e;
/// @dev Matches following code at deploy.

bytes32 constant PROD_FLARE_FTSO_V2_LTS_FLR_USD_FEED_ORACLE_CODEHASH =
    bytes32(0xd77055072203de0325149596bb0d374c0bb0655234931e3b7bf486d297ba5651);
bytes32 constant PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE_CODEHASH =
    bytes32(0xebcd7ca3e37f97f414d5ec26152625961d7ba05c2cac4773a0e1d336b5e45f5f);

address constant PROD_FLARE_FTSO_V2_LTS_ETH_USD_FEED_ORACLE = 0xF9971CE9eAb87E727fEBE6206A0cB5d77391b095;

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
