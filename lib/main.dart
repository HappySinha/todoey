import 'package:flutter/material.dart';
import 'package:todoey/screens/TaskData.dart';
import 'package:todoey/screens/TasksScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
