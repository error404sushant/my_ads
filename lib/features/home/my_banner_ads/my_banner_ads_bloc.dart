import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
enum MyBannerAdsState { Loading, Success, Failed }

class MyBannerAdsBloc{

//region Common variable
  BuildContext context;
  BannerAd? bannerAd;
  //endregion


//region Controller
  final myBannerAdsStateCtrl = StreamController<MyBannerAdsState>.broadcast();
//endregion

  // region | Constructor |
  MyBannerAdsBloc(this.context);
// endregion



//region Init
void  init(){
  loadBannerAd();
}
//endregion




//region Load banner ads
  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          //Success
          myBannerAdsStateCtrl.add(MyBannerAdsState.Success);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load banner ad: $error');
          //Failed
          myBannerAdsStateCtrl.add(MyBannerAdsState.Failed);
        },
      ),
    )..load();
  }
//endregion

//region Dispose
  void dispose() {
    bannerAd?.dispose();
  }
//endregion

}