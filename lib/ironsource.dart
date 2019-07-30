import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ironsource/Ironsource_consts.dart';
export 'banner.dart';

class Ironsource {
  static const MethodChannel _channel =  MethodChannel("com.karnadi.ironsource");
  static  IronSourceListener _listener;

  static IronSourceListener getListener() {
    return _listener;
  }
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> initialize({final String appKey, IronSourceListener listener}) async {
    _listener=listener;
//    _channel.setMethodCallHandler(_listener._handle);
    await _channel.invokeMethod('initialize', {'appKey': appKey});
  }

  static void setListener(IronSourceListener listener) {
    _listener=listener;
    _channel.setMethodCallHandler(_listener._handle);
  }

  static Future<Null> loadInterstitial() async {
    await _channel.invokeMethod('loadInterstitial');
  }

  static Future<Null> showInterstitial() async {
    await _channel.invokeMethod('showInterstitial');
  }

  static Future<Null> showRewardedVideol() async {
    await _channel.invokeMethod('showRewardedVideo');
  }

  static Future<Null> showOfferwall() async {
    await _channel.invokeMethod('showOfferwall');
  }

  static Future<bool> isInterstitialReady() async {
    return await _channel.invokeMethod('isInterstitialReady');
  }

  static Future<bool> isRewardedVideoAvailable() async {
    return await _channel.invokeMethod('isRewardedVideoAvailable');
  }

  static Future<bool> isOfferwallAvailable() async {
    return await _channel.invokeMethod('isOfferwallAvailable');
  }

  static Future<Null> setListenner() async {

  }
}


abstract class IronSourceListener {
  Future<Null> _handle(MethodCall methodCall) async {
//    if (methodCall.method == IronSourceConst.ON_BANNER_AD_CLICKED)
//      onBannerAdClicked();
//    else if(methodCall.method == IronSourceConst.ON_BANNER_AD_LEFT_APPLICATION)
//      onBannerAdLeftApplication();
//    else if(methodCall.method == IronSourceConst.ON_BANNER_AD_LOAD_FAILED)
//      onBannerAdLoadFailed(methodCall.arguments["error"]);
//    else if(methodCall.method == IronSourceConst.ON_BANNER_AD_LOADED)
//      onBannerAdLoaded();
//    else if(methodCall.method == IronSourceConst.ON_BANNER_AD_sCREEN_DISMISSED)
//      onBannerAdScreenDismissed();
//    else if(methodCall.method == IronSourceConst.ON_BANNER_AD_SCREEN_PRESENTED)
//      onBannerAdScreenPresented();
//    Rewarded
   if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_CLICKED)
    onRewardedVideoAdClicked(methodCall.arguments["placement"]);
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_CLOSED)
    onRewardedVideoAdClosed();
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_ENDED)
    onRewardedVideoAdEnded();
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_OPENED)
    onRewardedVideoAdOpened();
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_REWARDED)
    onRewardedVideoAdRewarded(methodCall.arguments["placement"]);
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_SHOW_FAILED)
    onRewardedVideoAdShowFailed(methodCall.arguments["error"]);
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AVAILABILITY_CHANGED)
    onRewardedVideoAvailabilityChanged(methodCall.arguments["available"]);
    else if(methodCall.method == IronSourceConst.ON_REWARDED_VIDEO_AD_STARTED)
    onRewardedVideoAdStarted();
// Offerwall
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_AD_CREDITED)
    onOfferwallAdCredited(methodCall.arguments["credit"]);
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_AVAILABLE)
    onOfferwallAvailable(methodCall.arguments["available"]);
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_CLOSED)
      onOfferwallClosed();
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_CREDITS_FAILED)
      onGetOfferwallCreditsFailed(methodCall.arguments["error"]);
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_OPENED)
      onOfferwallClosed();
    else if(methodCall.method == IronSourceConst.ON_OFFERWALL_SHOW_FAILED)
      onOfferwallShowFailed(methodCall.arguments["error"]);
//    interstitial
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_CLICKED)
    onInterstitialAdClicked();
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_CLOSED)
    onInterstitialAdClosed();
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_OPENED)
    onInterstitialAdOpened();
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_READY)
    onInterstitialAdReady();
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_SHOW_SUCCEEDED)
    onInterstitialAdShowSucceeded();
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_LOAD_FAILED)
    onInterstitialAdLoadFailed(methodCall.arguments['error']);
  else if(methodCall.method == IronSourceConst.ON_INTERSTITIAL_AD_SHOW_FAILED)
    onInterstitialAdShowFailed(methodCall.arguments['error']);


  }

  //  Rewarded video
  void onRewardedVideoAdOpened();

  void onRewardedVideoAdClosed();

  void onRewardedVideoAvailabilityChanged(bool available);

  void onRewardedVideoAdStarted();

  void onRewardedVideoAdEnded();

  void onRewardedVideoAdRewarded(Map<dynamic, dynamic> placement);

  void onRewardedVideoAdShowFailed(Map<String, dynamic> error);

  void onRewardedVideoAdClicked(Map<dynamic, dynamic> placement);

  // Offer wall
  void onOfferwallAvailable(bool available);

  void onOfferwallOpened();

  void onOfferwallShowFailed(Map<String, dynamic> error);

  void onOfferwallAdCredited(Map<String, dynamic> reward);

  void onGetOfferwallCreditsFailed(Map<String, dynamic> error);

  void onOfferwallClosed();

  // Interstitial
  void onInterstitialAdClicked();

  void onInterstitialAdReady();

  void onInterstitialAdLoadFailed(Map<String, dynamic> error);

  void onInterstitialAdOpened();

  void onInterstitialAdClosed();

  void onInterstitialAdShowSucceeded();

  void onInterstitialAdShowFailed(Map<String, dynamic> error);

//  Banner
//  void onBannerAdLeftApplication();
//
//  void onBannerAdScreenDismissed();
//
//  void onBannerAdScreenPresented();
//
//  void onBannerAdClicked();
//
//  void onBannerAdLoaded();
//
//  void onBannerAdLoadFailed(Map<String, dynamic> error);

}
