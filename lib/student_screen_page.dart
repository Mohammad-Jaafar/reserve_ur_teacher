import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'choose_account.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({this.onSignedOut});
  final VoidCallback onSignedOut;





  Future<ChooseAccount> _signOut(BuildContext context) async {

    await FirebaseAuth.instance.signOut().catchError((e)=>debugPrint(e.toString()));
    onSignedOut();
    return Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => ChooseAccount()
        ));
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('الرئيسية',textAlign: TextAlign.center,style: TextStyle(color: Colors.orange[500]),),
          backgroundColor: Colors.blueGrey[800],
          centerTitle:true ,
        ),

        backgroundColor: Colors.white,
        body: new Card(

        child: Column(

          mainAxisAlignment:MainAxisAlignment.start,

          children: <Widget>[
         Image(
           image: AssetImage("assets/images/stpage.png"),
           fit: BoxFit.cover,
         ),


         FlatButton(
           child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.orange[500])),
           onPressed: () {

             _signOut(context);

             Navigator.of(context).pushReplacement(
                 new MaterialPageRoute(
                     builder: (context) => ChooseAccount())
             );

             },
         )


          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: (){},

          tooltip: 'تسجيل الدخول',
          backgroundColor: Colors.orange[500],
          child:
          Icon(FontAwesomeIcons.signInAlt,color: Colors.blueGrey[800],),
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
void showDialogSingleButton(BuildContext context, String title, String message, String buttonLabel) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(buttonLabel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
 */