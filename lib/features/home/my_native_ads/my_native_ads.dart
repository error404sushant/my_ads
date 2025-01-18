import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_ads/features/home/my_native_ads/my_native_ads_bloc.dart';

class MyNativeAds extends StatefulWidget {
  const MyNativeAds({super.key});

  @override
  State<MyNativeAds> createState() => _MyNativeAdsState();
}

class _MyNativeAdsState extends State<MyNativeAds> with AutomaticKeepAliveClientMixin<MyNativeAds> {
  //region Bloc
  late MyNativeAdsBloc myNativeAdsBloc;
  //endregion

  //region Scroll Controller
  final ScrollController _scrollController = ScrollController();
  //endregion

  //region Init
  @override
  void initState() {
    myNativeAdsBloc = MyNativeAdsBloc(context, _scrollController);
    myNativeAdsBloc.init();

    super.initState();
  }
  //endregion

  //region Dispose
  @override
  void dispose() {
    _scrollController.dispose();
    myNativeAdsBloc.dispose();
    super.dispose();
  }
  //endregion

  //region Build Widget
  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin

    return StreamBuilder<List<dynamic>>(
      stream: myNativeAdsBloc.itemsCtrl.stream,
      initialData: myNativeAdsBloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];

            if (item is NativeAd) {
              print(item.responseInfo);
              return Container(
                height: MediaQuery.of(context).size.width ,
                // color: Colors.orange,
                child: AdWidget(ad: item,),
              );
            }

            return ListTile(
              title: Text(item.toString()),
            );
          },
        );
      },
    );
  }
  //endregion

  @override
  bool get wantKeepAlive => true;
}
