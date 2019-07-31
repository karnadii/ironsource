import 'package:flutter/material.dart';

import 'package:ironsource/ironsource.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with IronSourceListener {
  final String appKey = "85460dcd";

  @override
  void initState() {
    super.initState();
//    addListener();
    init();
  }

  void init() async {
    await IronSource.initialize(appKey: appKey, listener: this);
  }

  loadInterstitial() {
    IronSource.loadInterstitial();
  }

  showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      IronSource.showInterstitial();
    } else {
      print(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }

  showOfferwall() async {
    if (await IronSource.isOfferwallAvailable()) {
      IronSource.showOfferwall();
    } else {
      print("Offerwall not available");
    }
  }

  showRewardedVideo() async {
    if (await IronSource.isRewardedVideoAvailable()) {
      IronSource.showRewardedVideol();
    } else {
      print("RewardedVideo not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ironsource ads demo'),
        ),
        body: Column(
          children: <Widget>[
            FlatButton(
              child: Text("laod interstitial"),
              onPressed: loadInterstitial,
            ),
            FlatButton(
              child: Text("show interstitial"),
              onPressed: showInterstitial,
            ),
            FlatButton(
              child: Text("show offerwall"),
              onPressed: showOfferwall,
            ),
            FlatButton(
              child: Text("show rewardedVideo"),
              onPressed: showRewardedVideo,
            ),
            IronSourceBannerAd(
              keepAlive: true,
              listener: BannerAdListener(),
            ),
            IronSourceBannerAd(
              keepAlive: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInterstitialAdClicked() {
    // TODO: implement onInterstitialAdClicked
    print("onInterstitialAdClicked");
  }

  @override
  void onInterstitialAdClosed() {
    // TODO: implement onInterstitialAdClosed
    print("onInterstitialAdClosed");
  }

  @override
  void onInterstitialAdLoadFailed(Map<String, dynamic> error) {
    // TODO: implement onInterstitialAdLoadFailed
    print("onInterstitialAdLoadFailed : $error");
  }

  @override
  void onInterstitialAdOpened() {
    print("onInterstitialAdOpened");

    // TODO: implement onInterstitialAdOpened
  }

  @override
  void onInterstitialAdReady() {
    print("onInterstitialAdReady");

    // TODO: implement onInterstitialAdReady
  }

  @override
  void onInterstitialAdShowFailed(Map<String, dynamic> error) {
    // TODO: implement onInterstitialAdShowFailed
    print("onInterstitialAdShowFailed : $error");
  }

  @override
  void onInterstitialAdShowSucceeded() {
    // TODO: implement onInterstitialAdShowSucceeded
    print("nInterstitialAdShowSucceeded");
  }

  @override
  void onGetOfferwallCreditsFailed(Map<String, dynamic> error) {
    // TODO: implement onGetOfferwallCreditsFailed
    print("onGetOfferwallCreditsFailed : $error");
  }

  @override
  void onOfferwallAdCredited(Map<String, dynamic> reward) {
    // TODO: implement onOfferwallAdCredited
    print("onOfferwallAdCredited : $reward");
  }

  @override
  void onOfferwallAvailable(bool available) {
    print("onOfferwallAvailable : $available");
    // TODO: implement onOfferwallAvailable
  }

  @override
  void onOfferwallClosed() {
    // TODO: implement onOfferwallClosed
    print("onOfferwallClosed");
  }

  @override
  void onOfferwallOpened() {
    print("onOfferwallOpened");
  }

  @override
  void onOfferwallShowFailed(Map<String, dynamic> error) {
    print("onOfferwallShowFailed $error");
  }

  @override
  void onRewardedVideoAdClicked(Map placement) {
    // TODO: implement onRewardedVideoAdClicked
    print("onRewardedVideoAdClicked");
  }

  @override
  void onRewardedVideoAdClosed() {
    print("onRewardedVideoAdClosed");

    // TODO: implement onRewardedVideoAdClosed
  }

  @override
  void onRewardedVideoAdEnded() {
    print("onRewardedVideoAdEnded");

    // TODO: implement onRewardedVideoAdEnded
  }

  @override
  void onRewardedVideoAdOpened() {
    print("onRewardedVideoAdOpened");

    // TODO: implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdRewarded(Map placement) {
    // TODO: implement onRewardedVideoAdRewarded
    print("onRewardedVideoAdRewarded: $placement");
  }

  @override
  void onRewardedVideoAdShowFailed(Map<String, dynamic> error) {
    // TODO: implement onRewardedVideoAdShowFailed
    print("onRewardedVideoAdShowFailed : $error");
  }

  @override
  void onRewardedVideoAdStarted() {
    print("onRewardedVideoAdStarted");
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    // TODO: implement onRewardedVideoAvailabilityChanged
    print("nRewardedVideoAvailabilityChanged : $available");
  }
}


class BannerAdListener extends IronSourceBannerListener{
  @override
  void onBannerAdClicked() {
    // TODO: implement onBannerAdClicked
    print("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    // TODO: implement onBannerAdLeftApplication
    print("onBannerAdLeftApplication");

  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    print("onBannerAdLoadFailed");

    // TODO: implement onBannerAdLoadFailed
  }

  @override
  void onBannerAdLoaded() {
    // TODO: implement onBannerAdLoaded
    print("onBannerAdLoaded");

  }

  @override
  void onBannerAdScreenDismissed() {
    // TODO: implement onBannerAdScreenDismissed
    print("onBannerAdScreenDismisse");

  }

  @override
  void onBannerAdScreenPresented() {
    // TODO: implement onBannerAdScreenPresented
    print("onBannerAdScreenPresented");

  }

}