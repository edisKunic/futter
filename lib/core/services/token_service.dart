import 'dart:convert';
import 'package:get_it/get_it.dart';

import '../models/token_model.dart';
import 'storage_service.dart';
import '../utils/constants.dart';
import '../../shared/services/api_service.dart';

abstract class TokenService {
  Future<TokenModel?> getTokens();
  Future<void> saveTokens(TokenModel tokens);
  Future<void> clearTokens();
  Future<bool> isTokenValid();
  Future<String?> getValidAccessToken();
  Future<bool> refreshTokens();
}

class TokenServiceImpl implements TokenService {
  final StorageService _storageService = GetIt.instance<StorageService>();

  @override
  Future<TokenModel?> getTokens() async {
    final tokenJson = await _storageService.getString(AppConstants.tokenKey);
    if (tokenJson != null) {
      try {
        final json = jsonDecode(tokenJson);
        return TokenModel.fromJson(json);
      } catch (e) {
        await clearTokens();
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveTokens(TokenModel tokens) async {
    final tokenJson = jsonEncode(tokens.toJson());
    await _storageService.setString(AppConstants.tokenKey, tokenJson);
  }

  @override
  Future<void> clearTokens() async {
    await _storageService.remove(AppConstants.tokenKey);
  }

  @override
  Future<bool> isTokenValid() async {
    final tokens = await getTokens();
    if (tokens == null) return false;

    if (tokens.isRefreshTokenExpired) {
      await clearTokens();
      return false;
    }

    return !tokens.isAccessTokenExpired;
  }

  @override
  Future<String?> getValidAccessToken() async {
    final tokens = await getTokens();
    if (tokens == null) return null;

    if (tokens.isRefreshTokenExpired) {
      await clearTokens();
      return null;
    }

    if (tokens.isAccessTokenExpired) {
      final refreshed = await refreshTokens();
      if (!refreshed) return null;

      final newTokens = await getTokens();
      return newTokens?.accessToken;
    }

    return tokens.accessToken;
  }

  @override
  Future<bool> refreshTokens() async {
    final tokens = await getTokens();
    if (tokens == null || tokens.isRefreshTokenExpired) {
      return false;
    }

    try {
      final response = await GetIt.instance<ApiService>().post(
        '/auth/refresh',
        {'refreshToken': tokens.refreshToken},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newTokens = TokenModel(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'] ?? tokens.refreshToken,
          accessTokenExpiry: DateTime.parse(data['accessTokenExpiry']),
          refreshTokenExpiry: DateTime.parse(data['refreshTokenExpiry']),
        );
        await saveTokens(newTokens);
        return true;
      }
    } catch (e) {
      await clearTokens();
    }

    return false;
  }
}
