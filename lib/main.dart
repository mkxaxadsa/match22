import 'package:flutter/material.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final teamsMatchesController = TeamsMatchesController(preferences)..init();
  runApp(MyApp(teamsMatchesController: teamsMatchesController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.teamsMatchesController});
  final TeamsMatchesController teamsMatchesController;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: teamsMatchesController,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.theme,
        routerConfig: MyRouter.router,
      ),
    );
  }
}
