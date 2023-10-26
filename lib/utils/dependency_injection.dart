import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

import '../data/cache/auth_cache_manager.dart';
import '../data/network/dio_manager.dart';
import '../data/network/http_overrides.dart';
import '../data/service/auth_service.dart';
import '../res/api_info/api_info.dart';

/// di reference variable
GetIt locator = GetIt.instance;

/// Root function for di
Future<void> diInit() async {
  /// Base
  await _base();

  await _network();

  await _authorization();

  /// Globalization (ex. https, shared_preferences, etc variables)
  await _globalInit();

  /// Ensure the injections
  await locator.allReady();
}

/// Should be initializing beginning
Future<void> _base() async {
  /// App initialized
  WidgetsFlutterBinding.ensureInitialized();
}

/// Should be initializing ending
Future<void> _globalInit() async {
  HttpOverrides.global = locator<ApplicationHttpOverrides>();
}

/// API or Networks
Future<void> _network() async {
  /// ApplicationHttpOverrides
  locator.registerLazySingleton<ApplicationHttpOverrides>(() {
    return ApplicationHttpOverrides();
  });

  /// DioManager
  locator.registerLazySingleton<DioManager>(() {
    return DioManager.getInstance(ApiConstants.baseUrl);
  });
}

/// Authorizations
Future<void> _authorization() async {
  /// AuthService
  locator.registerLazySingleton<AuthService>(() {
    return AuthService(locator());
  });

  /// AuthCacheManager
  locator.registerLazySingleton<AuthCacheManager>(() {
    return AuthCacheManager();
  });

  /// Repository
  locator.registerFactory<LoginRepository>(() {
    return LoginRepository(
      authService: locator<AuthService>(),
      cacheManager: locator<AuthCacheManager>(),
    );
  });
}
