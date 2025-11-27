import 'package:smartui_components/permission_services/permission_sdk.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCameraPermission();
    });
  }

  Future<void> _checkCameraPermission() async {
    bool granted = false;

    while (!granted && mounted) {
      await PermissionHandlerService.handle(
        permission: Permission.camera,
        context: context,
        onResult: (isGranted, message, {location}) {
          if (isGranted) {
            granted = true;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content  : Text("Camera permission granted!")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          }
        },
      );

      await Future.delayed(const Duration(milliseconds: 800));

      final status = await Permission.camera.status;
      if (status.isGranted) {
        granted = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Screen")),
      body: const Center(child: Text("Camera screen — permission handled automatically.")),
    );
  }
}
