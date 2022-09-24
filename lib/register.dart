import 'package:flutter/material.dart';
import 'style/textstyle.dart';
import 'sub_register/signupform.dart';
import 'sub_register/logotext.dart';
import 'sub_register/agree.dart';
import 'sub_register/signup_button.dart';

//หน้า register
class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(50,30,50,30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogoText(),
                SizedBox(
                  height: 15,
                ),
                Text('Sign Up',
                  style: TextCustom.heading2(),
                ),
                SizedBox(
                  height: 15,
                ),
                SignUpForm(),
                AgreeTerms(),
                SizedBox(
                  height: 5,
                ),
                SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



