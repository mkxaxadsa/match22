import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/models/action.dart';
import 'package:match_time/my_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({super.key, required this.action});
  final ActionNew action;

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.action.vid,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: context.theme.primaryColor,
          progressColors: ProgressBarColors(
            playedColor: context.theme.primaryColor,
            handleColor: context.theme.primaryColor,
          ),
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: context.theme.primaryColor,
              title: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Row(
                      children: [
                        Icon(Icons.chevron_left, color: MyTheme.white),
                        SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: MyTheme.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  player,
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM,yyyy')
                              .format(widget.action.dateTime),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF979797),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.action.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: MyTheme.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.action.subtitle,
                          style: const TextStyle(
                              color: MyTheme.black, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
