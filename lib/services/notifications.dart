import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/models/notificationModel.dart';

class NotificationService {
  static Future<List<Notification>> fetchNotifications() async {
    final response = await http.get(Uri.parse('https://example.com/api/notifications'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Notification.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}