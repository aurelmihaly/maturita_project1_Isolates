import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(const IsolatesDemoApp());

class IsolatesDemoApp extends StatelessWidget {
  const IsolatesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolates demo',
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
