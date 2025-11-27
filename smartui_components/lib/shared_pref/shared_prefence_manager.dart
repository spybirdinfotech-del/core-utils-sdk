import 'dart:convert';
import 'package:smartui_components/shared_pref/shared_pref_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/util/common.dart';


class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();
  static SharedPreferences? preferences;

  // Private constructor
  SharedPreferencesManager._internal();

  // Singleton instance
  factory SharedPreferencesManager() {
    return _instance;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setLoginStatus() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setBool(SharedPrefKey.isLogin, true);
  }

  Future<bool> getLoginStatus() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getBool(SharedPrefKey.isLogin) ?? false;
  }

  Future<void> setOnBoardingStatus() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setBool(SharedPrefKey.isOnBoardingDone, true);
  }

  Future<bool> getOnBoardingStatus() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getBool(SharedPrefKey.isOnBoardingDone) ?? false;
  }

  Future<void> setUserToken(String token) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString(SharedPrefKey.token, token);
  }

  Future<String> getUserToken() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(SharedPrefKey.token) ?? '';
  }

  Future<void> mSetResponseData(String key,dynamic consumeData) async {
    try {
      preferences = await SharedPreferences.getInstance();
      var mEncodedConsumerData = jsonEncode(consumeData.toJson());
      preferences!.setString(key, mEncodedConsumerData);
    } catch (e) {
      Common().printLog('mSetResponseDataError', e.toString());
    }
  }

  Future<dynamic> mGetResponseData(String key) async {
    preferences = await SharedPreferences.getInstance();
    var mResponseData = preferences!.getString(key);
    if(mResponseData!=null && mResponseData.isNotEmpty) {
      return jsonDecode(mResponseData);
      // return ConsumerSingUpResponseData.fromJson(jsonDecode(mConsumerData));
    }
    // return null;
  }

  Future<void> setBoolValue(String key,bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setBool(key, value);
  }

  Future<bool> getBoolValue(String key) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getBool(key) ?? false;
  }

  Future<void> setStringValue(String key,String value) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getString(key) ?? '';
  }

  Future<void> setDoubleValue(String key,double value) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setDouble(key, value);
  }

  Future<double> getDoubleValue(String key) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getDouble(key) ?? 0;
  }

  Future<void> setIntValue(String key,int value) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setInt(key, value);
  }


  Future<int> getIntValue(String key) async {
    preferences = await SharedPreferences.getInstance();
    return preferences!.getInt(key) ?? 0;
  }

  Future<void> mClearSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.clear();
  }

  // Future<void> mSaveFeedData(List<TopAdsResponseData> topAdsResponseData,String sharedPrefKey) async {
  //   try {
  //     preferences = await SharedPreferences.getInstance();
  //     var mEncodedFeedData = jsonEncode(topAdsResponseData.toList());
  //     preferences.setString(sharedPrefKey, mEncodedFeedData);
  //   } catch (e) {
  //     Common().printLog('FeedDataSaveError', e.toString());
  //   }
  // }

  // Future<List<TopAdsResponseData>> mGetFeedData(String sharedPrefKey) async {
  //   preferences = await SharedPreferences.getInstance();
  //   var mFeedData = preferences.getString(sharedPrefKey);
  //   if(mFeedData!=null && mFeedData.isNotEmpty) {
  //     List<dynamic> mFeedDataList = jsonDecode(mFeedData);
  //     return mFeedDataList.map((data) => TopAdsResponseData.fromJson(data as Map<String, dynamic>)).toList();
  //   }
  //   return [];
  // }
}
