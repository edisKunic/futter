import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../../core/services/storage_service.dart';
import '../../core/services/token_service.dart';
import '../../core/utils/constants.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';

class ApiService {
  final http.Client _client = GetIt.instance<http.Client>();
  final StorageService _storageService = GetIt.instance<StorageService>();
  final TokenService _tokenService = GetIt.instance<TokenService>();

  Future<Map<String, String>> get _headers async {
    final token = await _tokenService.getValidAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      final refreshed = await _tokenService.refreshTokens();
      if (!refreshed) {
        GetIt.instance<AuthBloc>().add(AuthLoggedOut());
        throw Exception('Authentication failed');
      }
    }

    return response;
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await _headers;
    final response = await _client.get(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
    );
    return await _handleResponse(response);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _headers;
    final response = await _client.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
      body: json.encode(body),
    );
    return await _handleResponse(response);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _headers;
    final response = await _client.put(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
      body: json.encode(body),
    );
    return await _handleResponse(response);
  }

  Future<http.Response> delete(String endpoint) async {
    final headers = await _headers;
    final response = await _client.delete(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
    );
    return await _handleResponse(response);
  }
}
