import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
enum MyRewardAdsState { Loading, Success, Failed }

class MyRewardAdsBloc{

//region Common variable
  BuildContext context;
  RewardedAd? rewardedAd;
  int reward = 0;
  //endregion


//region Controller
  final myRewardAdsStateCtrl = StreamController<MyRewardAdsState>.broadcast();
//endregion

  // region | Constructor |
  MyRewardAdsBloc(this.context);
// endregion



//region Init
  void  init(){
    loadAds();
  }
//endregion




//region Load ads
  void loadAds() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          //Show reward
          showAds();
          // Ad loaded successfully
          myRewardAdsStateCtrl.sink.add(MyRewardAdsState.Success);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          // Failed
          myRewardAdsStateCtrl.sink.add(MyRewardAdsState.Failed);
        },
      ),
    );
  }
  //endregion

  //region Show ads
  void showAds(){
    // Show the ad only if it is loaded
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          reward = reward + 1;
          // Ad loaded successfully
          myRewardAdsStateCtrl.sink.add(MyRewardAdsState.Success);
        },
      );
    }
  }
  //endregion


//region Dispose
  void dispose() {
    rewardedAd?.dispose();
    myRewardAdsStateCtrl.close();
  }
//endregion

}