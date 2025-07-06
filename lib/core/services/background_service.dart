import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

const String taskName = "waterReminderTask";

class BackgroundService {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  }

  static void scheduleReminder(int interval) {
    Workmanager().cancelAll();
    Workmanager().registerPeriodicTask(
      "wateri_id_$interval",
      taskName,
      frequency: Duration(minutes: interval),
    );
  }

  static void cancelReminders() {
    Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationService.showWaterReminder();
    return Future.value(true);
  });
}
