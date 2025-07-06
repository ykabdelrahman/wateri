import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);

    // Request permissions after initialization
    await requestPermissions();
    log('NotificationService initialized and permissions requested');
  }

  static Future<bool> requestPermissions() async {
    bool? result;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      result = await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      result = await androidImplementation?.requestNotificationsPermission();
    }

    return result ?? false;
  }

  static Future<bool> areNotificationsEnabled() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final bool? result = await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.checkPermissions()
          .then((permissions) => permissions!.isEnabled);
      return result ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      final bool? result = await androidImplementation
          ?.areNotificationsEnabled();
      return result ?? false;
    }

    return false;
  }

  static Future<void> showWaterReminder() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'water_channel',
          'Water Reminder',
          channelDescription: 'Notifies you to drink water',
          importance: Importance.high,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      0,
      '💧 Time to Hydrate!',
      'Don\'t forget to drink water!',
      notificationDetails,
    );
  }
}
