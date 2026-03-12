import 'package:flutter/material.dart';
import 'package:to_do/presentation/screens/home_page.dart';
import 'package:to_do/utils/theme.dart';

void main() {
  // Starting Point of the Application
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}
