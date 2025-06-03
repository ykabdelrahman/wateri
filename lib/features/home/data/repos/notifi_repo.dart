abstract class NotificationRepo {
  Future<void> scheduleNotifications();
  Future<void> cancelAllNotifications();
}
