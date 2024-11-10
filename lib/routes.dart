import 'package:flutter/material.dart';
import 'package:typesafe_navigation/domain/task.dart';
import 'package:typesafe_navigation/home_screen.dart';
import 'package:typesafe_navigation/task_screen.dart';

typedef RouteBuilder<Args, T, R extends RouteArgs<Args, T>> = Widget Function(
    BuildContext context, R route);

Widget _buildHome2(BuildContext context, HomeRoute route) =>
    HomeScreen(route: route);

// params from route url
// params as extra
// or both

// /task/15
class Parameter<T> {
  final String name;

  const Parameter([this.name = '']);
}

const r = ('/task/', Parameter<int>());

Widget _buildTask2(BuildContext context, TaskRoute2 route) =>
    const HomeScreen(route: HomeRoute());

enum AppRoute<Args, T, R extends RouteArgs<Args, T>> {
  home('/', _buildHome2),
  task('/task', _buildTask),
  task2('/task2', _buildTask2);

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
    //final t = TaskRoute2(task: Task);
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
    // const HomeRoute().pop();
    // TaskRoute(task: Task(title: 'title')).pop();

    return MaterialPageRoute<T>(
      builder: (context) => builder(context, settings.arguments as R),
      settings: settings,
    );
  }
}

// typedef TaskRoute2 = RouteArgs<({Task task}), int>;
extension type TaskRoute2(RouteArgs<({Task task}), int> value)
    implements RouteArgs<({Task task}), int> {}

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

extension RouteMethods on RouteArgs<dynamic, void> {
  void pop([void result]) {}
}

extension RouteMethods2<T extends Object> on RouteArgs<dynamic, T> {
  void pop(T? result) {
    final p = Path<String>('/task')
        .withParameter<int>(':taskId')
        .withParameter<String>('count');
  }
}

extension type Path<T>(String path) {
  Path<(T, P)> withParameter<P>(String name) {
    return Path('$path/$name');
  }
}

extension PathExt on Path<String> {
  // Path<(String, P)> withParameter<P>(String name) {
  //   return Path('$path/$name');
  //
  // }
}
