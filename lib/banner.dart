import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Ironsource_consts.dart';

class BannerSize {
  final int width;
  final int height;

  static const BannerSize STANDARD = BannerSize(width: 320, height: 50);
  static const BannerSize SMALL = BannerSize(width: 300, height: 50);
  static const BannerSize MEDIUM_RECTANGLE =
      BannerSize(width: 320, height: 250);

  const BannerSize({this.width = 320, this.height = 50});
}


enum BannerSizeType { STANDARD, MEDIUM_ECTANGLE, LARGE }

class IronSourceBannerAd extends StatefulWidget {
  final Key key;
  final IronSourceBannerListener listener;

  /// This defines if the ad view to be kept alive.
  final bool keepAlive;
  IronSourceBannerAd({
    this.key,
    // this.bannerSize = BannerSize.STANDARD,
    this.listener,
    this.keepAlive = false,
  }) : super(key: key);

  @override
  _IronSourceBannerAdState createState() => _IronSourceBannerAdState();
}

class _IronSourceBannerAdState extends State<IronSourceBannerAd>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;
  static IronSourceBannerListener _listener;
  static IronSourceBannerListener getListener() {
    return _listener;
  }

  BannerSize size = BannerSize.STANDARD;
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
          width: size.width.toDouble(),
          height: size.height.toDouble(),
          child: AndroidView(
            key: UniqueKey(),
            viewType: BANNER_AD_CHANNEL,
            onPlatformViewCreated: _onBannerAdViewCreated,
            creationParams: <String, dynamic>{
              "height": size.height,
              "width": size.width,
            },
            creationParamsCodec: StandardMessageCodec(),
          ));
    } else {
      return Container(child: Text("this plugin only supported for android"));
    }
  }

  void _onBannerAdViewCreated(int id) async {
    final channel = MethodChannel('$BANNER_AD_CHANNEL$id');
    _listener = widget.listener;
    await channel.setMethodCallHandler(_listener._handle);
  }
}

abstract class IronSourceBannerListener {
  Future<Null> _handle(MethodCall methodCall) async {
    if (methodCall.method == ON_BANNER_AD_CLICKED)
      onBannerAdClicked();
    else if (methodCall.method == ON_BANNER_AD_LEFT_APPLICATION)
      onBannerAdLeftApplication();
    else if (methodCall.method == ON_BANNER_AD_LOAD_FAILED)
      onBannerAdLoadFailed(methodCall.arguments["error"]);
    else if (methodCall.method == ON_BANNER_AD_LOADED)
      onBannerAdLoaded();
    else if (methodCall.method == ON_BANNER_AD_sCREEN_DISMISSED)
      onBannerAdScreenDismissed();
    else if (methodCall.method == ON_BANNER_AD_SCREEN_PRESENTED)
      onBannerAdScreenPresented();
  }

//  Banner
  void onBannerAdLeftApplication();

  void onBannerAdScreenDismissed();

  void onBannerAdScreenPresented();

  void onBannerAdClicked();

  void onBannerAdLoaded();

  void onBannerAdLoadFailed(Map<String, dynamic> error);
}
