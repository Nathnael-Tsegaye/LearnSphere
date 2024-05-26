import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/notificationModel.dart';
import 'package:test/services/notifications.dart';

class NotificationNotifier extends StateNotifier<AsyncValue<List<Notification>>> {
  NotificationNotifier() : super(const AsyncValue.loading()) {
    fetchAndSetNotifications();
  }

  Future<void> fetchAndSetNotifications() async {
    try {
      final notifications = await NotificationService.fetchNotifications();
      state = AsyncValue.data(notifications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearNotifications() {
    state = const AsyncValue.data([]);
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, AsyncValue<List<Notification>>>((ref) {
  return NotificationNotifier();
});
