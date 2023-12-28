import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:match_time/my_button.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  var _waiting = true;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    final prefes = await SharedPreferences.getInstance();
    rr(prefes);
    final firstSesstion = prefes.getBool('firstSession') ?? true;
    if (firstSesstion) {
      setState(() {
        _waiting = false;
      });
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.go(MyRouter.matches);
    });
  }

  Future<void> rr(SharedPreferences shPre) async {
    final rev = InAppReview.instance;
    bool alreadyRated = shPre.getBool('rate') ?? false;
    if (!alreadyRated) {
      if (await rev.isAvailable()) {
        rev.requestReview();
        await shPre.setBool('rate', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_waiting) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }
    return const FirstSession();
  }
}

class FirstSession extends StatefulWidget {
  const FirstSession({super.key});

  @override
  State<FirstSession> createState() => _FirstSessionState();
}

class _FirstSessionState extends State<FirstSession> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          FirstSessionItem(
            bigText: 'Sharp Predictions',
            smallText: 'Get up-to-date analytical data for successful bets',
            imgPath: 'images/welcome_1.png',
            index: 0,
            onTap: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          FirstSessionItem(
            bigText: 'Exclusive Recommendations',
            smallText: 'Learn the best bets from professional analysts',
            imgPath: 'images/welcome_2.png',
            index: 1,
            onTap: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          FirstSessionItem(
            bigText: 'Track Results',
            smallText:
                'Stay updated on the latest match updates and statistics',
            imgPath: 'images/welcome_3.png',
            index: 2,
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.setBool('firstSession', false);
              context.go(MyRouter.matches);
            },
          ),
        ],
      ),
    );
  }
}

class FirstSessionItem extends StatelessWidget {
  const FirstSessionItem(
      {super.key,
      required this.imgPath,
      required this.bigText,
      required this.smallText,
      required this.onTap,
      required this.index});
  final String imgPath;
  final String bigText;
  final String smallText;
  final VoidCallback onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imgPath),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              bigText,
              style: context.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              smallText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MyTheme.grey,
                fontSize: 16,
              ),
            ),
            const Spacer(flex: 10),
            MyButton(title: 'Next', onTap: onTap),
            const SizedBox(height: 20),
            MyStepper(currentIndex: index),
            const SizedBox(height: 40),
            const Text(
              'Terms of use  |  Privacy Policy',
              style: TextStyle(
                fontSize: 14,
                color: MyTheme.grey,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatelessWidget {
  const MyStepper({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            flex: index == currentIndex ? 3 : 1,
            child: Container(
              margin: EdgeInsets.only(right: index != 2 ? 8 : 0),
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: index == currentIndex
                    ? context.theme.primaryColor
                    : MyTheme.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
