import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:match_time/data/models/local/local_team.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_button.dart';
import 'package:match_time/my_theme.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: context.theme.primaryColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(height: 4),
                    Text(
                      'Create Team',
                      style: context.textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: MyTheme.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFf2f2f2),
                              border: Border.all(
                                color: const Color(0xFFe0e0e0),
                              ),
                            ),
                            child: _imagePath == null
                                ? Icon(
                                    Icons.image_outlined,
                                    color: context.theme.primaryColor,
                                    size: 32,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Image.asset(
                                        'images/team_logos/$_imagePath'),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    TeamLogoWidget(
                                      path: '1.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '2.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '3.png',
                                      onPressed: _onImagePressed,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    TeamLogoWidget(
                                      path: '4.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '5.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '6.png',
                                      onPressed: _onImagePressed,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    TeamLogoWidget(
                                      path: '7.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '8.png',
                                      onPressed: _onImagePressed,
                                    ),
                                    TeamLogoWidget(
                                      path: '9.png',
                                      onPressed: _onImagePressed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Team icon',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF979797),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color(0xFFf2f2f2),
                      border: Border.all(
                        color: const Color(0xFFe0e0e0),
                      ),
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name team',
                        hintStyle: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color(0xFFf2f2f2),
                      border: Border.all(
                        color: const Color(0xFFe0e0e0),
                      ),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    title: 'Create team',
                    onTap: () {
                      if (_nameController.text.isEmpty) {
                        return;
                      }
                      final team = LocalTeam(
                        imagePath: 'images/team_logos/$_imagePath',
                        name: _nameController.text,
                        description: _descriptionController.text,
                      );
                      context.read<TeamsMatchesController>().addTeam(team);
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onImagePressed(String path) {
    setState(() {
      _imagePath = path;
    });
  }
}

class TeamLogoWidget extends StatelessWidget {
  const TeamLogoWidget(
      {super.key, required this.path, required this.onPressed});
  final String path;
  final void Function(String) onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(path),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Image.asset('images/team_logos/$path'),
        ),
      ),
    );
  }
}
