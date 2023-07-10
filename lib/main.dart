import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/core_app.dart';

void main() {
  runApp(
      Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()},
        child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Controller Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CoreApp(),
    );
  }
}


