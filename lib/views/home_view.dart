import 'package:flutter/material.dart';
import 'dart:async';
import '../core/models/water_data.dart';
import '../core/services/background_service.dart';
import '../core/services/notification_service.dart';
import '../core/services/storage_service.dart';
import '../core/utils/constants.dart';
import 'widgets/add_water_button.dart';
import 'widgets/progress_card.dart';
import 'widgets/reminder_settings_card.dart';
import 'widgets/reset_button.dart';
import 'widgets/show_permission_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WaterData _waterData = WaterData(
    isReminderActive: false,
    selectedMinutes: AppConstants.defaultReminderMinutes,
    waterIntake: 0,
    dailyGoal: AppConstants.defaultDailyGoal,
  );

  Timer? _reminderTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _reminderTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    final data = await StorageService.loadWaterData();
    setState(() {
      _waterData = data;
    });

    if (_waterData.isReminderActive) {
      _startReminder();
    }
  }

  Future<void> _saveData() async {
    await StorageService.saveWaterData(_waterData);
  }

  void _startReminder() {
    BackgroundService.scheduleReminder(_waterData.selectedMinutes);
  }

  void _stopReminder() {
    BackgroundService.cancelReminders();
  }

  void _toggleReminder() async {
    // Check permissions before enabling reminders
    if (!_waterData.isReminderActive) {
      final hasPermission = await NotificationService.areNotificationsEnabled();

      if (!hasPermission) {
        final granted = await NotificationService.requestPermissions();

        if (!granted) {
          // Show dialog explaining why permissions are needed
          if (!mounted) return;
          showPermissionDialog(context);
          return;
        }
      }
    }

    setState(() {
      _waterData = _waterData.copyWith(
        isReminderActive: !_waterData.isReminderActive,
      );
    });

    if (_waterData.isReminderActive) {
      _startReminder();
    } else {
      _stopReminder();
    }
    _saveData();
  }

  void _addWaterIntake() {
    setState(() {
      _waterData = _waterData.copyWith(waterIntake: _waterData.waterIntake + 1);
    });
    _saveData();
  }

  void _resetDailyIntake() {
    setState(() {
      _waterData = _waterData.copyWith(waterIntake: 0);
    });
    _saveData();
  }

  void _updateReminderMinutes(int minutes) {
    setState(() {
      _waterData = _waterData.copyWith(selectedMinutes: minutes);
    });
    _saveData();

    if (_waterData.isReminderActive) {
      _startReminder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProgressCard(waterData: _waterData),
              const SizedBox(height: 20),
              AddWaterButton(onTap: _addWaterIntake),
              const SizedBox(height: 20),
              ReminderSettingsCard(
                waterData: _waterData,
                onToggleReminder: _toggleReminder,
                onUpdateMinutes: _updateReminderMinutes,
              ),
              const SizedBox(height: 20),
              ResetButton(onTap: () => _resetDailyIntake()),
            ],
          ),
        ),
      ),
    );
  }
}
