
import 'package:smartui_components/shared_pref/shared_prefence_manager.dart';

class SharedPreferencesService {
  final _sharedPref = SharedPreferencesManager();

  Future<void> mSaveUserToken(String token) async {
    await _sharedPref.setUserToken(token);
  }

  Future<String> mGetUserToken() async {
    return await _sharedPref.getUserToken();
  }

  Future<void> mSetLoginStatus() async {
    await _sharedPref.setLoginStatus();
  }

  Future<void> mSetOnBoardingStatus() async {
    await _sharedPref.setOnBoardingStatus();
  }

  Future<dynamic> mGetResponse(String key) async {
    return await _sharedPref.mGetResponseData(key);
  }

  Future<bool> mGetLoginStatus() async {
    return await _sharedPref.getLoginStatus();
  }

  Future<bool> mGetOnBoardingStatus() async {
    return await _sharedPref.getOnBoardingStatus();
  }

  Future<void> mClearSharedPreference() async {
    await _sharedPref.mClearSharedPreference();
  }

  Future<void> mSaveResponse(String key,
      dynamic consumerSingUpResponseData) async {
    await _sharedPref.mSetResponseData(key,consumerSingUpResponseData);
  }

  // Future<void> mSaveFeedData(
  //     List<TopAdsResponseData> topAdsResponseData,String sharedPrefKey) async {
  //   await _sharedPref.mSaveFeedData(topAdsResponseData,sharedPrefKey);
  // }
  //
  // Future<List<TopAdsResponseData>> mGetFeedData(String sharedPrefKey) async {
  //   return await _sharedPref.mGetFeedData(sharedPrefKey);
  // }

}
