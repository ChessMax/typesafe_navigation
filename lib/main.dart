import 'package:flutter/material.dart';
import 'package:typesafe_navigation/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
