import 'package:flutter/material.dart';
import 'dart:async';
import '../services/auth_service.dart';
import '../routes.dart';
import '../main.dart';

class AuthProvider extends ChangeNotifier {
  Timer? _tokenCheckTimer;
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    await checkLoginState();
    startTokenCheck();
  }

  Future<void> checkLoginState() async {
    final authService = AuthService();
    _isLoggedIn = await authService.isTokenValid();
    _userEmail = await authService.getUserEmail();
    notifyListeners();
  }

  void startTokenCheck() {
    _tokenCheckTimer?.cancel();
    _tokenCheckTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      checkAndRefreshToken();
    });
  }

  Future<void> checkAndRefreshToken() async {
    if (!_isLoggedIn) return;

    final authService = AuthService();
    final isValid = await authService.isTokenValid();

    if (!isValid) {
      try {
        await authService.refreshTokenIfNeeded();
      } catch (e) {
        print('Token refresh failed: $e');
        await logout();
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final authService = AuthService();
      final response = await authService.login(email, password);

      await authService.saveLoginState(
        token: response['accessToken'],
        refreshToken: response['refreshToken'],
        email: email,
      );

      _isLoggedIn = true;
      _userEmail = email;
      startTokenCheck();
      notifyListeners();

      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.homePage);
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    _tokenCheckTimer?.cancel();
    await AuthService().logout();
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  void dispose() {
    _tokenCheckTimer?.cancel();
    super.dispose();
  }
}
