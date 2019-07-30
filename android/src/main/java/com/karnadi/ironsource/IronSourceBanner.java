package com.karnadi.ironsource;

import android.app.Activity;
import android.content.Context;
import java.util.HashMap;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;


public class IronSourceBanner extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    public final Activity mActivity;

    IronSourceBanner(Activity activity,BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.mActivity = activity;
    }


    @Override
    public PlatformView create(Context context, int id, Object args) {
        return new IronSourceBannerView(context, id, (HashMap) args, this.messenger, this.mActivity);
    }

}
