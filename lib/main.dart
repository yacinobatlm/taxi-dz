import 'package:flutter/material.dart';
import 'package:taxi_dz/GUI/sign_up_page.dart';

import 'GUI/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wasalni",
      //theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
