class NotificationItem {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final String type; // 'order', 'system', 'promotion'

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
    required this.type,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationItem(
        id: json['id'] as int,
        title: json['title'] as String,
        message: json['message'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        isRead: json['isRead'] as bool? ?? false,
        type: json['type'] as String,
      );
    } catch (e) {
      print('Error parsing notification: $json');
      print('Error details: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'type': type,
    };
  }

  NotificationItem copyWith({
    int? id,
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isRead,
    String? type,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
} 