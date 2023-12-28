import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.primaryColor,
        title: Row
        (
          children: [
            Text(
              'Settings',
              style: context.textTheme.displayMedium,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Tile(
            s: 'Reset Progress',
            onPressed: () {
              final tmController = context.read<TeamsMatchesController>();
              tmController.reset();
            },
            path: 'images/svg/reset.svg',
          ),
          Tile(
            s: 'Privacy Policy',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scr(
                    n: 'https://docs.google.com/document/d/1YhlCgbS6XDch1N0ZNyS5CgEqqQHDUHYf-tG3JEaZcwM/edit?usp=sharing'),
              ),
            ),
            path: 'images/svg/privacy.svg',
          ),
          Tile(
            s: 'Share app',
            //TODO:

            onPressed: () {
              Share.share('Check matches in our app! Download - https://apps.apple.com/us/app/match-events-pro/id6475053807');
            },
            path: 'images/svg/share.svg',
          ),
          Tile(
            s: 'Terms of Use',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scr(
                    n: 'https://docs.google.com/document/d/1fbjwwXLu3iW9g2SjLKY1C5LdD9L7B9hHIRhjnRPgFFo/edit?usp=sharing'),
              ),
            ),
            path: 'images/svg/terms.svg',
          ),
          Tile(
            s: 'Rate app',
            onPressed: () =>
                InAppReview.instance.openStoreListing(appStoreId: '6475053807'),
            path: 'images/svg/rate.svg',
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.s,
    required this.onPressed,
    required this.path,
  });

  final String s;
  final VoidCallback onPressed;
  final String path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
        child: Row(
          children: [
            SvgPicture.asset(path),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                s,
                style: const TextStyle(color: MyTheme.black, fontSize: 16),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: MyTheme.black,
            ),
          ],
        ),
      ),
    );
  }
}

class Scr extends StatefulWidget {
  const Scr({super.key, required this.n});
  final String n;

  @override
  State<Scr> createState() => _ScrState();
}

class _ScrState extends State<Scr> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.n),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
