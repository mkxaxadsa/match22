import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/models/action.dart';
import 'package:match_time/my_theme.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.action});
  final ActionNew action;

  @override
  Widget build(BuildContext context) {
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
            Image.network(
              action.img,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMMM,yyyy').format(action.dateTime),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF979797),
                    ),
                  ),
                  const SizedBox(height: 4),
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
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
