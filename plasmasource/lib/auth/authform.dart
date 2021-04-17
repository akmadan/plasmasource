import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plasmasource/auth/otp.dart';
import 'package:plasmasource/utils/text.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //------------------------------------------------
  final _formkey = GlobalKey<FormState>();
  var isLoginpage = false;
  var phone = '';

  var firstname = '';
  var lastname = '';

  //------------------------------------------------

  void login() async {
    //   final isValid = _formkey.currentState.validate();
    //   FocusScope.of(context).unfocus();
    //   if (isValid) {
    //     _formkey.currentState.save();
    //     final _auth = FirebaseAuth.instance;
    //     // UserCredential authresult;
    //     try {
    //       await _auth.signInWithEmailAndPassword(
    //           email: email, password: password);
    //     } on PlatformException catch (err) {
    //       var message = 'An error occured';
    //       if (err.message != null) {
    //         message = err.message;
    //       }

    //       Scaffold.of(context).showSnackBar(SnackBar(
    //         content: Text(message),
    //         backgroundColor: Colors.red,
    //       ));
    //     } catch (err) {
    //       print(err);
    //     }
    //   }
  }

  //----------------------------------------------
  void trysubmit() async {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTPScreen(phone)));
    }
  }

  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          // authimage(),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  //----------------- NAME -----------------------
                  if (!isLoginpage)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('firstname'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'First Name should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide()),
                                labelText: "First Name",
                                labelStyle: TextStyle(fontFamily: 'SFPro')),
                            onSaved: (value) {
                              firstname = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('lastname'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Last Name should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide()),
                                labelText: "Last Name",
                                labelStyle: TextStyle(fontFamily: 'SFPro')),
                            onSaved: (value) {
                              lastname = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  //----------------- NAME -----------------------

                  //---------------- PHONE ----------------------
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    key: ValueKey('phone'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Incorrect Phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide()),
                        labelText: "Enter Phone",
                        labelStyle: GoogleFonts.roboto()),
                    onSaved: (value) {
                      phone = value;
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),

                  //---------------- PHONE ----------------------
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  isLoginpage ? login() : trysubmit();
                },
                child: isLoginpage
                    ? bold_text(
                        text: "Login",
                        size: 18,
                        color: Colors.white,
                      )
                    : bold_text(
                        text: "Next",
                        size: 18,
                        color: Colors.white,
                      )),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isLoginpage = !isLoginpage;
              });
            },
            child: Text(
              isLoginpage
                  ? 'New to PlasmaSource ? Create account'
                  : 'Already have an account ? Login',
              style: TextStyle(
                  fontFamily: 'SFPro', color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
