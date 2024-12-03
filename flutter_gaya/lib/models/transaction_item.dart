import 'package:flutter/material.dart';

class TransactionItem {
  final String title;
  final String date;
  final String amount;
  final Color iconBgColor;
  final IconData icon;

  TransactionItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.iconBgColor,
    required this.icon,
  });
} 