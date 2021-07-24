import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/screen/home_screen/home_page_screen.dart';

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

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        // decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
      ),
    );
  }
}
