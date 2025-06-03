part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationScheduled extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}
