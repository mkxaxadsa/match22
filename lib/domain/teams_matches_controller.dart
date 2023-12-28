import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_time/data/models/local/local_match.dart';
import 'package:match_time/data/models/local/local_team.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String matchesKey = 'matchesKey';
const String teamsKey = 'teamsKey';

class TeamsMatchesController extends ChangeNotifier {
  TeamsMatchesController(this._preferences);
  final SharedPreferences _preferences;

  List<LocalMatch> matches = [];
  List<LocalTeam> teams = [];

  void init() {
    final jsonMatches = _preferences.getString(matchesKey) ?? '';
    if (jsonMatches.isNotEmpty) {
      final cachedMatches = jsonDecode(jsonMatches) as List<dynamic>;
      matches = cachedMatches.map((e) => LocalMatch.fromJson(e)).toList();
      notifyListeners();
    }

    final jsonTeams = _preferences.getString(teamsKey) ?? '';
    if (jsonTeams.isNotEmpty) {
      final cachedTeams = jsonDecode(jsonTeams) as List<dynamic>;
      teams = cachedTeams.map((e) => LocalTeam.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void _cacheMatches() {
    final cache = matches.map((e) => e.toJson()).toList();
    final json = jsonEncode(cache);
    _preferences.setString(matchesKey, json);
  }

  void _cacheTeams() {
    final cache = teams.map((e) => e.toJson()).toList();
    final json = jsonEncode(cache);
    _preferences.setString(teamsKey, json);
  }

  void addMatch(LocalMatch match) {
    matches.add(match);
    _cacheMatches();
    notifyListeners();
  }

  void addTeam(LocalTeam team) {
    teams.add(team);
    _cacheTeams();
    notifyListeners();
  }

  void reset() {
    matches.clear();
    teams.clear();
    _cacheMatches();
    _cacheTeams();
    notifyListeners();
  }
}
