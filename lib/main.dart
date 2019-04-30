import 'package:flutter/material.dart';
import 'package:hire_itc/logo_timer.dart';
import 'package:hire_itc/student_registeration.dart';
import 'package:hire_itc/student_screen_page.dart';

import 'choose_account.dart';
import 'direct_to_login.dart';
import 'info_walkthrough.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LogoTimer(),
        routes: <String , WidgetBuilder>{

          '/info_walkthrough': (BuildContext context) => new MyWalkthrough(),
          '/choose_account': (BuildContext context) => new ChooseAccount(),
          '/student_registeration': (BuildContext context) => new StudentRegister(),
          '/direct_to_login': (BuildContext context) => new LoginPage(),
          '/student_screen_page': (BuildContext context) => new StudentScreen(),

        }
      );

  }
}

















