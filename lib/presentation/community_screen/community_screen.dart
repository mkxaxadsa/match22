import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/models/action.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: context.theme.primaryColor,
          title: Row(
            children: [
              Text(
                'Football community',
                style: context.textTheme.displayMedium,
              ),
            ],
          ),
        ),
        SliverList.builder(
          itemCount: community.length,
          itemBuilder: (context, index) {
            final action = community[index];
            return ActionItem(action: action);
          },
        ),
      ],
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({super.key, required this.action});
  final ActionNew action;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(MyRouter.communityDetail, extra: action),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    action.img,
                    width: MediaQuery.of(context).size.width - 32,
                    height: (MediaQuery.of(context).size.width - 32) / 2,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: MyTheme.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              action.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: MyTheme.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              action.subtitle,
              style: const TextStyle(color: MyTheme.black, fontSize: 16),
              maxLines: 7,
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat('dd MMMM,yyyy').format(action.dateTime),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF979797),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
