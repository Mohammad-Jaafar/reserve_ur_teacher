import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_itc/direct_to_login.dart';
import 'package:hire_itc/student_registeration.dart';
import 'package:hire_itc/student_screen_page.dart';
import 'package:hire_itc/teacher_registeration.dart';


class ChooseAccount extends StatefulWidget {


  @override
  State createState() => new ChooseAccountState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class ChooseAccountState extends State<ChooseAccount> {

  AuthStatus authStatus = AuthStatus.notDetermined;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    FirebaseAuth.instance.currentUser().then((userId) {
      setState(() {
        if (!mounted) return; //prevent memory leaking
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }


  void get _displaySnackbar {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 30),
        content: Text('   سوف يتم ارسال رسالة التأكيد الى بريدك الاكتروني بعد 30 ثانية ' )
    ));
  }









  void _signedIn() {
    setState(() {
      if (!mounted) return;
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      if (!mounted) return;
      authStatus = AuthStatus.notSignedIn;
    });
  }



  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('التسجيل',textAlign: TextAlign.center,style: TextStyle(color: Colors.orange[500]),),
        backgroundColor: Colors.blueGrey[800],
        centerTitle:true ,
          automaticallyImplyLeading: false,
      ),

      backgroundColor: Colors.white,
      body: WillPopScope(
    //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
    onWillPop: () async {
    Future.value(
    false); //return a `Future` with false value so this route cant be popped or closed.
    },



     child: new Column(

        mainAxisAlignment:MainAxisAlignment.center,

                children: <Widget>[
                  new SizedBox(
                      width:250.0,
                      height: 50.0,
                  child:MaterialButton(
                    color: Colors.blueGrey[800],
                    splashColor: Colors.orange[500],
                    textColor: Colors.orange[500],
                    child: Row(
                      children: <Widget>[
                        new Icon(FontAwesomeIcons.user),
                        Container(width: 50.0,),
                        Text("تسجيل الطلاب ",style: TextStyle(color: Colors.white),),

                      ],
                    ),
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentRegister();}));


                    }
                  )),

                  Container(height: 40.0,),

                  new SizedBox(
                      width:250.0,
                      height: 50.0,
                  child: MaterialButton(
                    color: Colors.blueGrey[800],
                    splashColor: Colors.orange[500],
                    textColor: Colors.orange[500],
                    child: Row(
                      children: <Widget>[

                        new Icon(FontAwesomeIcons.globe
                        ),
                        Container(width: 50.0,),
                        Text("تسجيل المدرسين ",style: TextStyle(color: Colors.white)),

                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return TeacherRegister();}));

                    },
                  )),

                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          switch (authStatus) {
            case AuthStatus.notDetermined:
              return _buildWaitingScreen();
            case AuthStatus.notSignedIn:
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(

                    onSignedIn: _signedIn,
                  )));
            case AuthStatus.signedIn:
              return
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => StudentScreen(
                      onSignedOut: _signedOut,
                    )));



          }
          return null;

        },
        tooltip: 'تسجيل الدخول',
        backgroundColor: Colors.orange[500],
        child: Icon(FontAwesomeIcons.signInAlt, color: Colors.blueGrey[800],),
        elevation: 2.0,
      ),

 bottomNavigationBar : new Theme(

   data:Theme.of(context).copyWith(
     // sets the background color of the `BottomNavigationBar`
       canvasColor: Colors.blueGrey[800]),
   child:new BottomNavigationBar (

     items:  <BottomNavigationBarItem>[
       new BottomNavigationBarItem(
           icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[800] ,),
           title: Text('',style: TextStyle(color:Colors.blueGrey[800] , ),),
       ),
       new BottomNavigationBarItem(
         icon: Icon(Icons.arrow_drop_down,color:Colors.blueGrey[800] ,),
         title:  Text('',style: TextStyle(color:Colors.blueGrey[800] , ),),
       ),

     ],
     onTap: null,
      ),
    )
    );


  }











}



/*
@override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: pages(),
      bottomNavigationBar:new Container(
        color: Colors.green,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                title: new Text("Home")
            ),
            new BottomNavigationBarItem(
                icon: const Icon(Icons.work),
                title: new Text("Self Help")
            ),
            new BottomNavigationBarItem(
                icon: const Icon(Icons.face),
                title: new Text("Profile")
            )
          ],
        currentIndex: index,
        onTap: (int i){setState((){index = i;});},
        fixedColor: Colors.white,
        ),
      );
    );
  };
  new Theme(
      data: Theme.of(context).copyWith(
    // sets the background color of the `BottomNavigationBar`
    canvasColor: Colors.blueGrey[800],
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.orange[500]))),
    // sets the inactive color of the `BottomNavigationBar`
 */