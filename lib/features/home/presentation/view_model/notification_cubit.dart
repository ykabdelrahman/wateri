import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/notifi_repo.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notifiRepo;

  NotificationCubit(this.notifiRepo) : super(NotificationInitial());

  Future<void> schedulePeriodicNotifications() async {
    try {
      await notifiRepo.scheduleNotifications();
      emit(NotificationScheduled());
    } catch (e) {
      log(e.toString());
      emit(NotificationError(e.toString()));
    }
  }
}
