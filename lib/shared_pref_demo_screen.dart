import 'package:smartui_components/shared_pref/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SharedPrefDemoScreen extends StatefulWidget {
  const SharedPrefDemoScreen({super.key});

  @override
  State<SharedPrefDemoScreen> createState() => _SharedPrefDemoScreenState();
}

class _SharedPrefDemoScreenState extends State<SharedPrefDemoScreen> {
  final SharedPreferencesService _prefService = SharedPreferencesService();

  String _token = "No token";

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String savedToken = await _prefService.mGetUserToken();
    setState(() {
      _token = savedToken.isNotEmpty ? savedToken : "No token";
      if (kDebugMode) {
        print("Load Token: $_token");
      }
    });
  }

  Future<void> _saveToken() async {
    await _prefService.mSaveUserToken("abc123");
    _loadToken();
  }

  Future<void> _clearData() async {
    await _prefService.mClearSharedPreference();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Saved Token: $_token",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center),

            const SizedBox(height: 30),

            ElevatedButton(
                onPressed: _saveToken,
                child: const Text("Save Token")
            ),

            ElevatedButton(
                onPressed: _loadToken,
                child: const Text("Get Token")
            ),

            ElevatedButton(
                onPressed: _clearData,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Clear SharedPreference")
            ),
          ],
        ),
      ),
    );
  }
}
