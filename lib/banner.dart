import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
class ISBanner extends StatefulWidget {
  @override
  _ISBannerState createState() => _ISBannerState();
}

class _ISBannerState extends State<ISBanner> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        width: 320.0,
          height: 50.0,
          child:AndroidView(
            key: UniqueKey(),
            viewType: 'ironsource/banner',

          )
      );
    }else{
      return Container(
        child: Text("this plugin only supported for android")
      );
    }
  }
}
