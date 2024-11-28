import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  // 用户数据
  Map<String, dynamic>? _userData;
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();
  bool _hasCheckedLoginState = false;

  // Getters
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _userData != null;
  String? get userEmail => _userData?['email'];
  int? get userId => _userData?['id'];
  String? get token => _userData?['token'];
  bool get hasCheckedLoginState => _hasCheckedLoginState;

  // 初始化用户状态
  Future<void> initializeUser() async {
    if (_hasCheckedLoginState) return;  // 避免重复检查
    
    _isLoading = true;
    notifyListeners();

    try {
      final isValid = await _authService.isLoggedInValid();
      if (isValid) {
        final email = await _authService.getUserEmail();
        final token = await _authService.getToken();
        if (email != null && token != null) {
          _userData = {
            'email': email,
            'token': token,
          };
        }
      }
    } catch (e) {
      print('Error initializing user: $e');
    } finally {
      _isLoading = false;
      _hasCheckedLoginState = true;
      notifyListeners();
    }
  }

  // 设置用户数据
  Future<void> setUserData(Map<String, dynamic> userData) async {
    _userData = userData;
    
    // 保存到本地存储
    await _authService.saveLoginState(
      token: userData['access_token'],
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
    return _authService.isLoggedInValid();
  }

  // 清除用户数据
  Future<void> clearUserData() async {
    _userData = null;
    await _authService.logout();
    notifyListeners();
  }
}