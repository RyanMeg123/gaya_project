import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class TransactionProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = false;
  String? _error;
  bool _isDisposed = false;

  List<Map<String, dynamic>> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> loadUserTransactions(int userId) async {
    if (_isDisposed) return;
    
    _isLoading = true;
    _error = null;
    _safeNotifyListeners();

    try {
      _transactions = await _apiService.getUserTransactions(userId);
    } catch (e) {
      print('Error loading transactions: $e');
      _error = e.toString();
    } finally {
      if (!_isDisposed) {
        _isLoading = false;
        _safeNotifyListeners();
      }
    }
  }

  Future<void> createTransaction({
    required String orderNumber,
    required double amount,
    required int userId,
    required String type,
    String? status,
  }) async {
    if (_isDisposed) return;

    try {
      await _apiService.createTransaction(
        orderNumber: orderNumber,
        amount: amount,
        userId: userId,
        type: type,
        status: status,
      );
      
      // 刷新交易列表
      if (!_isDisposed) {
        await loadUserTransactions(userId);
      }
    } catch (e) {
      print('Error in createTransaction: $e');
      _error = e.toString();
      _safeNotifyListeners();
      rethrow;
    }
  }

  double get totalExpenses {
    return _transactions.fold(
      0.0, 
      (sum, transaction) => sum + double.parse(transaction['amount'].toString())
    );
  }

  void clearError() {
    _error = null;
    _safeNotifyListeners();
  }
} 