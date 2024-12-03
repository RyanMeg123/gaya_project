import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';
import '../models/transaction_item.dart';

class TransactionProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _error;
  List<TransactionItem> _allTransactions = [];
  List<TransactionItem> _filteredTransactions = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<TransactionItem> get filteredTransactions => _filteredTransactions;

  double get totalExpenses {
    double total = 0.0;
    for (var transaction in _allTransactions) {
      final amountStr = transaction.amount.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.parse(amountStr);
    }
    return total;
  }

  Future<void> loadUserTransactions(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final transactions = await _apiService.getUserTransactions(userId);
      _allTransactions = transactions
          .map((t) => TransactionItem(
                title: t['type'] ?? 'Shopping',
                date: DateFormat('dd MMM yyyy, h:mma')
                    .format(DateTime.parse(t['createdAt'])),
                amount:
                    '-\$${double.parse(t['amount'].toString()).toStringAsFixed(2)}',
                iconBgColor: _getIconBgColor(t['type']),
                icon: _getIconData(t['type']),
              ))
          .toList();

      _filteredTransactions = _allTransactions;
    } catch (e) {
      print('Error loading transactions: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTransaction({
    required String orderNumber,
    required double amount,
    required int userId,
    required String type,
    String? status,
  }) async {
    try {
      await _apiService.createTransaction(
        orderNumber: orderNumber,
        amount: amount,
        userId: userId,
        type: type,
        status: status,
      );

      await loadUserTransactions(userId);
    } catch (e) {
      print('Error in createTransaction: $e');
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  void filterTransactions(String query) {
    if (query.isEmpty) {
      _filteredTransactions = _allTransactions;
    } else {
      _filteredTransactions = _allTransactions.where((transaction) {
        return transaction.title.toLowerCase().contains(query) ||
            transaction.date.toLowerCase().contains(query) ||
            transaction.amount.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Color _getIconBgColor(String? type) {
    switch (type) {
      case 'Shopping':
        return const Color(0xFFFFCF81);
      case 'Medicine':
        return const Color(0xFFE09FFF);
      case 'Sport':
        return const Color(0xEA00DADE);
      case 'Travel':
        return const Color(0xEAFF8787);
      default:
        return Colors.grey;
    }
  }

  IconData _getIconData(String? type) {
    switch (type) {
      case 'Shopping':
        return MdiIcons.cartOutline;
      case 'Medicine':
        return MdiIcons.pill;
      case 'Sport':
        return MdiIcons.basketball;
      case 'Travel':
        return MdiIcons.airplane;
      default:
        return MdiIcons.helpCircleOutline;
    }
  }
}
