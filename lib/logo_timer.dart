import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hire_itc/choose_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hire_itc/info_walkthrough.dart';


class LogoTimer extends StatefulWidget {
  @override
  _logotimerState createState() => _logotimerState();
}

class _logotimerState extends State<LogoTimer> {


  Future checkFirstSeen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool _seen = (preference.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(                 //of => mean with context
          new MaterialPageRoute(builder: (context) => ChooseAccount()));
    } else {
      preference.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => MyWalkthrough()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 2000), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           new Image.asset(
                                "assets/images/logo_T.png",height: 200.0,width:200.0,),

                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
