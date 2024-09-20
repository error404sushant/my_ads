import 'package:flutter/material.dart';
import 'package:my_ads/features/home/my_banner_ads/my_banner_ads.dart';
import 'package:my_ads/features/home/my_interstitial_ads/my_interstitial_ads.dart';
import 'package:my_ads/features/home/my_native_ads/my_native_ads.dart';
import 'package:my_ads/features/home/my_rewarded_ads/my_reward_ads.dart';
import 'home_bloc.dart';

//region Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//endregion

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //region Build
  late HomeBloc homeBloc;
  //endregion
  //region Init
  @override
  void initState() {
    homeBloc = HomeBloc(context: context);
    _tabController = TabController(length: 5, vsync: this); // 5 tabs
    super.initState();
  }
  //endregion


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5 Tabs Example'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: 'Banner Ads'),
            Tab(text: 'Interstitial'),
            Tab(text: 'Reward'),
            Tab(text: 'Native'),
            Tab(text: 'Tab 5'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BannerAds(),
          MyInterstitialAds(),
          MyRewardAds(),
          MyNativeAds(),
          Center(child: Text('Content for Tab 5')),
        ],
      ),
    );
  }




}
