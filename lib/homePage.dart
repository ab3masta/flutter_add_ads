import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String testDevice = 'MObile_id';

// const String testDevice = 'DF6865A02B1A0D40C2E98CCEF30E3226'; // for real ads
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId:
            BannerAd.testAdUnitId, //change BannerAd.testAdUnitId for real ads
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd
            .testAdUnitId, //change BannerAd.testAdUnitId for real ads
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(
        appId: BannerAd
            .testAdUnitId); //change BannerAd.testAdUnitId to appid for real ads
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              createInterstitialAd()
                ..load()
                ..show();
            },
            child: Text("show interstitialAd"),
          ),
        ),
      ),
    );
  }
}
