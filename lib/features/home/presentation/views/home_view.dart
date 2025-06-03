import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/notification_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💧 wateri')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationScheduled) {
                  return const Text(
                    'Reminders active!',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  );
                }
                return const Text(
                  'Tap to start reminders',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<NotificationCubit>()
                    .schedulePeriodicNotifications();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Water reminders activated!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Start Reminders'),
            ),
          ],
        ),
      ),
    );
  }
}
