import 'dart:convert';
import 'dart:developer';

import 'package:smartui_components/notification_services/google_fcm_response.dart';
import 'package:smartui_components/remote/api/api_cubit.dart';
import 'package:smartui_components/remote/api/base_response.dart';
import 'package:smartui_components/remote/util/common.dart';
import 'package:smartui_components/remote/util/string_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../remote/api/api_constant.dart';

class NotificationHandler {
  static String? fcmToken = '';
  final ApiCubit _apiServices = ApiCubit();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    ApiConstant.highImportanceChannel,
    ApiConstant.highImportanceNotification,
    description: ApiConstant.notificationDescription,
    importance: Importance.high,
  );
  GoogleFCMResponse? googleFCMApiKey;

  Future<void> init() async {
    // Notification permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // For Foreground Notifications (Android + iOS)
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


    // Create Notification Channel
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // FCM token
    fcmToken = await _messaging.getToken();
    log("FCM Token -------------------- ${fcmToken}");

    //Background message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log("App launched via notification: ${message.messageId}");
      }
    });

    // foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // terminated message
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("Notification Clicked!");
    });

    // Local notification
    AndroidInitializationSettings androidInit = AndroidInitializationSettings(ApiConstant.notificationIcon);
    InitializationSettings initSettings =
        InitializationSettings(android: androidInit, iOS: const DarwinInitializationSettings());
    await _localNotificationsPlugin.initialize(initSettings);
  }

  void showNotification(RemoteMessage message) {
    String title = message.notification?.title ?? StringFile.notification;
    String body = message.notification?.body ?? '';

    BigTextStyleInformation bigText = BigTextStyleInformation(
      body,
      contentTitle: title,
      htmlFormatBigText: true,
    );

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigText,
      icon: ApiConstant.notificationIcon,
    );

    NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformDetails,
      payload: jsonEncode(message.data)
    );
  }

  Future<void> getFCMToken(String? fcmTokenApi) async {
    if (fcmToken != null) {
      String? message = await registerTokenWithServer(fcmTokenApi!);
      if (message != null) {
        Common().printLog("Push NotifyMessages--------------", message.toString());
      }
    }
  }

  Future<String?> registerTokenWithServer(String fcmTokenApi) async {
    var mPushNotifyResponse = await _apiServices.putApi(fcmTokenApi,{}); //fcm token Api
    if (mPushNotifyResponse != null) {
      BaseResponse mNotificationDataResponse = BaseResponse.fromJson(mPushNotifyResponse);
      if (mNotificationDataResponse.status == ApiConstant.successStatusCode) {
        return mNotificationDataResponse.message;
      }
    }
    return null;
  }


  /*Future<GoogleFCMResponse?> initializeSecondFirebase({String? dataBaseTableName}) async {
    var mGoogleFCMKeyResponse = await _apiServices.getApi(ApiEndPoint.googleFCMKey);
    if (mGoogleFCMKeyResponse != null) {
      BaseResponse<GoogleFCMResponse> mFirebaseFCMDataResponse = BaseResponse.fromJson(
        mGoogleFCMKeyResponse,
        (data) => GoogleFCMResponse.fromJson(data),
      );
      if (mFirebaseFCMDataResponse.mIsDataNotNull()) {
        if (dataBaseTableName != null && dataBaseTableName.isNotEmpty) {
          await DatabaseFile.instanceDatabaseFile
              .insertGoogleFlutterKeyInfo(mFirebaseFCMDataResponse.data!, dataBaseTableName);
        }
        return mFirebaseFCMDataResponse.data!;
      }
    }
    return null;
  }

  Future<void> mGetSecondFireBase() async {
    googleFCMApiKey = (await DatabaseFile.instanceDatabaseFile.getTblGoogleFCMKeyInfo(DataBaseTableFile.googleFCMKey))!;
    if (googleFCMApiKey == null || googleFCMApiKey!.apiKey == null || googleFCMApiKey!.applicationId == null || googleFCMApiKey!.projectId == null) {
      googleFCMApiKey = (await initializeSecondFirebase(dataBaseTableName: DataBaseTableFile.googleFCMKey))!;
    }

    if (googleFCMApiKey != null &&
        googleFCMApiKey!.apiKey != null &&
        googleFCMApiKey!.applicationId != null &&
        googleFCMApiKey!.projectId != null) {
      final List<FirebaseApp> apps = Firebase.apps;
      final bool alreadyInitialized = apps.any((app) => app.name == ApiConstant.secondFirebase);

      if (!alreadyInitialized) {
        await mInitSecondFirebase();
      }
    }
  }

  Future<void> mInitSecondFirebase() async {
    await Firebase.initializeApp(
      name: ApiConstant.secondFirebase,
      options: FirebaseOptions(
        apiKey: googleFCMApiKey!.apiKey!,
        appId: googleFCMApiKey!.applicationId!,
        messagingSenderId: googleFCMApiKey!.applicationId!,
        projectId: googleFCMApiKey!.projectId!,
      ),
    );
  }*/
}
