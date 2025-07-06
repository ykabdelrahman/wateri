import 'package:flutter/material.dart';
import '../../core/models/water_data.dart';
import '../../core/utils/constants.dart';

class ReminderSettingsCard extends StatelessWidget {
  final WaterData waterData;
  final VoidCallback onToggleReminder;
  final Function(int) onUpdateMinutes;

  const ReminderSettingsCard({
    super.key,
    required this.waterData,
    required this.onToggleReminder,
    required this.onUpdateMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReminderToggle(),
          const SizedBox(height: 16),
          _buildIntervalSelector(),
        ],
      ),
    );
  }

  Widget _buildReminderToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reminder',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: waterData.isReminderActive,
          onChanged: (value) => onToggleReminder(),
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildIntervalSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reminder Interval',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.reminderOptions.map((minutes) {
            final isSelected = minutes == waterData.selectedMinutes;
            return GestureDetector(
              onTap: () => onUpdateMinutes(minutes),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${minutes}min',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
