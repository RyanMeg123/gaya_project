import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:dio/dio.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userEmailKey = 'user_email';
  final Dio _dio = Dio();

  // 检查 token 是否过期
  Future<bool> isTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (token == null) return false;

    try {
      // 使用 jwt_decode 包解析 token
      final Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

      // 检查过期时间
      final exp = decodedToken['exp'];
      if (exp == null) return false;

      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isBefore(expiry);
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  // 保存登录状态
  Future<void> saveLoginState({
    required String token,
    required String refreshToken,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_userEmailKey, email);
  }

  // 获取用户邮箱
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // 自动刷新 token
  Future<void> refreshTokenIfNeeded() async {
    if (!(await isTokenValid())) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final refreshToken = prefs.getString(_refreshTokenKey);

        if (refreshToken != null) {
          final response = await _dio
              .post('/auth/refresh', data: {'refreshToken': refreshToken});

          if (response.statusCode == 200) {
            await prefs.setString(_tokenKey, response.data['accessToken']);
            await prefs.setString(
                _refreshTokenKey, response.data['refreshToken']);
          }
        }
      } catch (e) {
        print('Token refresh error: $e');
        throw Exception('Failed to refresh token');
      }
    }
  }

  // 登录
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      return response.data;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Login failed');
    }
  }

  // 登出
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userEmailKey);
  }
}
