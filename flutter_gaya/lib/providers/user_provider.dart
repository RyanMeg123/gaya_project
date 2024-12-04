import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  // 用户数据
  Map<String, dynamic>? _userData;
  bool _isLoading = false;
  String? _error;
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();
  bool _hasCheckedLoginState = false;

  // Getters
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _userData != null;
  String? get userEmail => _userData?['email'];
  String? get userName => _userData?['name'];
  int? get userId {
    return _userData?['id'] as int?;
  }

  String? get token => _userData?['token'];
  bool get hasCheckedLoginState => _hasCheckedLoginState;

  // 初始化用户状态
  Future<void> initializeUser() async {
    if (_hasCheckedLoginState) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final isValid = await _authService.isTokenValid();
      if (isValid) {
        final email = await _authService.getUserEmail();
        if (email != null) {
          // 从API获取用户详细信息
          final response = await _apiService.getUserProfile(email);
          _userData = response;
        }
      }
    } catch (e) {
      _error = e.toString();
      _userData = null;
    } finally {
      _isLoading = false;
      _hasCheckedLoginState = true;
      notifyListeners();
    }
  }

  // 设置用户数据
  Future<void> setUserData(Map<String, dynamic> userData) async {
    _userData = {
      'id': userData['user']['id'],
      'email': userData['user']['email'],
      'accessToken': userData['accessToken'],
      'refreshToken': userData['refreshToken'],
    };

    // 保存到本地存储
    await _authService.saveLoginState(
      token: userData['accessToken'],
      refreshToken: userData['refreshToken'],
      email: userData['user']['email'],
    );

    notifyListeners();
  }

  // 登录
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      await setUserData(response);

      // 登录成功后立即初始化用户数据
      await initializeUser();
    } catch (e) {
      print('Login error: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 注册
  Future<void> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.register(
        email: email,
        password: password,
      );

      await setUserData(response);
    } catch (e) {
      print('Register error: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 登出
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _userData = null;
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 更新用户数据
  Future<void> updateUserData(Map<String, dynamic> newData) async {
    if (_userData != null) {
      _userData = {
        ..._userData!,
        ...newData,
      };
      notifyListeners();
    }
  }

  // 检查登录状态
  Future<bool> checkLoginStatus() async {
    if (_userData == null) {
      return false;
    }
    return _authService.isTokenValid();
  }

  // 清除用户数据
  Future<void> clearUserData() async {
    _userData = null;
    await _authService.logout();
    notifyListeners();
  }
}
