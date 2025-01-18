import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// States for the native ads
enum MyNativeAdsState { Loading, Success, Failed }

class MyNativeAdsBloc {
  //region Common variables
  BuildContext context;
  List<dynamic> items = []; // This list will hold both data and ads
  bool _isLoadingMore = false;
  final int pageSize = 10;
  final ScrollController _scrollController;
  //endregion

  //region Controller
  final myNativeAdsStateCtrl = StreamController<MyNativeAdsState>.broadcast();
  final itemsCtrl = StreamController<List<dynamic>>.broadcast(); // To notify UI of new data
  //endregion

  //region Constructor
  MyNativeAdsBloc(this.context, this._scrollController);
  //endregion

  //region Init
  void init() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {
        loadMoreData(); // Corrected the check for `_isLoadingMore`
      }
    });

    _loadInitialData();
  }
  //endregion

  //region Load ads
  Future<NativeAd> createNewAd() async {
    Completer<NativeAd> completer = Completer();

    NativeAd nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      request: const AdManagerAdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
      nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.bottomRightCorner,
        mediaAspectRatio: MediaAspectRatio.unknown,
        // shouldReturnUrlsForImageAssets: true,
        requestCustomMuteThisAd: true,
        shouldRequestMultipleImages: true,
        videoOptions: VideoOptions(startMuted: true),
      ),
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          myNativeAdsStateCtrl.add(MyNativeAdsState.Success);
          completer.complete(ad as NativeAd); // Complete the completer with the loaded ad
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Failed to load native ad: $error');
          ad.dispose(); // Dispose of the ad if it fails to load
          myNativeAdsStateCtrl.add(MyNativeAdsState.Failed);
          completer.completeError('Failed to load ad');
        },
      ),
    );

    nativeAd.load();
    return completer.future; // Return the ad when it's ready
  }
  //endregion

  //region Pagination Logic
  void _loadInitialData() {
    List<String> newData = List.generate(pageSize, (index) => 'Item ${index + 1}');
    _insertAdsIntoList(newData);
  }

  Future<void> loadMoreData() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;

    await Future.delayed(const Duration(seconds: 1)); // Simulate 1-second delay

    List<String> newData = List.generate(pageSize, (index) => 'Item ${items.length + index + 1}');
    _insertAdsIntoList(newData);

    _isLoadingMore = false;
  }

  void _insertAdsIntoList(List<String> newData) async {
    for (int i = 0; i < newData.length; i++) {
      items.add(newData[i]);

      // Insert ad after every 5th item
      if ((items.length) % 5 == 0) {
        try {
          NativeAd newAd = await createNewAd(); // Create a new ad
          items.add(newAd); // Insert the loaded ad
        } catch (e) {
          print('Error loading ad: $e');
        }
      }
    }

    itemsCtrl.add(items); // Notify UI about updated items
  }

  //endregion

  //region Dispose
  void dispose() {
    items.where((item) => item is NativeAd).forEach((ad) => (ad as NativeAd).dispose()); // Dispose of all ads
    myNativeAdsStateCtrl.close();
    itemsCtrl.close();
  }
//endregion
}
