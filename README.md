# ironsource

Flutter plugin for showing [IronSource](ironsrc.com) ads (Android only)
## Progress
- [x] Interstitial
- [ ] Banner (Still experimenting)
- [x] Offerwall
- [x] Rewarded video

## Update AndroidManifest.xml
### Manifest Permissions
Add the following permissions to your AndroidManifest.xml file inside the manifest tag but outside the `<application>` tag:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### Manifest Activities
Add the following activities inside the `<application>` tag in your AndroidManifest:
```xml
<activity
            android:name="com.ironsource.sdk.controller.ControllerActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true" />
<activity
            android:name="com.ironsource.sdk.controller.InterstitialActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" />
<activity
            android:name="com.ironsource.sdk.controller.OpenUrlActivity"
            android:configChanges="orientation|screenSize"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.Translucent" />
```


## add Google Play Services
Add the following  inside the <application> tag in your AndroidManifest:
```xml
<meta-data android:name="com.google.android.gms.version"
android:value="@integer/google_play_services_version" />
```

please read [this](http://developer.android.com/google/play-services/setup.html) to add google play service

## Mediatin
follow [this](https://developers.ironsrc.com/ironsource-mobile/android/mediation-networks-android/) to add mediation sdks


## Using this plugin
see directory example 

Visit [IronSource](https://developers.ironsrc.com/ironsource-mobile/android/android-sdk/) website to know more 


## Contributing
PR are welcomed. I don't have any java and android background, by observing (copy, paste and edit) someone else code and with my shallow basic programming I come with this plugin. so if you found an error in my code, please make an issue or a PR. 
