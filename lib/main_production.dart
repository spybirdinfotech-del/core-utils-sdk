import 'package:flutter/material.dart';
import 'main.dart' as app;

Future<void> main() async {
  app.appEnv = "production";
  await app.main([]);
}