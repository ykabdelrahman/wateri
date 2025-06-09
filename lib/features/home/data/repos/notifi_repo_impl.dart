import '../../../../core/services/notification_service.dart';
import 'notifi_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationService notifiService;

  NotificationRepoImpl(this.notifiService);

  @override
  Future<void> scheduleNotifications() async {
    await notifiService.showNotification();
  }

  @override
  Future<void> cancelAllNotifications() async {
    await notifiService.cancelAllNotifications();
  }
}
