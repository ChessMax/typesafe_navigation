import 'package:flutter/material.dart';

void main() => runApp(const MyApp2());

Widget _buildHome(BuildContext context, RouteInfo<void, void> route) =>
    MyHomeScreen(route: route);

Widget _buildTask(BuildContext context, RouteInfo<Task, int> route) =>
    MyTaskScreen(route: route);

Widget _buildEditTask(BuildContext context, RouteInfo<Task, Task> route) =>
    EditTaskScreen(route: route);

enum MyAppRoute<Arg, T> {
  home('/', _buildHome),
  task('/task', _buildTask),
  editTask('/edit-task', _buildEditTask);

  final String path;
  final Widget Function(BuildContext context, RouteInfo<Arg, T> route) builder;

  const MyAppRoute(this.path, this.builder);

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    const routes = MyAppRoute.values;
    final path = settings.name;
    if (path != null) {
      for (final route in routes) {
        if (route.path == path) {
          return route._buildRoute(settings.arguments);
        }
      }
    }

    return null;
  }

  Route<dynamic>? _buildRoute(Object? arguments) {
    if (arguments is Arg) {
      final route = RouteInfo<Arg, T>(arguments);
      final screen =
          MaterialPageRoute<T>(builder: (context) => builder(context, route));
      return screen;
    }
    return null;
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo 2',
      onGenerateRoute: MyAppRoute.onGenerateRoute,
    );
  }
}

extension N on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}

extension B<T> on MyAppRoute<void, T> {
  Future<T?> push(NavigatorState navigator) => navigator.pushNamed<T>(path);

  void pop(NavigatorState navigator) => navigator.pop();
}

extension B2<Arg extends Object, T> on MyAppRoute<Arg, T> {
  Future<T?> push(NavigatorState navigator, Arg args) =>
      navigator.pushNamed<T>(path, arguments: args);

  void pop(NavigatorState navigator, T? result) => navigator.pop(result);
}

extension B3<T> on RouteInfo<void, T> {
  void pop(NavigatorState navigator) => navigator.pop();
}

extension B4<Arg extends Object, T> on RouteInfo<Arg, T> {
  void pop(NavigatorState navigator, T? result) => navigator.pop(result);
}

extension AppRoutesExtension<Args extends Object, T> on MyAppRoute<Args, T> {
  RoutePushInfo<Args, T> call(Args args) =>
      RoutePushInfo._((route: this, args: args));
}

extension AppRoutesExtension2<T> on MyAppRoute<void, T> {
  RoutePushInfo<void, T> call() => RoutePushInfo._((route: this, args: null));
}

extension AppRoutesExtensionB2 on NavigatorState {
  Future<T?> pushRoute<Arg, T>(RoutePushInfo<Arg, T> routeInfo) =>
      routeInfo.push(this);
}

extension AppRoutesExtensionB33 on BuildContext {
  Future<T?> pushRoute<Arg, T>(RoutePushInfo<Arg, T> routeInfo) =>
      routeInfo.push(navigator);
}

extension type RoutePushInfo<Arg, T>._(
    ({MyAppRoute<Arg, T> route, Arg args}) info) {
  Future<T?> push(NavigatorState navigator) =>
      navigator.pushNamed(info.route.path, arguments: info.args);
}

extension type RoutePopInfo<Arg, T>._(
    ({MyAppRoute<Arg, T> route, Arg args}) info) {
  void pop(NavigatorState navigator) => navigator.pop(info.args);
}

typedef MyRouteBuilder<Arg, T> = Widget Function(
    BuildContext context, RouteInfo<Arg, T> route);

// class RouteInfo<Arg, T> {
//   final Arg args;
//
//   const RouteInfo({required this.args});
// }
extension type const RouteInfo<Arg, T>(Arg args) {}

class Task {
  final String title;

  Task(this.title);

  Task copyWith({String? title}) => Task(title ?? this.title);
}

class MyHomeScreen extends StatelessWidget {
  final RouteInfo<void, void> route;

  const MyHomeScreen({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo list')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // final result =
                //     await MyAppRoute.task.push(context.navigator, Task('My task'));
                // final v = await MyAppRoute.home.push(context.navigator);
                final result = await context.navigator
                    .pushRoute(MyAppRoute.task(Task('My task')));
                debugPrint('pop result: $result');
              },
              child: const Text('Open task'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await context.navigator
                    .pushRoute(MyAppRoute.editTask(Task('My task')));
                debugPrint('pop result: $result');
              },
              child: const Text('Edit task'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTaskScreen extends StatelessWidget {
  final RouteInfo<Task, int> route;

  const MyTaskScreen({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task "${route.args.title}"')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => route.pop(context.navigator, 1),
              child: const Text('Pop 1'),
            ),
            ElevatedButton(
              onPressed: () => route.pop(context.navigator, 2),
              child: const Text('Pop 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatelessWidget {
  final RouteInfo<Task, Task> route;

  const EditTaskScreen({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    final task = route.args;
    return Scaffold(
      appBar: AppBar(
          title:
              Text(task != null ? 'Edit task "${task.title}"' : 'Create task')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (task != null)
              ElevatedButton(
                onPressed: () => route.pop(context.navigator,
                    task.copyWith(title: '${task.title} (edited)')),
                child: const Text('Save'),
              )
            else
              ElevatedButton(
                onPressed: () => route.pop(context.navigator, Task('New task')),
                child: const Text('Create'),
              ),
          ],
        ),
      ),
    );
  }
}
