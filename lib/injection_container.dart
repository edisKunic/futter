import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'core/services/storage_service.dart';
import 'core/services/token_service.dart';
import 'shared/services/api_service.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  await _initShared();
  await _initFeatures();
}

Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl(sl()));
  sl.registerLazySingleton<TokenService>(() => TokenServiceImpl());
}

Future<void> _initShared() async {
  sl.registerLazySingleton<ApiService>(() => ApiService());
}

Future<void> _initFeatures() async {
  await _initAuth();
  await _initHome();
  await _initProfile();
  await _initWatchlist();
}

Future<void> _initAuth() async {
  // Auth feature dependencies will be added here
}

Future<void> _initHome() async {
  // Home feature dependencies will be added here
}

Future<void> _initProfile() async {
  // Profile feature dependencies will be added here
}

Future<void> _initWatchlist() async {
  // Watchlist feature dependencies will be added here
}
