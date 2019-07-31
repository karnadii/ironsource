package com.karnadi.ironsource;

public class IronSourceConsts {
    static final String MAIN_CHANNEL = "com.karnadi.ironsource";
    static final String BANNER_AD_CHANNEL = MAIN_CHANNEL + "/bannerAd";
    static final String INTERSTITIAL_CHANNEL = MAIN_CHANNEL + "/interstitialAd";

    static final String INIT = "initialize";
    static final String LOAD_INTERSTITIAL = "loadInterstitial";
    static final String SHOW_INTERSTITIAL = "showInterstitial";
    static final String IS_INTERSTITIAL_READY = "isInterstitialReady";
    static final String IS_REWARDED_VIDEO_AVAILABLE = "isRewardedVideoAvailable";
    static final String IS_OFFERWALL_AVAILABLE = "isOfferwallAvailable";
    static final String SHOW_OFFERWALL = "showOfferwall";
    static final String SHOW_REWARDED_VIDEO = "showRewardedVideo";

//    Listener
    static final String ON_REWARDED_VIDEO_AD_OPENED = "onRewardedVideoAdOpened";
    static final String ON_REWARDED_VIDEO_AD_CLOSED = "onRewardedVideoAdClosed";
    static final String ON_REWARDED_VIDEO_AVAILABILITY_CHANGED = "onRewardedVideoAvailabilityChanged";
    static final String ON_REWARDED_VIDEO_AD_STARTED = "onRewardedVideoAdStarted";
    static final String ON_REWARDED_VIDEO_AD_ENDED = "onRewardedVideoAdEnded";
    static final String ON_REWARDED_VIDEO_AD_REWARDED = "onRewardedVideoAdRewarded";
    static final String ON_REWARDED_VIDEO_AD_SHOW_FAILED = "onRewardedVideoAdShowFailed";
    static final String ON_REWARDED_VIDEO_AD_CLICKED = "onRewardedVideoAdClicked";

// Offerwall listener
    static final String ON_OFFERWALL_AVAILABLE = "onOfferwallAvailable";
    static final String ON_OFFERWALL_OPENED = "onOfferwallOpened";
    static final String ON_OFFERWALL_SHOW_FAILED = "onOfferwallShowFailed";
    static final String ON_OFFERWALL_AD_CREDITED = "onOfferwallAdCredited";
    static final String ON_OFFERWALL_CREDITS_FAILED = "onOfferwallCreditsFailed";
    static final String ON_OFFERWALL_CLOSED = "onOfferwallClosed";


    //    Interstitial Listener
    static final String ON_INTERSTITIAL_AD_OPENED = "onInterstitialAdOpened";
    static final String ON_INTERSTITIAL_AD_READY = "onInterstitialAdReady";
    static final String ON_INTERSTITIAL_AD_CLOSED = "onInterstitialAdClosed";
    static final String ON_INTERSTITIAL_AD_LOAD_FAILED = "onInterstitialAdLoadFailed";
    static final String ON_INTERSTITIAL_AD_SHOW_FAILED = "onInterstitialAdShowFailed";
    static final String ON_INTERSTITIAL_AD_SHOW_SUCCEEDED = "onInterstitialAdShowSucceeded";
    static final String ON_INTERSTITIAL_AD_CLICKED = "onInterstitialAdClicked";

    // Banner listener const
    static final String ON_BANNER_AD_LOADED = "onBannerAdLoaded";
    static final String ON_BANNER_AD_CLICKED = "onBannerAdClicked";
    static final String ON_BANNER_AD_SCREEN_PRESENTED = "onBannerAdScreenPresented";
    static final String ON_BANNER_AD_sCREEN_DISMISSED = "onBannerAdScreenDismissed";
    static final String ON_BANNER_AD_LEFT_APPLICATION = "onBannerAdLeftApplication";
    static final String ON_BANNER_AD_LOAD_FAILED = "onBannerAdLoadFailed";


}
