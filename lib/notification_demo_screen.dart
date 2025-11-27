import 'package:flutter/material.dart';
import 'package:smartui_components/notification_services/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({super.key});

  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  String? fcmToken = "";

  @override
  void initState() {
    super.initState();
    NotificationHandler().init().then((_) {
      setState(() {
        fcmToken = NotificationHandler.fcmToken;
      });
      debugPrint("Fetched FCM Token: $fcmToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification SDK Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SelectableText(
              fcmToken ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NotificationHandler().showNotification(
                  RemoteMessage(
                    notification: RemoteNotification(
                        title: "Test Notification",
                        body: "This notification is from Flutter locally"
                    ),
                  ),
                );
              },
              child: const Text("Show Local Test Notification"),
            )
          ],
        ),
      ),
    );
  }
}
