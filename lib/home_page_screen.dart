import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('Current Page --> $runtimeType');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
