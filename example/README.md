# ironsource_example

Demonstrates how to use the ironsource plugin.

## Getting Started

import it
```dart
import 'package:ironsource/ironsource.dart';
```
initialize it with `appKey` in initState and make a class that extends `IronSourceListener` and pass it to listener
```dart
 await IronSource.initialize(appKey: appKey, listener: this);
```

### Interstitial
load it before showing it using `IronSource.loadInterstitial()` 
```dart
  void loadInterstitial() {
    IronSource.loadInterstitial();
  }

```
then show it when it is ready;

```dart
 void showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      IronSource.showInterstitial();
    } else {
      print(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }
```

### RewardedVideo and Offerwall
check the availability of it
```dart
rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    offerwallAvailable = await IronSource.isOfferwallAvailable();
```
then show it when its available
```dart
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

```

### Banner
you can use it like any other widget
```dart
Align(
    alignment: Alignment.bottomCenter,
    child: IronSourceBannerAd(
        keepAlive: true,
        listener: BannerAdListener()
    ),
)
```
for listener,make a class that extends `IronSourceBannerListener` and then pass it on listener

```dart

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

```