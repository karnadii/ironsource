import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ironsource/Ironsource_consts.dart';
export 'banner.dart';

class IronSource {
  static const MethodChannel _channel = MethodChannel("com.karnadi.ironsource");
  static IronSourceListener _listener;
  static IronSourceListener getListener() {
    return _listener;
  }

  static Future<Null> initialize(
      {final String appKey, final IronSourceListener listener}) async {
    _listener = listener;
    _channel.setMethodCallHandler(_listener._handle);
    await _channel.invokeMethod('initialize', {'appKey': appKey});
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



}

abstract class IronSourceListener {
  Future<Null> _handle(MethodCall call) async {
//    Rewarded
    if (call.method == ON_REWARDED_VIDEO_AD_CLICKED)
      onRewardedVideoAdClicked(call.arguments);
    else if (call.method == ON_REWARDED_VIDEO_AD_CLOSED)
      onRewardedVideoAdClosed();
    else if (call.method == ON_REWARDED_VIDEO_AD_ENDED)
      onRewardedVideoAdEnded();
    else if (call.method == ON_REWARDED_VIDEO_AD_OPENED)
      onRewardedVideoAdOpened();
    else if (call.method == ON_REWARDED_VIDEO_AD_REWARDED)
      onRewardedVideoAdRewarded(call.arguments);
    else if (call.method == ON_REWARDED_VIDEO_AD_SHOW_FAILED)
      onRewardedVideoAdShowFailed(call.arguments);
    else if (call.method == ON_REWARDED_VIDEO_AVAILABILITY_CHANGED)
      onRewardedVideoAvailabilityChanged(call.arguments);
    else if (call.method == ON_REWARDED_VIDEO_AD_STARTED)
      onRewardedVideoAdStarted();
// Offerwall
    else if (call.method == ON_OFFERWALL_AD_CREDITED)
      onOfferwallAdCredited(call.arguments);
    else if (call.method == ON_OFFERWALL_AVAILABLE)
      onOfferwallAvailable(call.arguments);
    else if (call.method == ON_OFFERWALL_CLOSED)
      onOfferwallClosed();
    else if (call.method == ON_OFFERWALL_CREDITS_FAILED)
      onGetOfferwallCreditsFailed(call.arguments);
    else if (call.method == ON_OFFERWALL_OPENED)
      onOfferwallOpened();
    else if (call.method == ON_OFFERWALL_SHOW_FAILED)
      onOfferwallShowFailed(call.arguments);
//    interstitial
    else if (call.method == ON_INTERSTITIAL_AD_CLICKED)
      onInterstitialAdClicked();
    else if (call.method == ON_INTERSTITIAL_AD_CLOSED)
      onInterstitialAdClosed();
    else if (call.method == ON_INTERSTITIAL_AD_OPENED)
      onInterstitialAdOpened();
    else if (call.method == ON_INTERSTITIAL_AD_READY)
      onInterstitialAdReady();
    else if (call.method == ON_INTERSTITIAL_AD_SHOW_SUCCEEDED)
      onInterstitialAdShowSucceeded();
    else if (call.method == ON_INTERSTITIAL_AD_LOAD_FAILED)
      onInterstitialAdLoadFailed(call.arguments);
    else if (call.method == ON_INTERSTITIAL_AD_SHOW_FAILED)
      onInterstitialAdShowFailed(call.arguments);
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
}


