import 'package:flutter/material.dart';
import 'package:typesafe_navigation/routes.dart';

class TaskScreen extends StatelessWidget {
  final TaskRoute route;

  const TaskScreen({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task "${route.task.title}"')),
      body: const Placeholder(),
    );
  }
}
