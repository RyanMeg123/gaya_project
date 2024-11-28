import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://localhost:3000'; // 开发环境使用localhost

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    
    // 添加日志拦截器
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // 用户注册
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/users/register', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response?.data['message'] ?? 'Registration failed');
      }
      throw Exception('Network error');
    }
  }

  // 用户登录
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting login with email: $email'); // 添加日志
      
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      print('Login response: ${response.data}'); // 添加日志
      
      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      } else {
        throw Exception('Login failed: Invalid response');
      }
      
    } catch (e) {
      if (e is DioException) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
        
        if (e.response?.data != null && e.response?.data['message'] != null) {
          throw Exception(e.response?.data['message']);
        } else if (e.type == DioExceptionType.connectionTimeout) {
          throw Exception('Connection timeout. Please try again.');
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('Network error. Please check your connection.');
        }
      }
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // 错误处理
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        return Exception(error.response?.data['message'] ?? 'Unknown error');
      }
      return Exception(error.message ?? 'Network error');
    }
    return Exception('Something went wrong');
  }
}
