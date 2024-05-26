class Notification {
  final String message;
  final DateTime date;

  Notification({required this.message, required this.date});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }
}