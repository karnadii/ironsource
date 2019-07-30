package com.karnadi.ironsource;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import java.util.HashMap;
import java.util.Map;

import com.ironsource.mediationsdk.ISBannerSize;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.IronSourceBannerLayout;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.sdk.BannerListener;

public class IronSourceBannerView implements PlatformView, BannerListener {
    private FrameLayout adView;
    private final String TAG = "IronSourceBannerView";
    private final MethodChannel channel;
    private final HashMap args;
    private final Context context;

    private IronSourceBannerLayout mIronSourceBannerLayout;


    IronSourceBannerView(Context context, int id, HashMap args, BinaryMessenger messenger, Activity activity) {
        this.channel = new MethodChannel(messenger,
                IronSourceConsts.MAIN_CHANNEL+"/banner" + id);


        this.args = args;
        this.context = context;
        adView = new FrameLayout(context);
        // choose banner size
        ISBannerSize size = ISBannerSize.BANNER;

        // instantiate IronSourceBanner object, using the IronSource.createBanner API
        mIronSourceBannerLayout = IronSource.createBanner(activity, size);
        mIronSourceBannerLayout.setBannerListener(this);
        loadBanner();
    }


    private void loadBanner() {
        if (adView.getChildCount() > 0)
            adView.removeAllViews();
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT);
        adView.addView(
                mIronSourceBannerLayout
        );
        adView.setVisibility(View.VISIBLE);

        IronSource.loadBanner(mIronSourceBannerLayout);

    }

    public View getView() {
        return adView;
    }

    @Override
    public void dispose() {
        adView.setVisibility(View.INVISIBLE);

    }

    @Override
    public void onBannerAdLoaded() {
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_LOADED, null);
    }

    @Override
    public void onBannerAdLoadFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_LOAD_FAILED, arguments);
    }

    @Override
    public void onBannerAdClicked() {
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_CLICKED, null);
    }

    @Override
    public void onBannerAdScreenPresented() {
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_SCREEN_PRESENTED, null);
    }

    @Override
    public void onBannerAdScreenDismissed() {
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_sCREEN_DISMISSED, null);
    }

    @Override
    public void onBannerAdLeftApplication() {
        channel.invokeMethod(IronSourceConsts.ON_BANNER_AD_LEFT_APPLICATION, null);
    }


}
