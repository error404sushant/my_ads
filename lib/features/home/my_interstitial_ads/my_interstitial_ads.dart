import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_ads/features/home/my_banner_ads/my_banner_ads_bloc.dart';
import 'package:my_ads/features/home/my_interstitial_ads/my_interstitial_ads_bloc.dart';

class MyInterstitialAds extends StatefulWidget {
  const MyInterstitialAds({super.key});

  @override
  State<MyInterstitialAds> createState() => _MyInterstitialAdsState();
}

class _MyInterstitialAdsState extends State<MyInterstitialAds> with AutomaticKeepAliveClientMixin<MyInterstitialAds>  {
  //Keep alive
  @override
  bool get wantKeepAlive => true;

  //region Bloc
  late MyInterstitialAdsBloc myInterstitialAdsBloc ;
  //endregion

  //region Init
  @override
  void initState() {
    myInterstitialAdsBloc = MyInterstitialAdsBloc( context);
    myInterstitialAdsBloc.init();
    super.initState();
  }
  //endregion

  //region Dispose
  @override
  void dispose() {
    myInterstitialAdsBloc.dispose();
    super.dispose();
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return body();
  }

  //region Body
  Widget body() {
    return StreamBuilder<MyInterstitialAdsState>(
        stream: myInterstitialAdsBloc.myBannerAdsStateCtrl.stream,
        initialData: MyInterstitialAdsState.Loading,
        builder: (context, snapshot) {
          //Loading
          if(snapshot.data == MyInterstitialAdsState.Loading) {
            return Container(
              height: 50,
              width: 300,
              color: Colors.red,
            );
          }
          //Success
          if(snapshot.data == MyInterstitialAdsState.Success && myInterstitialAdsBloc.interstitialAd != null) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                    color: Colors.orange,
                    child: Text("Show interstitial ads"), onPressed: (){
                  myInterstitialAdsBloc.loadAds();
                }),
              ],
            );
          }
          //Failed
          return Text("Error");
        }
    );
  }
//endregion
}
