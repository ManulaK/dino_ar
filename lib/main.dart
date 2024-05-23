import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'shared/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Augmented Reality with Flutter',
      theme: const AppTheme().themeData,
      home: const LoadGltfOrGlbFilePage(),
    );
  }
}
