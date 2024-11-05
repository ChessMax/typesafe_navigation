import 'package:flutter/material.dart';
import 'package:typesafe_navigation/domain/task.dart';
import 'package:typesafe_navigation/home_screen.dart';
import 'package:typesafe_navigation/task_screen.dart';

typedef RouteBuilder<Args, T, R extends RouteArgs<Args, T>> = Widget Function(
    BuildContext context, R route);

enum AppRoute<Args, T, R extends RouteArgs<Args, T>> {
  home('/', _buildHome<int>),
  task('/task', _buildTask);

  static Widget _buildHome<F>(BuildContext context, HomeRoute route) =>
      HomeScreen(route: route);

  static Widget _buildTask(BuildContext context, TaskRoute route) =>
      TaskScreen(route: route);

  final String path;
  final RouteBuilder<Args, T, R> builder;

  const AppRoute(this.path, this.builder);

  RR callWith<RR>(RR Function<X, Y, Z>() callback) => callback<Args, T, R>();

  // static Widget create<A, TT>(BuildContext context, AppRoute<A, TT> route,
  //     A args) {
  //   switch (route) {
  //     case AppRoute.home:
  //       return HomeScreen(route: route);
  //     case AppRoute.task:
  //       return TaskScreen(route: route);
  //   }
  // }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = settings.name!;
    const routes = AppRoute.values;
    for (final r in routes) {
      if (r.path == route) {
        return r._generateRoute(settings);
      }
    }
    throw 'Unexpected route: ';
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    return MaterialPageRoute<T>(
      builder: (context) => builder(context, settings.arguments as R),
      settings: settings,
    );
  }
}

class HomeRoute extends RouteArgs<void, void> {
  const HomeRoute();
}

class TaskRoute extends RouteArgs<Task, int> {
  final Task task;

  TaskRoute({required this.task});
}

sealed class RouteArgs<Args, T> {
  const RouteArgs();
}

class RouteInfo<R extends RouteArgs<dynamic, dynamic>> {
  const RouteInfo();
}
