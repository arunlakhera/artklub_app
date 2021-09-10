import 'package:artklub/services/AuthenticationService.dart';
import 'package:artklub/utilities/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _emailAddress;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.pageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/mascot.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Reset your Password.',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 25,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please enter your email Id. We will send a link to your registered email Id to reset the password.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (val) => _emailAddress = val!,
                        validator: (val) => val!.isEmpty
                            ? "Please provide registered email Id"
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                          fillColor: Colors.yellow.withOpacity(0.2),
                          filled: true,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter your registered email Id',
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
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    _isSubmitting
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.green,
                          ))
                        : ElevatedButton(
                            onPressed: () {
                              print('Hello');
                              _submitRequest();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                fixedSize: Size(screenWidth - 20.0, 50.0),
                                primary: Colors.yellow,
                                shadowColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(
                              'Send Me Link',
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitRequest() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      _resetPassword(_emailAddress);
    } else {
      print("Form is Invalid");
    }
  }

  Future<void> _resetPassword(String emailAddress) async {
    setState(() {
      _isSubmitting = true;
    });
    String passwordResetMessage = '';
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(email: _emailAddress)
          .then((value) => passwordResetMessage =
              'Password Reset Link has been sent to your registered Email Id.')
          .catchError((onError) => passwordResetMessage =
              'Could not send Password Reset Link. Please try again later.');
    } on FirebaseException catch (e) {
      passwordResetMessage =
          'Could not send Password Reset Link. Please try again later.';
    }

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          passwordResetMessage,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
