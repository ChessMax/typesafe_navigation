import 'package:flutter/material.dart';
import 'package:typesafe_navigation/routes.dart';

class HomeScreen extends StatelessWidget {
  final HomeRoute route;

  const HomeScreen({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo list')),
      body: const Placeholder(),
    );
  }
}
