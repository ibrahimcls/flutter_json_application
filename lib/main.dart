import 'package:flutter/material.dart';
import 'package:flutterapp/login_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginUser(),
    );
  }
}
