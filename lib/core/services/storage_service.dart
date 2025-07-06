import 'package:shared_preferences/shared_preferences.dart';
import '../models/water_data.dart';
import '../utils/constants.dart';

class StorageService {
  static const String _reminderActiveKey = 'reminder_active';
  static const String _reminderMinutesKey = 'reminder_minutes';
  static const String _waterIntakeKey = 'water_intake';
  static const String _dailyGoalKey = 'daily_goal';

  static Future<WaterData> loadWaterData() async {
    final prefs = await SharedPreferences.getInstance();

    return WaterData(
      isReminderActive: prefs.getBool(_reminderActiveKey) ?? false,
      selectedMinutes:
          prefs.getInt(_reminderMinutesKey) ??
          AppConstants.defaultReminderMinutes,
      waterIntake: prefs.getInt(_waterIntakeKey) ?? 0,
      dailyGoal: prefs.getInt(_dailyGoalKey) ?? AppConstants.defaultDailyGoal,
    );
  }

  static Future<void> saveWaterData(WaterData data) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setBool(_reminderActiveKey, data.isReminderActive),
      prefs.setInt(_reminderMinutesKey, data.selectedMinutes),
      prefs.setInt(_waterIntakeKey, data.waterIntake),
      prefs.setInt(_dailyGoalKey, data.dailyGoal),
    ]);
  }
}
