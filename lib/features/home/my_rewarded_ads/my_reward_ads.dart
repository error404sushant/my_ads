import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ads/features/home/my_rewarded_ads/my_reward_ads_bloc.dart';

class MyRewardAds extends StatefulWidget {
  const MyRewardAds({super.key});

  @override
  State<MyRewardAds> createState() => _MyRewardAdsState();
}

class _MyRewardAdsState extends State<MyRewardAds> with AutomaticKeepAliveClientMixin<MyRewardAds>  {
  //Keep alive
  @override
  bool get wantKeepAlive => true;

  //region Bloc
  late MyRewardAdsBloc myRewardAdsBloc ;
  //endregion

  //region Init
  @override
  void initState() {
    myRewardAdsBloc = MyRewardAdsBloc( context);
    myRewardAdsBloc.init();
    super.initState();
  }
  //endregion

  //region Dispose
  @override
  void dispose() {
    myRewardAdsBloc.dispose();
    super.dispose();
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return body();
  }

  //region Body
  Widget body() {
    return StreamBuilder<MyRewardAdsState>(
        stream: myRewardAdsBloc.myRewardAdsStateCtrl.stream,
        initialData: MyRewardAdsState.Loading,
        builder: (context, snapshot) {
          //Loading
          if(snapshot.data == MyRewardAdsState.Loading) {
            return Container(
              height: 50,
              width: 300,
              color: Colors.red,
            );
          }
          //Success
          if(snapshot.data == MyRewardAdsState.Success && myRewardAdsBloc.rewardedAd != null) {
            return Column(
              children: [
                Text("reward : ${myRewardAdsBloc.reward}"),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        color: Colors.orange,
                        child: Text("Show ads"), onPressed: (){
                      myRewardAdsBloc.loadAds();
                    }),
                  ],
                ),
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
