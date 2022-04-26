import 'package:flutter/material.dart';
import 'package:todoapp/pages/todos_page.dart';

void main() => runApp(const ToDoApp());

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: const ToDoList(),
    );
  }
}