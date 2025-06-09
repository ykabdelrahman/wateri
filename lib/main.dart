import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'core/di/get_it.dart';
import 'core/services/notification_service.dart';
import 'core/utils/app_bloc_observer.dart';
import 'features/home/data/repos/notifi_repo.dart';
import 'features/home/presentation/view_model/notification_cubit.dart';
import 'features/home/presentation/views/home_view.dart';

const backgroundTask = "waterReminderTask";
final NotificationService notificationService = NotificationService();

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await notificationService.showNotification();
    log("Background task executed: $task with input: $inputData");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await notificationService.initialize();

  await Workmanager().initialize(callbackDispatcher);

  await Workmanager().registerPeriodicTask(
    backgroundTask,
    backgroundTask,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.not_required),
  );

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wateri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => NotificationCubit(getIt<NotificationRepo>()),
        child: const HomeView(),
      ),
    );
  }
}
