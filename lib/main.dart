import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';
import 'package:match_time/presentation/community_screen/local.dart';
import 'package:match_time/presentation/create_team_screen/create_team_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/community_screen/configx.dart';
import 'presentation/community_screen/notf.dart';

int? inxSc;
late SharedPreferences prxs;
final configMyMatches = FirebaseRemoteConfig.instance;
late SharedPreferences preferencix;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await showRate();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: MyMatchesLoadFromCache.currentPlatform);
  await configMyMatches.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 3),
    minimumFetchInterval: const Duration(seconds: 3),
  ));
  await CheckNewMatches().activate();
  final teamsMatchesController = TeamsMatchesController(preferences)..init();
  runApp(MyApp(teamsMatchesController: teamsMatchesController));
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

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.teamsMatchesController});
  final TeamsMatchesController teamsMatchesController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: fetchLiveMatchesView(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data! && snapshot.data == true) {
            return ShowMatchesLive(
              league: leagueInition,
            );
          } else {
            return ChangeNotifierProvider.value(
              value: teamsMatchesController,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: MyTheme.theme,
                routerConfig: MyRouter.router,
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
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
