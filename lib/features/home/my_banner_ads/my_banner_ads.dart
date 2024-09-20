import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_ads/features/home/my_banner_ads/my_banner_ads_bloc.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> with AutomaticKeepAliveClientMixin<BannerAds>  {
  //Keep alive
  @override
  bool get wantKeepAlive => true;
  //region Bloc
  late MyBannerAdsBloc myBannerAdsBloc ;
  //endregion

  //region Init
  @override
  void initState() {
    myBannerAdsBloc = MyBannerAdsBloc( context);
    myBannerAdsBloc.init();
    super.initState();
  }
  //endregion

  //region Dispose
  @override
  void dispose() {
    myBannerAdsBloc.dispose();
    super.dispose();
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return body();
  }

  //region Body
  Widget body() {
    return StreamBuilder<MyBannerAdsState>(
      stream: myBannerAdsBloc.myBannerAdsStateCtrl.stream,
      initialData: MyBannerAdsState.Loading,
      builder: (context, snapshot) {
        //Loading
        if(snapshot.data == MyBannerAdsState.Loading) {
          return Container(
            height: 50,
            width: 300,
            color: Colors.red,
          );
        }
        //Success
        if(snapshot.data == MyBannerAdsState.Success && myBannerAdsBloc.bannerAd != null) {
          // print( myBannerAdsBloc.bannerAd!.responseInfo.)
          return Column(
            children: [

              Container(
                color: Colors.orange,
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: AdWidget(ad: myBannerAdsBloc.bannerAd!,)),
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
