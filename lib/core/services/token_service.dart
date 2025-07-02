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
  TokenModel? _mockTokens;

  StorageService? get _safeStorageService {
    try {
      return GetIt.instance<StorageService>();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TokenModel?> getTokens() async {
    if (_mockTokens != null) return _mockTokens;

    try {
      final storage = _safeStorageService;
      if (storage != null) {
        final tokenJson = await storage.getString(AppConstants.tokenKey);
        if (tokenJson != null) {
          final json = jsonDecode(tokenJson);
          return TokenModel.fromJson(json);
        }
      }
    } catch (e) {
      // Ignore storage errors
    }
    return null;
  }

  @override
  Future<void> saveTokens(TokenModel tokens) async {
    _mockTokens = tokens;

    try {
      final storage = _safeStorageService;
      if (storage != null) {
        final tokenJson = jsonEncode(tokens.toJson());
        await storage.setString(AppConstants.tokenKey, tokenJson);
      }
    } catch (e) {
      // Ignore storage errors, keep in memory
    }
  }

  @override
  Future<void> clearTokens() async {
    _mockTokens = null;

    try {
      final storage = _safeStorageService;
      if (storage != null) {
        await storage.remove(AppConstants.tokenKey);
      }
    } catch (e) {
      // Ignore storage errors
    }
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
    // Mock refresh - always return true for demo
    return true;
  }
}
