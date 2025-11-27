import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared_pref/shared_prefence_manager.dart';

class Common {

  final RegExp emailRegex = RegExp(
    r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
  );

  printLog(String title, String mLog) {
    if (kDebugMode) {
      log("-------------[ $title ]-------------> $mLog");
    }
  }

  //click on link
  Future<void> launchURL(String link) async {
    try {
      if (!await launchUrl(Uri.parse(link))) {
        throw Exception('Could not launch $link');
      }
    } catch (e) {
      log('Error launching URL: $e');
    }
  }

  //call features
  Future<void> launchPhoneUri(String mobileNumber) async {
    if (!await launchUrl(Uri(
      scheme: 'tel',
      path: mobileNumber,
    ))) {
      throw Exception('Could not launch Phone call');
    }
  }

  //click and display th address on map
  Future<void> launchAddress(
      {String? address = "", double? latitude, double? longitude}) async {
    try {
      double lat, long;
      if (latitude != null && longitude != null) {
        lat = latitude;
        long = longitude;
      } else {
        List<Location> locations = await locationFromAddress(address!);
        lat = locations.first.latitude;
        long = locations.first.longitude;
      }
      if (Platform.isAndroid) {
        if (!await launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long"))) {
          throw Exception('Could not launch');
        }
      } else {
        if (!await launchUrl(Uri.parse('comgooglemaps://?saddr=&daddr=$lat,$long&directionsmode=driving'))) {
          throw Exception('Could not launch');
        } else if (!await launchUrl(
            Uri.parse('https://maps.apple.com/?q=$lat,$long'))) {
          throw Exception('Could not launch');
        }
      }
    } catch (e) {
      await launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address!)}"));
    }
  }

  commonShimmer({required Widget child}) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(seconds: 1),
      enabled: true,
      loop: 0,
      child: child,
    );
  }

  Future<void> mLogOut()async{
    await SharedPreferencesManager().mClearSharedPreference();
    // await DatabaseFile.instanceDatabaseFile.databaseDelete();
    await SharedPreferencesManager().setOnBoardingStatus();
   //  if (Get.currentRoute != RouteName.signInScreen) {
   //    Get.offAllNamed(RouteName.signInScreen);
   //  }
  }


}
