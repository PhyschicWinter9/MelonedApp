import 'package:flutter/material.dart';
import '../style/textstyle.dart';
import '../style/colortheme.dart';
import 'signuplist.dart';

//รวม textfield และ label ของหน้า sign up
class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextCustom.textboxlabel(),
          ),
          SizedBox(
            height: 5,
          ),
          SignUpList(
            controller: nameController,
            hintText: 'Name Surname',
            hideText: false,
            icon: Icon(
              Icons.badge,
              color: ColorCustom.lightgreencolor(),
            )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Email',
            style: TextCustom.textboxlabel(),
          ),
          SizedBox(
            height: 5,
          ),
          SignUpList(
            controller: emailController,
            hintText: 'Email',
            hideText: false,
            icon: Icon(
              Icons.email,
              color: ColorCustom.lightgreencolor(),
            )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Username',
            style: TextCustom.textboxlabel(),
          ),
          SizedBox(
            height: 5,
          ),
          SignUpList(
            controller: usernameController,
            hintText: 'Username',
            hideText: false,
            icon: Icon(
              Icons.account_circle,
              color: ColorCustom.lightgreencolor(),
            )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Password',
            style: TextCustom.textboxlabel(),
          ),
          SizedBox(
            height: 5,
          ),
          SignUpList(
            controller: passwordController,
            hintText: 'Password',
            hideText: false,
            icon: Icon(
              Icons.key,
              color: ColorCustom.lightgreencolor(),
            )
          ),
        ]
      )
    );
  }
}
