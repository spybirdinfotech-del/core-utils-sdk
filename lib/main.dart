import 'package:corekit_sdk/time_picker_demo_screen.dart';
import 'package:smartui_components/custom_widget/appbar_view/custom_app_bar_theme.dart';
import 'package:smartui_components/custom_widget/text_field_view/custom_text_field_theme.dart';
import 'package:smartui_components/custom_widget/date_picker_view/custom_date_picker_theme.dart';
import 'package:smartui_components/custom_widget/date_picker_view/date_picker_theme_config.dart';
import 'package:smartui_components/custom_widget/time_picker_view/custom_time_picker_theme.dart';
import 'package:smartui_components/custom_widget/time_picker_view/time_picker_theme_config.dart';
import 'package:smartui_components/notification_services/notification_handler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartui_components/snackbar_handle/snackbar_handler.dart';
import 'package:smartui_components/custom_widget/appbar_view/app_bar_theme_config.dart';
import 'package:smartui_components/custom_widget/text_field_view/text_field_theme_config.dart';
import 'package:smartui_components/custom_widget/drop_down_view/custom_drop_down_theme.dart';
import 'package:smartui_components/custom_widget/drop_down_view/drop_down_theme_config.dart';
import 'package:corekit_sdk/shimmer_screen.dart';

import 'app_bar_demo_screen.dart' show AppBarDemoScreen;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationHandler().init();
  NotificationHandler().showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///initialize Button Theme
  /*  ButtonThemeConfig.setTheme(
    CustomButtonTheme(
      height: 48,
      width: double.infinity,
      buttonColor: Colors.blue,
      buttonTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );*/

  ///initialize Permission
  /*  PermissionSDKConfig.setTheme(
    const PermissionTheme(
      buttonTextColor: Colors.blue,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11,
        color: Colors.black,
      ),
      contentTextColor: Colors.black,
    ),
  );*/

  ///initialize Shared Preference
  // SharedPreferencesManager().init();

  ///initialize Api
  /*ApiConfig(onLogout: () {
    print('User session expired — please log in again');
  }, refreshTokenApi: "");*/

  ///initialize notification
  /*  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final notificationCubit = NotificationCubit();
  await notificationCubit.initialize(fcmTokenApi: "");*/

  ///Toast Theme
  /*  ToastConfig().init(
    backgroundColor: Colors.deepPurple,
    titleStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    messageStyle: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
    ),
    duration: const Duration(seconds: 3),
    alignment: Alignment.topCenter,
  );*/

  ///Snackbar theme config
  /* SnackbarThemeConfig.setTheme(
    const SnackbarTheme(
      successColor: Colors.green,
      errorColor: Colors.red,
      warningColor: Colors.orange,
      borderRadius: 16,
    ),
  );*/

  ///Appbar theme config
  AppBarThemeConfig.setTheme(
    const CustomAppBarTheme(
      bgColor: Colors.white,
      titleTextColor: Colors.deepPurple,
      fontFamily: "Poppins",
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );

  ///TextField Theme
  TextFieldThemeConfig.setTheme(
    const CustomTextFieldTheme(
      fontFamily: "Poppins",
      cursorColor: Colors.deepPurple,
      cursorHeight: 22,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),

      // Border Theme
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      enableBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
      ),
      focusBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
    ),
  );

  ///Dropdown Theme
  DropDownThemeConfig.setTheme(
    const CustomDropDownTheme(
      boxRadius: BorderRadius.all(Radius.circular(12)),
      dropDownBoxColor: Colors.white,
      dropDownBoxBorderColor: Colors.grey,
      labelTextStyle: TextStyle(fontSize: 15, color: Colors.blue),
      menuTextStyle: TextStyle(fontSize: 16),
      selectedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      menuItemBoxColor: Colors.white,
      menuItemBoxRadius: BorderRadius.all(Radius.circular(10)),
      menuItemBoxBorderColor: Colors.grey,
      themeColor: Colors.deepPurple, // for search icon / tick color
    ),
  );

  ///Date Picker Theme
  DatePickerThemeConfig.setTheme(
    CustomDatePickerTheme(
      backgroundColor: Colors.white,
      headerBackgroundColor: Colors.deepPurple,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      headerHelpStyle: const TextStyle(color: Colors.white70, fontSize: 14),
      weekdayStyle: const TextStyle(fontSize: 13, color: Colors.grey),
      dayStyle: const TextStyle(fontSize: 15, color: Colors.black87),
      dayForegroundColor: WidgetStatePropertyAll(Colors.black87),
      dayBackgroundColor: WidgetStatePropertyAll(Colors.white),
      todayForegroundColor: WidgetStatePropertyAll(Colors.white),
      todayBackgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
      todayBorder: const BorderSide(color: Colors.deepPurple, width: 2),
      rangePickerHeaderBackgroundColor: Colors.deepPurple,
      rangePickerHeaderForegroundColor: Colors.white,
      rangeSelectionBackgroundColor: Colors.deepPurple.withValues(alpha: 0.2),
      cancelButtonStyle: TextButton.styleFrom(foregroundColor: Colors.red),
      confirmButtonStyle: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
      dialogShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      radius: BorderRadius.circular(12),
      headerColor: Colors.deepPurple,
      dateTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
      headerTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
    ),
  );

  ///Time Picker Theme
  TimePickerThemeConfig.setTheme(
    CustomTimePickerTheme(
      backgroundColor: Colors.white,
      dialBackgroundColor: Colors.purple.shade100,
      dialTextColor: Colors.black,
      dialHandColor: Colors.purple.shade50,
      hourMinuteColor: Colors.deepPurple.shade50,
      hourMinuteTextColor: Colors.black,
      primaryButtonColor: Colors.deepPurple,
      buttonTextColor: Colors.white,
      dayPeriodColor: Colors.deepPurple.shade50,
      dayPeriodTextColor: Colors.black,
      dialogShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission Test',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      builder: (context, child) {
        return SnackbarHandler.setup(child: child ?? const SizedBox());
      },
      // home: const SimpleSnackbarScreen(), //Snackbar & Toast
      // home: const SimpleDialogScreen(), //Alert Dialog
      // home: const NotificationDemoScreen(), //notification
      // home: const ApiDataScreen(), //Api
      // home: const SharedPrefDemoScreen(), //Shared Pref
      // home: const DemoListScreen(), //List View
      // home: const CameraScreen(), //Permission
      // home: const FilePickerScreen(),
      // home: const ImagePickerScreen(),
      // home: AppBarDemoScreen(), //appbar, textfield, button widget
      // home: DatePickerScreen(),
      home: TimePickerDemoScreen(),
      // home: GridViewDemoScreen(),
      // home: ShimmerScreen(),
    );
  }
}