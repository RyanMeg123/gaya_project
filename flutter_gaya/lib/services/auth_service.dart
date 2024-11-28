import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';
  static const String _lastLoginKey = 'last_login';

  // 保存登录状态
  Future<void> saveLoginState({
    required String token,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userEmailKey, email);
    await prefs.setString(_lastLoginKey, DateTime.now().toIso8601String());
  }

  // 检查是否在有效期内
  Future<bool> isLoggedInValid() async {
    final prefs = await SharedPreferences.getInstance();
    final lastLoginStr = prefs.getString(_lastLoginKey);
    final token = prefs.getString(_tokenKey);

    if (lastLoginStr == null || token == null) {
      return false;
    }

    final lastLogin = DateTime.parse(lastLoginStr);
    final now = DateTime.now();
    final difference = now.difference(lastLogin);

    // 检查是否在24小时内
    return difference.inHours < 24;
  }

  // 获取保存的token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 获取用户邮箱
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // 清除登录状态
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_lastLoginKey);
  }
}
