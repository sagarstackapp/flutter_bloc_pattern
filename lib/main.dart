import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/home_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLOC Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
