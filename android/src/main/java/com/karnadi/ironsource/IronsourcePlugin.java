package com.karnadi.ironsource;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.os.AsyncTask;
import android.text.TextUtils;

import com.ironsource.adapters.supersonicads.SupersonicConfig;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.integration.IntegrationHelper;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.model.Placement;
import com.ironsource.mediationsdk.sdk.InterstitialListener;
import com.ironsource.mediationsdk.sdk.OfferwallListener;
import com.ironsource.mediationsdk.sdk.RewardedVideoListener;

import java.util.HashMap;
import java.util.Map;


/**
 * IronsourcePlugin
 */
public class IronsourcePlugin implements MethodCallHandler, InterstitialListener, RewardedVideoListener, OfferwallListener {

    public final String TAG = "IronsourcePlugin";
    public String APP_KEY = "85460dcd";
    public Placement mPlacement;
    public final String FALLBACK_USER_ID = "userId";
    public final Activity mActivity;
    public final MethodChannel mChannel;

    public IronsourcePlugin(Activity activity, MethodChannel channel) {
        this.mActivity = activity;
        this.mChannel = channel;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), IronSourceConsts.MAIN_CHANNEL);
        channel.setMethodCallHandler(new IronsourcePlugin(registrar.activity(), channel));

        final MethodChannel interstitialAdChannel = new MethodChannel(registrar.messenger(), IronSourceConsts.INTERSTITIAL_CHANNEL);


        registrar.platformViewRegistry().registerViewFactory(IronSourceConsts.BANNER_AD_CHANNEL, new IronSourceBanner(registrar.activity(), registrar.messenger()));
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


    public void initialize(String appKey) {
        APP_KEY = appKey;
        //The integrationHelper is used to validate the integration. Remove the integrationHelper before going live!
        IntegrationHelper.validateIntegration(mActivity);

        startIronSourceInitTask();

        //Network Connectivity Status
        IronSource.shouldTrackNetworkState(mActivity, true);
    }

    public void startIronSourceInitTask() {

//         getting advertiser id should be done on a background thread
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

        // Set listener
        IronSource.setInterstitialListener(this);
        IronSource.setRewardedVideoListener(this);
        IronSource.setOfferwallListener(this);
        SupersonicConfig.getConfigObj().setClientSideCallbacks(true);
        // set the IronSource user id
        IronSource.setUserId(userId);
        // init the IronSource SDK
        IronSource.init(mActivity, appKey);
    }

    // Interstitial Listener

    @Override
    public void onInterstitialAdClicked() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_CLICKED, null);
                    }
                }
        );

    }

    @Override
    public void onInterstitialAdReady() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_READY, null);
                    }
                }
        );

    }

    @Override
    public void onInterstitialAdLoadFailed(final IronSourceError ironSourceError) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_LOAD_FAILED, arguments);

                    }
                }
        );
    }

    @Override
    public void onInterstitialAdOpened() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_OPENED, null);

                    }
                }
        );

    }

    @Override
    public void onInterstitialAdClosed() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...

                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_CLOSED, null);
                    }
                }
        );


    }

    @Override
    public void onInterstitialAdShowSucceeded() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_SHOW_SUCCEEDED, null);
                    }
                }
        );


    }

    @Override
    public void onInterstitialAdShowFailed(final IronSourceError ironSourceError) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        mChannel.invokeMethod(IronSourceConsts.ON_INTERSTITIAL_AD_SHOW_FAILED, arguments);
                    }
                }
        );


    }

    // --------- IronSource Rewarded Video Listener ---------

    @Override
    public void onRewardedVideoAdOpened() {
        // called when the video is opened
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_OPENED, null);
                    }
                }
        );

    }

    @Override
    public void onRewardedVideoAdClosed() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_CLOSED, null);
                    }
                }
        );
    }

    @Override
    public void onRewardedVideoAvailabilityChanged(final boolean b) {
        // called when the video availbility has changed
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AVAILABILITY_CHANGED, b);
                    }
                }
        );

    }

    @Override
    public void onRewardedVideoAdStarted() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_STARTED, null);
                    }
                }
        );
    }

    @Override
    public void onRewardedVideoAdEnded() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_ENDED, null);
                    }
                }
        );
    }

    @Override
    public void onRewardedVideoAdRewarded(final Placement placement) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("placementId",placement.getPlacementId());
                        arguments.put("placementName", placement.getPlacementName());
                        arguments.put("rewardAmount", placement.getRewardAmount());
                        arguments.put("rewardName", placement.getRewardName());
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_REWARDED, arguments);
                    }
                }
        );

    }

    @Override
    public void onRewardedVideoAdShowFailed(final IronSourceError ironSourceError) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_SHOW_FAILED, arguments);
                    }
                }
        );

    }

    @Override
    public void onRewardedVideoAdClicked(final Placement placement) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("placementId",placement.getPlacementId());
                        arguments.put("placementName", placement.getPlacementName());
                        arguments.put("rewardAmount", placement.getRewardAmount());
                        arguments.put("rewardName", placement.getRewardName());
                        mChannel.invokeMethod(IronSourceConsts.ON_REWARDED_VIDEO_AD_CLICKED, arguments);
                    }
                }
        );

    }

    // --------- IronSource Offerwall Listener ---------

    @Override
    public void onOfferwallAvailable(final boolean available) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_AVAILABLE, available);
                    }
                }
        );
    }

    @Override
    public void onOfferwallOpened() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_OPENED, null);
                    }
                }
        );
    }

    @Override
    public void onOfferwallShowFailed(final IronSourceError ironSourceError) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_SHOW_FAILED, arguments);
                    }
                }
        );
    }

    @Override
    public boolean onOfferwallAdCredited(final int credits,final int totalCredits,final boolean totalCreditsFlag) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("credits", credits);
                        arguments.put("totalCredits", totalCredits);
                        arguments.put("totalCreditsFlag", totalCreditsFlag);
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_AD_CREDITED, arguments);
                    }
                }
        );
        return false;
    }

    @Override
    public void onGetOfferwallCreditsFailed(final IronSourceError ironSourceError) {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        Map<String, Object> arguments = new HashMap<String, Object>();
                        arguments.put("errorCode", ironSourceError.getErrorCode());
                        arguments.put("errorMessage", ironSourceError.getErrorMessage());
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_CREDITS_FAILED, arguments);
                    }
                }
        );
    }

    @Override
    public void onOfferwallClosed() {
        mActivity.runOnUiThread(
                new Runnable() {
                    public void run() {
                        //back on UI thread...
                        mChannel.invokeMethod(IronSourceConsts.ON_OFFERWALL_CLOSED, null);
                    }
                }
        );

    }

}
