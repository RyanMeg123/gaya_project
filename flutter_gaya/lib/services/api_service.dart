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
      logPrint: (obj) {
        print('\x1B[32m${obj.toString()}\x1B[0m');  // 绿色输出
      }
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
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      // 直接返回响应数据
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  // 获取折扣产品
  Future<List<Map<String, dynamic>>> getDiscountedProducts() async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'isDiscounted': true,
        'limit': 4,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      print('Error getting discounted products: $e');
      throw Exception('Failed to load products');
    }
  }

  // 搜索产品
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'search': query,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      throw Exception('Failed to search products');
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Failed to search products');
    }
  }

  // 获取特定分类的商品
  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'category': category,
      });
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      print('Error getting products by category: $e');
      throw Exception('Failed to load products');
    }
  }
}
