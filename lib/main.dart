// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:my_ads/features/app.dart';
// import 'package:my_ads/features/app.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(const App());
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Native UI in Flutter'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            child: AndroidView(
              viewType: 'native-ui',
              onPlatformViewCreated: (int id) {
                print("Platform view created: $id");
              },
            ),
          ),
        ),
      ),
    );
  }
}
