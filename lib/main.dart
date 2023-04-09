import 'package:flutter/material.dart';
import 'package:notes_app/home_page.dart';
import 'package:notes_app/task_provider.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
