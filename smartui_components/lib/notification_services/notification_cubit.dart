import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_state.dart';
import 'notification_handler.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationHandler _notificationHandler = NotificationHandler();

  NotificationCubit() : super(NotificationInitial());

  Future<void> initialize({String? fcmTokenApi}) async {
    await Firebase.initializeApp();
    emit(NotificationLoading());
    await _notificationHandler.init();
    // await _notificationHandler.getFCMToken(fcmTokenApi);

    emit(NotificationLoaded(NotificationHandler.fcmToken));
  }
}
