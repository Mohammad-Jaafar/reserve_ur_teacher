import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hire_itc/student_screen_page.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;


  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
      with SingleTickerProviderStateMixin {


    bool _isLoading=true;

    TextEditingController _email = new TextEditingController();
    TextEditingController _pass2 = new TextEditingController();



    void  _snack({String title,String message,int duration1}) {

      Flushbar(
        title: title,
        message: message,
        icon: Icon(Icons.warning,color: Colors.orange[500],),
        duration: Duration(seconds: duration1 ),
        backgroundColor:Colors.blueGrey[800],
        flushbarPosition: FlushbarPosition.TOP,
      )
        ..show(context);


    }




    @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body:
        new Stack(fit: StackFit.expand,
            children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/logo_bg.png"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          new Theme(
            data: new ThemeData(
                brightness: Brightness.dark,
                inputDecorationTheme: new InputDecorationTheme(
                  // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                  labelStyle:
                  new TextStyle(color: Colors.orange[500], fontSize: 25.0),
                  fillColor: Colors.orange[500],
                )),
            isMaterialAppTheme: true,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Form(
                    autovalidate: true,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Enter Email",
                              fillColor: Colors.orange[500],
                            icon: Icon(FontAwesomeIcons.user,color: Colors.orange[500],),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[500]),
                            ),
                          ),
                          validator: (value) => value.isEmpty ? 'تحذير : لا يمكن ان تكون خالية' : null,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,

                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                            icon: Icon(FontAwesomeIcons.key,color: Colors.orange[500],),
                       focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.orange[500]),
                       )),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (value) => value.isEmpty ? 'تحذير : لا يمكن ان تكون خالية' : null,
                          controller: _pass2,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                        ),
                        new MaterialButton(
                          height: 50.0,
                          minWidth: 150.0,
                          color: Colors.orange[500],
                          splashColor: Colors.orange[500],
                          textColor: Colors.blueGrey[800],
                          child: _isLoading ? Icon(FontAwesomeIcons.signInAlt) : SizedBox(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey[800]),),width: 25.0,height: 25.0,),
                          onPressed: () {

                            setState(() {
                              if (!mounted) return;
                              _isLoading = false;
                            });

                            FirebaseAuth.instance.signInWithEmailAndPassword(email:_email.text,password:_pass2.text

                            ).then((user){

                              setState(() {
                                if (!mounted) return;
                                _isLoading = true;
                              });
                              if(user.isEmailVerified){
                              Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (context) => StudentScreen())

                              );
                              widget.onSignedIn();
                              }
                              else{
                                setState(() {
                                  if (!mounted) return;
                                  _isLoading = true;
                                });
                              return  _snack(title: "تحذير",message: "قم بتأكيد حسابك عن طريق بريدك الاكتروني",duration1: 5);
                              }
                            }).catchError((e) => _snack(title: "تحذير",message: "تأكد من بريدك الاكتروني أو كلمة المرور",duration1: 5));

                          }
                            ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      );
    }





  //  void _showDialog() {
  //    // flutter defined function
  //    showDialog(
  //      context: context,
  //      builder: (BuildContext context) {
  //        // return object of type Dialog
  //        return AlertDialog(
  //          title: new Text("Alert Dialog title"),
  //          content: new Text("Alert Dialog body"),
  //          actions: <Widget>[
  //            // usually buttons at the bottom of the dialog
  //            new FlatButton(
  //              child: new Text("Close"),
  //              onPressed: () {
  //                Navigator.of(context).pop();
  //              },
  //            ),
  //          ],
  //        );
  //      },
  //    );
  //  }

  //  var auth = firebase.auth();
  //  var emailAddress = "<Mail_id >";
  //
  //  auth.sendPasswordResetEmail(emailAddress).then(function() {
  //    // Email sent.
  //    console.log("welcome")
  //  }).catch(function(error) {
  //    // An error happened.
  //  });
  }