class WaterData {
  final bool isReminderActive;
  final int selectedMinutes;
  final int waterIntake;
  final int dailyGoal;

  WaterData({
    required this.isReminderActive,
    required this.selectedMinutes,
    required this.waterIntake,
    required this.dailyGoal,
  });

  WaterData copyWith({
    bool? isReminderActive,
    int? selectedMinutes,
    int? waterIntake,
    int? dailyGoal,
  }) {
    return WaterData(
      isReminderActive: isReminderActive ?? this.isReminderActive,
      selectedMinutes: selectedMinutes ?? this.selectedMinutes,
      waterIntake: waterIntake ?? this.waterIntake,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }

  double get progress => waterIntake / dailyGoal;
  int get progressPercentage => (progress * 100).round();
}
