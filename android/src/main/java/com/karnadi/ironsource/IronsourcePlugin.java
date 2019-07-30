package com.karnadi.ironsource;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.text.TextUtils;
import android.util.Log;
import android.os.AsyncTask;
import android.app.Activity;
//import android.view.View;
//import android.os.Bundle;
import com.ironsource.adapters.supersonicads.SupersonicConfig;
//import com.ironsource.mediationsdk.EBannerSize;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.IronSourceBannerLayout;
import com.ironsource.mediationsdk.integration.IntegrationHelper;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.model.Placement;
import com.ironsource.mediationsdk.sdk.BannerListener;
import com.ironsource.mediationsdk.sdk.InterstitialListener;
import com.ironsource.mediationsdk.sdk.OfferwallListener;
import com.ironsource.mediationsdk.sdk.RewardedVideoListener;

import java.util.HashMap;
import java.util.Map;


/**
 * IronsourcePlugin
 */
public class IronsourcePlugin implements MethodCallHandler, InterstitialListener, OfferwallListener, RewardedVideoListener {

    public final String TAG = "IronsourcePlugin";
    public String APP_KEY = "85460dcd";
    public Placement mPlacement;
    public final String FALLBACK_USER_ID = "userId";
    public final Activity mActivity;
    public final MethodChannel mChannel;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), IronSourceConsts.MAIN_CHANNEL);
        channel.setMethodCallHandler(new IronsourcePlugin(registrar.activity(), channel));
        registrar.platformViewRegistry().registerViewFactory(IronSourceConsts.MAIN_CHANNEL+"/banner", new IronSourceBanner(registrar.activity(), registrar.messenger()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        if (call.method.equals(IronSourceConsts.INIT) && call.hasArgument("appKey")) {
            initialize(call.<String>argument("appKey"));
            result.success(null);
        } else if (call.method.equals(IronSourceConsts.LOAD_INTERSTITIAL)) {
            IronSource.loadInterstitial();
            result.success(null);
        } else if (call.method.equals(IronSourceConsts.SHOW_INTERSTITIAL)) {
            IronSource.showInterstitial();
            result.success(null);
        } else if (call.method.equals(IronSourceConsts.IS_INTERSTITIAL_READY)) {
            result.success(IronSource.isInterstitialReady());
        } else if (call.method.equals(IronSourceConsts.IS_REWARDED_VIDEO_AVAILABLE)) {
            result.success(IronSource.isRewardedVideoAvailable());
        } else if (call.method.equals(IronSourceConsts.IS_OFFERWALL_AVAILABLE)) {
            result.success(IronSource.isOfferwallAvailable());
        } else if (call.method.equals(IronSourceConsts.SHOW_OFFERWALL)) {
            IronSource.showOfferwall();
            result.success(null);
        } else if (call.method.equals(IronSourceConsts.SHOW_REWARDED_VIDEO)) {
            IronSource.showRewardedVideo();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }


    public IronsourcePlugin(Activity activity, MethodChannel channel) {
        this.mActivity = activity;
        this.mChannel = channel;
    }

    public void initialize(String appKey) {
        APP_KEY = appKey;
        //The integrationHelper is used to validate the integration. Remove the integrationHelper before going live!
        IntegrationHelper.validateIntegration(mActivity);

        startIronSourceInitTask();

        //Network Connectivity Status
        IronSource.shouldTrackNetworkState(mActivity, true);
    }

    public void startIronSourceInitTask() {

        // getting advertiser id should be done on a background thread
        AsyncTask<Void, Void, String> task = new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                return IronSource.getAdvertiserId(mActivity);
            }

            @Override
            protected void onPostExecute(String advertisingId) {
                if (TextUtils.isEmpty(advertisingId)) {
                    advertisingId = FALLBACK_USER_ID;
                }
                // we're using an advertisingId as the 'userId'
                initIronSource(APP_KEY, advertisingId);
            }
        };
        task.execute();
    }

    public void initIronSource(String appKey, String userId) {
        // Be sure to set a listener to each product that is being initiated
        // set the IronSource rewarded video listener
        IronSource.setRewardedVideoListener(this);
        // set the IronSource offerwall listener
        IronSource.setOfferwallListener(this);
        // set client side callbacks for the offerwall
        SupersonicConfig.getConfigObj().setClientSideCallbacks(true);
        // set the interstitial listener
        IronSource.setInterstitialListener(this);

        // set the IronSource user id
        IronSource.setUserId(userId);
        // init the IronSource SDK
        IronSource.init(mActivity, appKey);


        // In order to work with IronSourceBanners you need to add Providers who support banner ad unit and uncomment next line
        // createAndloadBanner();
    }


    // --------- IronSource Rewarded Video Listener ---------

    @Override
    public void onRewardedVideoAdOpened() {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_OPENED, null);
    }

    @Override
    public void onRewardedVideoAdClosed() {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_CLOSED, null);

    }

    @Override
    public void onRewardedVideoAvailabilityChanged(boolean b) {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AVAILABILITY_CHANGED, b);

    }

    @Override
    public void onRewardedVideoAdStarted() {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_STARTED, null);

    }

    @Override
    public void onRewardedVideoAdEnded() {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_ENDED, null);

    }

    @Override
    public void onRewardedVideoAdRewarded(Placement placement) {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_REWARDED, placement);
    }

    @Override
    public void onRewardedVideoAdShowFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_SHOW_FAILED, arguments);
    }

    @Override
    public void onRewardedVideoAdClicked(Placement placement) {
        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_CLICKED, placement);

    }

    // --------- IronSource Offerwall Listener ---------

    @Override
    public void onOfferwallAvailable(boolean available) {

        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_AVAILABLE, available);

    }

    @Override
    public void onOfferwallOpened() {
        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_OPENED, null);
    }

    @Override
    public void onOfferwallShowFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());
        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_SHOW_FAILED, arguments);

    }

    @Override
    public boolean onOfferwallAdCredited(int credits, int totalCredits, boolean totalCreditsFlag) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("credits", credits);
        arguments.put("totalCredits", totalCredits);
        arguments.put("totalCreditsFlag", totalCreditsFlag);

        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_AD_CREDITED, arguments);
        return false;

    }

    @Override
    public void onGetOfferwallCreditsFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());

        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_CREDITS_FAILED, arguments);
    }

    @Override
    public void onOfferwallClosed() {

        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_CLOSED, null);

    }

    // --------- IronSource Interstitial Listener ---------

    @Override
    public void onInterstitialAdClicked() {
        // called when the interstitial has been clicked
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_CLICKED, null);
    }

    @Override
    public void onInterstitialAdReady() {
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_READY, null);
    }

    @Override
    public void onInterstitialAdLoadFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_LOAD_FAILED, arguments);

    }

    @Override
    public void onInterstitialAdOpened() {
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_OPENED, null);

    }

    @Override
    public void onInterstitialAdClosed() {
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_CLOSED, null);


    }

    @Override
    public void onInterstitialAdShowSucceeded() {
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_SHOW_SUCCEEDED, null);

    }

    @Override
    public void onInterstitialAdShowFailed(IronSourceError ironSourceError) {
        Map<String, Object> arguments = new HashMap<String, Object>();
        arguments.put("errorCode", ironSourceError.getErrorCode());
        arguments.put("errorMessage", ironSourceError.getErrorMessage());
        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_SHOW_FAILED, arguments);

    }


}
