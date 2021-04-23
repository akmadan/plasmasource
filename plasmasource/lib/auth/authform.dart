import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plasmasource/auth/otp.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //------------------------------------------------
  final _formkey = GlobalKey<FormState>();

  var phone = '';

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
     
      child: Column(
        children: [
          logo(),
          Container(
            child: Column(children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png')),
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(height: 10),
              bold_text(text: 'PlasmaSource', color: Colors.grey[800], size: 24)
            ]),
          ),
          SizedBox(height: 10),
          modified_text(text:'Your One Donation can Save Many Lives', size:16),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  //---------------- PHONE ----------------------
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400.withOpacity(0.2),
                    ),
                    padding: EdgeInsets.all(10),
                    height: 70,
                    child: Center(
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Enter 10 digit Contact No.",
                        ),
                        key: ValueKey('phone'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Incorrect Phone';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phone = value;
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),

                  //---------------- PHONE ----------------------
                ],
              ),
            ),
          ),
          Container(

            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: RaisedButton(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  trysubmit();
                },
                child: bold_text(
                  text: "Next",
                  size: 18,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
