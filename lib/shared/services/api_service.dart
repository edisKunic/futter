import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../../core/services/storage_service.dart';
import '../../core/utils/constants.dart';

class ApiService {
  final http.Client _client = GetIt.instance<http.Client>();
  final StorageService _storageService = GetIt.instance<StorageService>();

  Future<Map<String, String>> get _headers async {
    final token = await _storageService.getString(AppConstants.authTokenKey);
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await _headers;
    return await _client.get(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
    );
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _headers;
    return await _client.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _headers;
    return await _client.put(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    final headers = await _headers;
    return await _client.delete(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.apiVersion}$endpoint'),
      headers: headers,
    );
  }
}
