// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp4());
//
// class Navigation extends StatelessWidget {
//   const Navigation({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text('Place holder');
//   }
// }
//
// class RouteInfo<Args, T> {
//   final String path;
//   final Args args;
//
//   RouteInfo({required this.path, required this.args});
// }
//
// enum AppRoute<Args, T> {
//   home(),
//   task();
//
//   static final home = Route<void, void>(
//     path: '/',
//     builder: (context, route) => HomeScreen(route: route),
//   );
// }
//
// class Route<Args, T> {
//   final String path;
//   final Widget Function(BuildContext context, RouteInfo<Args, T> args) builder;
//   const Route({required this.path, required this.builder});
// }
//
// class MyApp4 extends StatelessWidget {
//   const MyApp4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo 4',
//       onGenerateRoute: MyAppRoute.onGenerateRoute,
//     );
//   }
// }
//
// class Task {
//   final String title;
//
//   Task(this.title);
// }
//
// class HomeScreen extends StatelessWidget {
//   final RouteInfo<void, void> route;
//
//   const HomeScreen({required this.route, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Todo list')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // final result =
//             //     await MyAppRoute.task.push(context.navigator, Task('My task'));
//             // final v = await MyAppRoute.home.push(context.navigator);
//             final result = await context.navigator
//                 .pushRoute(MyAppRoute.task(Task('My task')));
//             debugPrint('pop result: $result');
//           },
//           child: const Text('Open task'),
//         ),
//       ),
//     );
//   }
// }
//
// class TaskScreen extends StatelessWidget {
//   final Route<Task, int> route;
//
//   const TaskScreen({required this.route, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Task "${route.args.title}"')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => route.pop(context.navigator, 1),
//               child: const Text('Pop 1'),
//             ),
//             ElevatedButton(
//               onPressed: () => route.pop(context.navigator, 2),
//               child: const Text('Pop 2'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
