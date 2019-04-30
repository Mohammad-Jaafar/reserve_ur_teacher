import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hire_itc/user_to_database.dart';
import 'package:flushbar/flushbar.dart';



class TeacherRegister extends StatefulWidget {
  const TeacherRegister({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  State createState() => new TeacherRegisterState();
}

class TeacherRegisterState extends State<TeacherRegister> {

  TextEditingController _fullname= new TextEditingController();
  TextEditingController _academicqualify= new TextEditingController();
  TextEditingController _number= new TextEditingController();
  TextEditingController  _address  = new TextEditingController();
  TextEditingController _experience= new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass1 = new TextEditingController();
  TextEditingController _pass2 = new TextEditingController();

  bool _isLoading = true;



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

      _snack(title:"يرجى الأنتضار ",message: "  تم ارسال رسالة التأكيد الى بريدك الاكتروني",duration1: 12,);

      Future.delayed(Duration(seconds: 10), () => Navigator.of(context).pushReplacementNamed('/choose_account'));

    })
        .catchError((e)=>debugPrint(e.toString()));
    widget.onSignedOut();

  }

  List<String> _locations = ['ذكر', 'انثى']; // Option 2
  String _gender;

  List<String> _subjects = ['الاسلامية', 'عربي','رياضيات','English','French','احياء','فيزياء','كيمياء','اجتماعيات','اقتصاد']; // Option 2
  String _subject;




  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange[500], //change your color here
          ),
          title: Text('تسجيل المدرسين', style: TextStyle(color: Colors.orange[500]),),
          backgroundColor: Colors.blueGrey[800],
          centerTitle: true,
        ),

        backgroundColor: Colors.white,
        body:
         new SingleChildScrollView(
        child:new Column(

          children: <Widget>[

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "الاسم الكامل",
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
                hintText: "المؤهل",
                labelText: "التحصيل الدراسي",
                fillColor: Colors.orange[500],
                icon: Icon(FontAwesomeIcons.graduationCap, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _academicqualify,
              keyboardType: TextInputType.text,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "رقم هاتفك ",
                fillColor: Colors.orange[500],
                icon: Icon(FontAwesomeIcons.phone, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _number,
              keyboardType: TextInputType.number,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "عدد سنوات الخبرة",
                fillColor: Colors.orange[500],
                icon: Icon(Icons.beenhere, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _experience,
              keyboardType: TextInputType.number,
            ),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "العنوان",
                fillColor: Colors.orange[500],
                icon: Icon(Icons.add_location, color: Colors.orange[500],),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[500]),
                ),
              ),
              controller: _address,
              keyboardType: TextInputType.text,
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
              hint: Text(' رجاءا اختر مادة التدريس',style: TextStyle(color: Colors.orange[500],),), // Not necessary for Option 1
              value: _subject,
              onChanged: (newValue) {
                setState(() {
                  _subject = newValue;
                });
              },
              items: _subjects.map((location) { //map iterable across all index
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

            if (_fullname.text.isNotEmpty && _academicqualify.text.isNotEmpty
                && _number.text.isNotEmpty && _experience.text.isNotEmpty && _address.text.isNotEmpty
                && _gender.isNotEmpty && _subject.isNotEmpty
            ) {
              Firestore.instance
                  .collection('teachers')
                  .add({
                "fullname": _fullname.text,
                "academicqualification": _academicqualify.text,
                "number": _number.text,
                "address": _address,
                "subject":_subject,
                "gender" :_gender,
                "yearsofexperience": _experience.text,
              });
            }

            if(_pass2.text == _pass1.text){

              FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email.text, password: _pass2.text
              ).then((singedUser){
                setState(() {
                  if (!mounted) return;
                  _isLoading = true;
                });

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







}



