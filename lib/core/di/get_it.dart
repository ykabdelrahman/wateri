import 'package:get_it/get_it.dart';
import '../../features/home/data/repos/notifi_repo.dart';
import '../../features/home/data/repos/notifi_repo_impl.dart';
import '../services/notification_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(getIt<NotificationService>()),
  );
}
