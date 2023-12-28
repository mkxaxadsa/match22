import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:match_time/my_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.child,
  });
  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: MyTheme.white,
        child: SafeArea(
          child: Row(
            children: [
              Child(
                path: 'images/svg/matches.svg',
                name: 'Matches',
                chosen: child.currentIndex == 0,
                onTap: () => _onTap(0),
              ),
               Child(
                path: 'images/svg/my_matches.svg',
                name: 'My Matches',
                chosen: child.currentIndex == 1,
                onTap: () => _onTap(1),
              ),
              Child(
                path: 'images/svg/news.svg',
                name: 'News',
                chosen: child.currentIndex == 2,
                onTap: () => _onTap(2),
              ),
              Child(
                path: 'images/svg/community.svg',
                name: 'Community',
                chosen: child.currentIndex == 3,
                onTap: () => _onTap(3),
              ),
              Child(
                path: 'images/svg/settings.svg',
                name: 'Settings',
                chosen: child.currentIndex == 4,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(int i) {
    child.goBranch(i);
  }
}

class Child extends StatelessWidget {
  const Child({
    super.key,
    required this.path,
    required this.name,
    required this.chosen,
    required this.onTap,
  });
  final String path;
  final String name;
  final bool chosen;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              path,
              colorFilter: ColorFilter.mode(
                chosen ? context.theme.primaryColor : const Color(0xFFDDDDDD),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: chosen
                    ? context.theme.primaryColor
                    : const Color(0xFFDDDDDD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
