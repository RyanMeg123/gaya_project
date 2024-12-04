import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/notification_item.dart';

class NotificationProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  int _unreadCount = 0;
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;

  int get unreadCount => _unreadCount;
  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;

  // 加载通知列表
  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getNotifications();
      print('Notifications response: $response');
      
      if (response is List) {
        _notifications = response.map((json) => NotificationItem.fromJson(json)).toList();
        _unreadCount = _notifications.where((n) => !n.isRead).length;
        print('Loaded ${_notifications.length} notifications, $_unreadCount unread');
      } else {
        print('Invalid response format: $response');
      }
    } catch (e, stackTrace) {
      print('Error loading notifications: $e');
      print('Stack trace: $stackTrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 标记通知为已读
  Future<void> markAsRead(int notificationId) async {
    try {
      await _apiService.markNotificationAsRead(notificationId);
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        _unreadCount = _unreadCount > 0 ? _unreadCount - 1 : 0;
        notifyListeners();
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  // 标记所有通知为已读
  Future<void> markAllAsRead() async {
    try {
      await _apiService.markAllNotificationsAsRead();
      _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      print('Error marking all notifications as read: $e');
    }
  }
}
