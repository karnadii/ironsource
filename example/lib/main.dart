import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
    Ironsource.initialize(appKey:appKey,listener: this);
  }

  loadInterstitial() {
    Ironsource.loadInterstitial();
  }

  showInterstitial() async{
   if(await Ironsource.isInterstitialReady()){
     Ironsource.showInterstitial();
   }else{
     print("Interstial is not ready. use 'Ironsource.loadInterstial' before showing it");
   }
  }

  showOfferwall() async {
    if (await Ironsource.isOfferwallAvailable()) {
      Ironsource.showOfferwall();
    } else {
      print("Offerwall not available");
    }
  }

  showRewardedVideo() async {
    if (await Ironsource.isRewardedVideoAvailable()) {
      Ironsource.showRewardedVideol();
    } else {
      print("RewardedVideo not available");
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
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
//            ISBanner()
          ],
        ),
      ),
    );
  }

  @override
  void onGetOfferwallCreditsFailed(Map<String, dynamic> error) {
    // TODO: implement onGetOfferwallCreditsFailed
  }

  @override
  void onInterstitialAdClicked() {
    // TODO: implement onInterstitialAdClicked
  }

  @override
  void onInterstitialAdClosed() {
    // TODO: implement onInterstitialAdClosed
  }

  @override
  void onInterstitialAdLoadFailed(Map<String, dynamic> error) {
    // TODO: implement onInterstitialAdLoadFailed
  }

  @override
  void onInterstitialAdOpened() {
    // TODO: implement onInterstitialAdOpened
    print("dsd");
  }

  @override
  void onInterstitialAdReady() {
    // TODO: implement onInterstitialAdReady
  }

  @override
  void onInterstitialAdShowFailed(Map<String, dynamic> error) {
    // TODO: implement onInterstitialAdShowFailed
  }

  @override
  void onInterstitialAdShowSucceeded() {
    // TODO: implement onInterstitialAdShowSucceeded
  }

  @override
  void onOfferwallAdCredited(Map<String, dynamic> reward) {
    // TODO: implement onOfferwallAdCredited
  }

  @override
  void onOfferwallAvailable(bool available) {
    // TODO: implement onOfferwallAvailable
  }

  @override
  void onOfferwallClosed() {
    // TODO: implement onOfferwallClosed
  }

  @override
  void onOfferwallOpened() {
    // TODO: implement onOfferwallOpened
  }

  @override
  void onOfferwallShowFailed(Map<String, dynamic> error) {
    // TODO: implement onOfferwallShowFailed
  }

  @override
  void onRewardedVideoAdClicked(Map placement) {
    // TODO: implement onRewardedVideoAdClicked
  }

  @override
  void onRewardedVideoAdClosed() {
    // TODO: implement onRewardedVideoAdClosed
  }

  @override
  void onRewardedVideoAdEnded() {
    // TODO: implement onRewardedVideoAdEnded
  }

  @override
  void onRewardedVideoAdOpened() {
    // TODO: implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdRewarded(Map placement) {
    // TODO: implement onRewardedVideoAdRewarded
  }

  @override
  void onRewardedVideoAdShowFailed(Map<String, dynamic > error) {
    // TODO: implement onRewardedVideoAdShowFailed
  }

  @override
  void onRewardedVideoAdStarted() {
    // TODO: implement onRewardedVideoAdStarted
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    // TODO: implement onRewardedVideoAvailabilityChanged
  }
}
