import 'package:artklub/pages/ForgotPasswordPage.dart';
import 'package:artklub/pages/HomePage.dart';
import 'package:artklub/pages/RegisterPage.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/widgets/AppWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscureText = true;
  late String _emailId, _password;
  late bool _isSubmitting = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [

              _showMascot(),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppWidgets().getLogoWidget(),
                        _showMessage(),
                        _showEmailInput(),
                        _showPasswordInput(),
                        _showForgotPassword(),
                        _showFormActions(),
                        _showRegister(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showMessage(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Text(
            'Hello',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ]
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: [
              Text(
                'There',
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]
                ),
              ),
              Text(
                '.',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          onSaved: (val) => _emailId = val!,
          validator: (val) => (!val.toString().contains("@") || val!.length < 1) ? "Please provide valid Email Id" : null,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow.withOpacity(0.2),
            labelText: "Email",
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            hintText: 'Enter your email Id',
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.green,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),

          ),
        ),
      ),
    );
  }

  _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20 ,left: 10,right: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow.withOpacity(0.2),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green,
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),

            hintText: 'Enter your password',
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey.shade400,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),

            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                },);
              },
              child:
              Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.green,),
            ),
          ),

          onSaved: (val) => _password = val!,
          validator: (val) => val.toString().length < 7 ? "Password Is Too Short" : null,
          obscureText: _obscureText,

        ),
      ),
    );
  }

  _showForgotPassword(){
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10,right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ForgotPasswordPage(),
              ),
            );
          },
          child: Text(
            'Forgot Password',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
              decoration: TextDecoration.underline,
              shadows: [
                Shadow(
                  color: Colors.grey,
                  offset: Offset(1,0),
                  blurRadius: 1,
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          )
              : ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
                  primary: Colors.yellow,
                  shadowColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
          ),
        ],
      ),
    );
  }

  _showMascot(){
    return Positioned(
      bottom: 0,
      child: Opacity(
        opacity: 0.2,
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/mascot.png',
              height: 80,
              width: 80,
            ),
          ),
        ),
      ),
    );
  }

  _showRegister(){
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New to ArtKlub?',
            style: TextStyle(
              fontFamily: 'Robto',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
              });
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: RegisterPage(),
                  duration: Duration(milliseconds: 500),
                ),
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                fontFamily: 'Robot',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      _loginUser();
    } else {
      print("Form is Invalid");
    }
  }

  _loginUser() async {
    setState(() {
      _isSubmitting = true;
      EasyLoading.showSuccess('Login Success!');
    });

    AuthenticationService()
        .signIn(emailId: _emailId, password: _password)
        .then((result) {
      if (result == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });

    setState(() {
      _isSubmitting = false;
      EasyLoading.dismiss();
    });
  }

}
