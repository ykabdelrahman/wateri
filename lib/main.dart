import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';
import 'core/services/notification_service.dart';
import 'core/services/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  tz.initializeTimeZones();
  await NotificationService.initialize();
  await BackgroundService.initialize();
  runApp(const MyApp());
}
