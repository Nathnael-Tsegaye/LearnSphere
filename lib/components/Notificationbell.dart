import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/pages/NotificationPage.dart';
import 'package:test/providers/notificationprovider.dart';

class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationAsyncValue = ref.watch(notificationProvider);

    return notificationAsyncValue.when(
      data: (notifications) {
        return IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications, size: 33),
              if (notifications.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 3,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 13,
                      minHeight: 12,
                    ),
                    child: Text(
                      '${notifications.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            ).then((_) {
              ref.read(notificationProvider.notifier).clearNotifications();
            });
          },
        );
      },
      loading: () => IconButton(
        icon: Stack(
          children: [
            const Icon(Icons.notifications, size: 33),
            Positioned(
              right: 0,
              top: 3,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 13,
                  minHeight: 12,
                ),
                child: const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: null, // Disable the button while loading
      ),
      error: (error, stackTrace) => IconButton(
        icon: const Icon(Icons.notifications, size: 33),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen()),
          ).then((_) {
            ref.read(notificationProvider.notifier).clearNotifications();
          });
        },
      ),
    );
  }
}
