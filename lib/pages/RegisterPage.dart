import 'package:artklub/pages/HomePage.dart';
import 'package:artklub/pages/LoginPage.dart';
import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/widgets/AppWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //To Toggle Password Text Visibility.
  bool _obscureText = true;
  late String _name, _phoneNumber, _emailId, _password;

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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              _showMascot(),
              Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppWidgets().getLogoWidget(),
                        _showMessage(),
                        _showNameInput(),
                        _showPhoneInput(),
                        _showEmailInput(),
                        _showPasswordInput(),
                        _showFormActions(),
                        _showLogin(),
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

  _showMessage() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 30, fontFamily: 'Roboto', shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ]),
          ),
        ),
        Text(
          '.',
          style: TextStyle(
            fontSize: 45,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        )
      ],
    );
  }

  _showNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          onSaved: (val) => _name = val!,
          validator: (val) => val!.isEmpty ? "Please provide name" : null,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow.withOpacity(0.2),
            labelText: "Name",
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            hintText: 'Enter Student Name',
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            prefixIcon: Icon(
              Icons.person,
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

  _showPhoneInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          onSaved: (val) => _phoneNumber = val!,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow.withOpacity(0.2),
            labelText: "Phone Number",
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            hintText: 'Enter Phone Number',
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            prefixIcon: Icon(
              Icons.phone,
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

  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (val) => _emailId = val!,
          validator: (val) => !(val!.contains("@") && val.contains("."))
              ? "Please provide valid Email Id"
              : null,
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
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          onSaved: (val) => _password = val!,
          validator: (val) => val!.length < 7
              ? "Password should have at least 7 characters "
              : null,
          obscureText: _obscureText,
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
                setState(
                  () {
                    _obscureText = !_obscureText;
                  },
                );
              },
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                )
              : ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.9, 50),
                      primary: Colors.yellow,
                      shadowColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _showLogin() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have Account?',
            style: TextStyle(
              fontFamily: 'Robto',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: LoginPage(),
                  duration: Duration(milliseconds: 500),
                ),
              );
            },
            child: Text(
              'Login',
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

  _showMascot() {
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

  _submit() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      _registerUser();
    } else {
      print("Form is Invalid");
    }
  }

  _registerUser() async {
    setState(() {
      _isSubmitting = true;
      EasyLoading.showSuccess('Registration Successful!');
    });

    AuthenticationService()
        .signUp(emailId: _emailId, password: _password)
        .then((result) {
      if (result == null) {
         _createStudentInDB();

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }

      setState(() {
        _isSubmitting = false;
        EasyLoading.dismiss();
      });
    });

  }

  _createStudentInDB() async{
    try{

      AuthenticationService().addStudent(
          AuthenticationService().getUser()!.uid,
          _name,
          _phoneNumber,
          _emailId,
      ).then((result){
        if(result == null){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });


    } catch(Error){
      print('Error');
    }

    setState(() {
      _isSubmitting = false;
    });

  }
}
