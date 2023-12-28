import 'package:go_router/go_router.dart';
import 'package:match_time/data/models/action.dart';
import 'package:match_time/data/models/match.dart';
import 'package:match_time/presentation/community_detail_screen/community_detail_screen.dart';
import 'package:match_time/presentation/community_screen/community_screen.dart';
import 'package:match_time/presentation/create_match_screen/create_match_screen.dart';
import 'package:match_time/presentation/create_team_screen/create_team_screen.dart';
import 'package:match_time/presentation/home_screen/home_screen.dart';
import 'package:match_time/presentation/initial_screen/initial_screen.dart';
import 'package:match_time/presentation/match_detail_screen/match_detail_screen.dart';
import 'package:match_time/presentation/matches_screen/matches_screen.dart';
import 'package:match_time/presentation/my_matches_screen/my_matches_screen.dart';
import 'package:match_time/presentation/news_detail_sceen/news_detail_screen.dart';
import 'package:match_time/presentation/news_screen/news_screen.dart';
import 'package:match_time/presentation/settings_screen/settings_screen.dart';

class MyRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: initial,
        name: initial,
        builder: (context, state) => const InitialScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeScreen(child: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: matches,
                name: matches,
                builder: (context, state) => const MatchesScreen(),
              ),
              GoRoute(
                path: matchDetail,
                name: matchDetail,
                builder: (context, state) =>
                    MatchDetailScreen(match: state.extra as FootballMatch),
              ),
              GoRoute(
                path: createMatch,
                name: createMatch,
                builder: (context, state) => const CreateMatchScreen(),
              ),
              GoRoute(
                path: createTeam,
                name: createTeam,
                builder: (context, state) => const CreateTeamScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: myMatches,
                name: myMatches,
                builder: (context, state) => const MyMatchesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: news,
                name: news,
                builder: (context, state) => const NewsScreen(),
              ),
              GoRoute(
                path: newsDetail,
                name: newsDetail,
                builder: (context, state) =>
                    NewsDetailScreen(action: state.extra as ActionNew),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: community,
                name: community,
                builder: (context, state) => const CommunityScreen(),
              ),
              GoRoute(
                path: communityDetail,
                name: communityDetail,
                builder: (context, state) =>
                    CommunityDetailScreen(action: state.extra as ActionNew),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settings,
                name: settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  static GoRouter get router => _router;

  static const String initial = '/initial';
  static const String matches = '/matches';
  static const String matchDetail = '/matchDetail';
  static const String createMatch = '/createMatch';
  static const String createTeam = '/createTeam';
  static const String myMatches = '/myMatches';
  static const String news = '/news';
  static const String newsDetail = '/newsDetail';
  static const String community = '/community';
  static const String communityDetail = '/communityDetail';
  static const String settings = '/settings';
}
