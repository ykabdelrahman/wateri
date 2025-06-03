import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  static tz.TZDateTime nextInstanceOfTime(int minutes) {
    final now = tz.TZDateTime.now(tz.local);
    return now.add(Duration(minutes: minutes));
  }
}
