import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
enum MyNativeAdsState { Loading, Success, Failed }

class MyNativeAdsBloc{

//region Common variable
  BuildContext context;
  NativeAd? nativeAd;
  //endregion


//region Controller
  final myNativeAdsStateCtrl = StreamController<MyNativeAdsState>.broadcast();
//endregion

  // region | Constructor |
  MyNativeAdsBloc(this.context);
// endregion



//region Init
  void  init(){
    loadAds();
  }
//endregion




//region Load ads
  void loadAds() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      request: const AdManagerAdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
      nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.bottomLeftCorner,
        mediaAspectRatio: MediaAspectRatio.landscape,
        requestCustomMuteThisAd: true,
        shouldRequestMultipleImages: false,
        videoOptions: VideoOptions(startMuted: true),
      ),
      factoryId: 'listTile',
      // nativeAdOptions: ,
      // factoryId: 'listTile',
      // factoryId: null,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          //Success
          myNativeAdsStateCtrl.add(MyNativeAdsState.Success);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Failed to load native ad: $error');
          myNativeAdsStateCtrl.add(MyNativeAdsState.Failed);
        },
      ),

    );
    nativeAd?.load();
  }
//endregion

//region Dispose
  void dispose() {
    nativeAd?.dispose();
    myNativeAdsStateCtrl.close();
  }
//endregion

}