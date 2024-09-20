import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_ads/features/home/my_banner_ads/my_banner_ads_bloc.dart';
import 'package:my_ads/features/home/my_interstitial_ads/my_interstitial_ads_bloc.dart';
import 'package:my_ads/features/home/my_native_ads/my_native_ads_bloc.dart';

class MyNativeAds extends StatefulWidget {
  const MyNativeAds({super.key});

  @override
  State<MyNativeAds> createState() => _MyNativeAdsState();
}

class _MyNativeAdsState extends State<MyNativeAds> with AutomaticKeepAliveClientMixin<MyNativeAds>  {
  //Keep alive
  @override
  bool get wantKeepAlive => true;

  //region Bloc
  late MyNativeAdsBloc myNativeAdsBloc ;
  //endregion

  //region Init
  @override
  void initState() {
    myNativeAdsBloc = MyNativeAdsBloc( context);
    myNativeAdsBloc.init();
    super.initState();
  }
  //endregion

  //region Dispose
  @override
  void dispose() {
    myNativeAdsBloc.dispose();
    super.dispose();
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return body();
  }

  //region Body
  Widget body() {
    return StreamBuilder<MyNativeAdsState>(
        stream: myNativeAdsBloc.myNativeAdsStateCtrl.stream,
        initialData: MyNativeAdsState.Loading,
        builder: (context, snapshot) {
          //Loading
          if(snapshot.data == MyNativeAdsState.Loading) {
            return Container(
              height: 50,
              width: 300,
              color: Colors.red,
            );
          }
          //Success
          if(snapshot.data == MyNativeAdsState.Success && myNativeAdsBloc.nativeAd != null) {
            return  Container(
                color: Colors.orange,
                // height: MediaQuery.of(context).size.height - 200,
                // width: MediaQuery.of(context).size.width,
                child: AdWidget(ad: myNativeAdsBloc.nativeAd!,



                ));
          }
          //Failed
          return Text("Error");
        }
    );
  }
//endregion
}
