import 'package:flutter/material.dart';

import 'package:ironsource/ironsource.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with IronSourceListener {
  final String appKey = "85460dcd";

  bool rewardeVideoAvailable = false,
      offerwallAvailable = false,
      showBanner = false,
      interstitialReady = false;
  @override
  void initState() {
    super.initState();
//    addListener();
    init();
  }

  void init() async {
    await IronSource.initialize(appKey: appKey, listener: this);
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    offerwallAvailable = await IronSource.isOfferwallAvailable();
    setState(() {});
  }

  void loadInterstitial() {
    IronSource.loadInterstitial();
  }

  void showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      IronSource.showInterstitial();
    } else {
      print(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }

  void showOfferwall() async {
    if (await IronSource.isOfferwallAvailable()) {
      IronSource.showOfferwall();
    } else {
      print("Offerwall not available");
    }
  }

  void showRewardedVideo() async {
    if (await IronSource.isRewardedVideoAvailable()) {
      IronSource.showRewardedVideol();
    } else {
      print("RewardedVideo not available");
    }
  }

  void showHideBanner() {
    setState(() {
      showBanner = !showBanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('IronSource ads demo'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomButton(
                    label: "Load interstitial",
                    onPressed: loadInterstitial,
                  ),
                  CustomButton(
                    label: "Show interstitial",
                    onPressed: interstitialReady ? showInterstitial : null,
                  ),
                  CustomButton(
                    label: "Show offerwall",
                    onPressed: offerwallAvailable ? showOfferwall : null,
                  ),
                  CustomButton(
                    label: "Show Rewarded Video",
                    onPressed: rewardeVideoAvailable ? showRewardedVideo : null,
                  ),
                  CustomButton(
                    label: showBanner?"hide banner":"Show Banner",
                    onPressed: showHideBanner,
                  ),
                  
                ],
              ),
            ),
// Banner ad
            if (showBanner)
              Align(
                alignment: Alignment.bottomCenter,
                child: IronSourceBannerAd(
                  keepAlive: true,
                  listener: BannerAdListener()
                ),
              )
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
    setState(() {
      interstitialReady = false;
    });

    // TODO: implement onInterstitialAdOpened
  }

  @override
  void onInterstitialAdReady() {
    print("onInterstitialAdReady");
    setState(() {
      interstitialReady = true;
    });
    // TODO: implement onInterstitialAdReady
  }

  @override
  void onInterstitialAdShowFailed(Map<String, dynamic> error) {
    // TODO: implement onInterstitialAdShowFailed
    print("onInterstitialAdShowFailed : $error");
    setState(() {
      interstitialReady = false;
    });
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
    setState(() {
      offerwallAvailable = available;
    });
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
    setState(() {
      rewardeVideoAvailable = available;
    });
  }
}

class BannerAdListener extends IronSourceBannerListener {
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

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const CustomButton({Key key, this.label, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: MaterialButton(
        minWidth: 250.0,
        height: 50.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: BorderSide(width: 2.0, color: Colors.blue)),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
