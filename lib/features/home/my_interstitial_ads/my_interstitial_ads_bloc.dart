import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
enum MyInterstitialAdsState { Loading, Success, Failed }

class MyInterstitialAdsBloc{

//region Common variable
  BuildContext context;
  InterstitialAd? interstitialAd;
  //endregion


//region Controller
  final myBannerAdsStateCtrl = StreamController<MyInterstitialAdsState>.broadcast();
//endregion

  // region | Constructor |
  MyInterstitialAdsBloc(this.context);
// endregion



//region Init
  void  init(){
    loadAds();
  }
//endregion




//region Load ads
  void loadAds() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          //Show the ad
          if(interstitialAd != null) {
            interstitialAd!.show();
          }
          //Success
          myBannerAdsStateCtrl.add(MyInterstitialAdsState.Success);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load interstitial ad: $error');
          myBannerAdsStateCtrl.add(MyInterstitialAdsState.Failed);
        },
      ),
    );
  }
//endregion

//region Dispose
  void dispose() {
    interstitialAd?.dispose();
    myBannerAdsStateCtrl.close();
  }
//endregion

}