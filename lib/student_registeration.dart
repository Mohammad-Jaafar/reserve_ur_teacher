import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hire_itc/user_to_database.dart';
import 'package:flushbar/flushbar.dart';



class StudentRegister extends StatefulWidget {
  const StudentRegister({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  State createState() => new StudentRegisterState();
}

class StudentRegisterState extends State<StudentRegister> {

  TextEditingController _fullname= new TextEditingController();
  TextEditingController _schoolname= new TextEditingController();
  TextEditingController _number = new TextEditingController();

  TextEditingController _email = new TextEditingController();
  TextEditingController _pass1 = new TextEditingController();
  TextEditingController _pass2 = new TextEditingController();

  bool _isLoading = true;

  List<String> _locations = ['ذكر', 'انثى']; // Option 2
  String _gender;

  List<String> _locations2 = ['علمي', 'ادبي']; // Option 2
  String _department;

  List<String> _locations3 = ['احيائي', 'تطبيقي']; // Option 2
  String _secondepartment;


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



  void _signOut(BuildContext context) async {

    await FirebaseAuth.instance.signOut().then((value){

      _snack(title:"يرجى الأنتضار ",message: "  تم ارسال رسالة التأكيد الى بريدك الاكتروني",duration1: 10,);

      Future.delayed(Duration(seconds: 10), () => Navigator.of(context).pushReplacementNamed('/choose_account'));

    })
        .catchError((e)=>debugPrint(e.toString()));
    widget.onSignedOut();

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('تسجيل الطلاب', style: TextStyle(color: Colors.orange[500]),),
          backgroundColor: Colors.blueGrey[800],
          centerTitle: true,
        ),

        backgroundColor: Colors.white,
        body: new SingleChildScrollView(
    child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "الاسم الرباعي",
                fillColor: Colors.orange[500],
                icon: Icon(FontAwesomeIcons.user, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _fullname,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "اسم المدرسة",
                fillColor: Colors.orange[500],
                icon: Icon(FontAwesomeIcons.school, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _schoolname,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "رقم هاتفك",
                fillColor: Colors.orange[500],
                icon: Icon(FontAwesomeIcons.phone, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _number,
              keyboardType: TextInputType.phone,
            ),




            new TextFormField(
              decoration: new InputDecoration(
                labelText: "البريد الاكتروني",
                fillColor: Colors.orange[500],
                prefixStyle: new TextStyle(
                  color: Colors.orange[500],
                ),

                hintText: "ادخل حساب كوكل او اي حساب فعال",
                icon: Icon(Icons.email, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              style: TextStyle(
                color: Colors.blueGrey[800],
              ),
              autocorrect: true,

              controller: _email,
              keyboardType: TextInputType.emailAddress,
            ),


            new TextFormField(
              decoration: new InputDecoration(
                  labelText: "كلمة المرور",
                  icon: Icon(FontAwesomeIcons.key, color: Colors.orange[500],),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[500]),
                  )),
              controller: _pass1,
              obscureText: true,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                  labelText: " تاكيد كلمة المرور",
                  icon: Icon(FontAwesomeIcons.key, color: Colors.orange[500],),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[500]),
                  )),
              controller: _pass2,
              obscureText: true,
              keyboardType: TextInputType.text,
            ),

            new DropdownButton(

              icon: Icon(FontAwesomeIcons.genderless),
              style: TextStyle(color: Colors.orange[500],),
              hint: Text(' رجاءا اختر الجنس',style: TextStyle(color: Colors.orange[500],),), // Not necessary for Option 1
              value: _gender,
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),

            new DropdownButton(

              icon: Icon(FontAwesomeIcons.genderless),
              style: TextStyle(color: Colors.orange[500],),
              hint: Text(' رجاءا اختر القسم',style: TextStyle(color: Colors.orange[500],),), // Not necessary for Option 1
              value: _department,
              onChanged: (newValue) {
                setState(() {
                  _department = newValue;
                });
              },
              items: _locations2.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),

            new DropdownButton(

              icon: Icon(FontAwesomeIcons.genderless),
              style: TextStyle(color: Colors.orange[500],),
              hint: Text('رجاءا اختر احد اقسام العلمي',style: TextStyle(color: Colors.orange[500],),), // Not necessary for Option 1
              value: _secondepartment,
              onChanged: (newValue) {
                setState(() {
                  _secondepartment = newValue;
                });
              },
              items: _locations3.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),



          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(


          child: _isLoading ?
          Icon(FontAwesomeIcons.signInAlt, color: Colors.blueGrey[800],) :
          SizedBox(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey[800]),),width: 25.0,height: 25.0,),
          onPressed: () {

            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });

    if (_fullname.text.isNotEmpty && _schoolname.text.isNotEmpty
    && _gender.isNotEmpty && _number.text.isNotEmpty && _department.isNotEmpty && _secondepartment.isNotEmpty) {
      Firestore.instance
          .collection('students')
          .add({
        "fullname": _fullname.text,
        "schoolname": _schoolname.text,
        "gender": _gender,
        "firstdepartment":_department,
        "seconddepartment":_secondepartment,
        "number": _number.text,
      });
    }

            if(_pass2.text == _pass1.text){

    FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email.text, password: _pass2.text
    ).then((singedUser){


    UserToDatabase().addNewUser(singedUser, context);
    singedUser.sendEmailVerification();
    _signOut(context);


    }).catchError((e){
    print(e);
    });

    }
            else{

              setState(() {
                if (!mounted) return;
                _isLoading = true;
              });
              return _snack(title: "تحذير",message: "عدم تطابق كلمة المرور ",duration1: 3);
            }

    },
          tooltip: 'تسجيل',
          backgroundColor: Colors.orange[500],
          elevation: 2.0,
        ),

        bottomNavigationBar: new Theme(

          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blueGrey[800]),
          child: new BottomNavigationBar (

            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[800],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[800],),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[800],),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[800],),),
              ),

            ],
            onTap: null,
          ),
        )
    );
  }

//






}



/*
var auth = firebase.auth();
var emailAddress = "<Mail_id >";

auth.sendPasswordResetEmail(emailAddress).then(function() {
  // Email sent.
    console.log("welcome")
}).catch(function(error) {
  // An error happened.
});
 */


//  @override
//  initState() {
//    _firstname = new TextEditingController();
//    _secondname = new TextEditingController();
//    _lastname = new TextEditingController();
//    _surname = new TextEditingController();
//    _email = new TextEditingController();
//    _pass1 = new TextEditingController();
//    _pass2 = new TextEditingController();


//    subscription = documentReference.snapshots().listen((datasnapshot) {
//      if (datasnapshot.exists) {
//        setState(() {
//          _email.text = datasnapshot.data['email'];
//        });
//      }
//    });
//


//    super.initState();
//  }


//
//  final DocumentReference documentReference =
//  Firestore.instance.document("student");


//  void _delete() {
//    documentReference.delete().whenComplete(() {
//      print("Deleted Successfully");
//      setState(() {});
//    }).catchError((e) => print(e));
//  }
//
//  void _update() {
//    Map<String, String> data = <String, String>{
//      "name": "Pawan Kumar Updated",
//      "desc": "Flutter Developer Updated"
//    };
//    documentReference.updateData(data).whenComplete(() {
//      print("Document Updated");
//    }).catchError((e) => print(e));
//  }
//
//  void _fetch() {
//    documentReference.get().then((datasnapshot) {
//      if (datasnapshot.exists) {
//        setState(() {
//
//        });
//      }
//      else{
//        print('error');
//      }
//    });
//  }


//

// to avoid memory leak dispose of subscription ....

/*
const SizedBox(height: 7.0),
                new Container(
              padding: const EdgeInsets.only(left: 15.0),
              color: Colors.white,
              child:
 */