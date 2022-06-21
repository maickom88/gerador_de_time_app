import 'dart:convert';

class NotificationEntity {
  final String guid;
  final String title;
  final String description;
  final String? navigateTo;
  final bool isRead;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  NotificationEntity({
    required this.guid,
    required this.title,
    required this.description,
    this.navigateTo,
    required this.isRead,
    this.data,
    required this.createdAt,
  });

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      guid: map['guid'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      navigateTo: map['navigateTo'],
      isRead: map['isRead'] ?? false,
      data: Map<String, dynamic>.from(map['data']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  factory NotificationEntity.fromJson(String source) =>
      NotificationEntity.fromMap(json.decode(source));
}
