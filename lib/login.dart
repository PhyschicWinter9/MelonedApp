import 'package:flutter/material.dart';
import 'style/textstyle.dart';
import 'sub_login/form.dart';
import 'sub_login/signinSignupBtn.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyWidgetLogin();
}

class _MyWidgetLogin extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void testfunc() {
    print("aa");
  }

  void register_route() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width) * 0.8,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: Container(
                        padding: EdgeInsets.all(25),
                        color: Color.fromRGBO(251, 249, 218, 1),
                        child: Image.asset(
                          'assets/icon/icon.png',
                          height: 180,
                          width: 180,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MELO',
                          style: TextCustom.logofont1(),
                        ),
                        Text(
                          'NED',
                          style: TextCustom.logofont2(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputForm(
                      controller: usernameController,
                      hintText: "Username",
                      hideText: false,
                      icon: Icon(Icons.account_circle),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputForm(
                      controller: passwordController,
                      hintText: "Password",
                      hideText: true,
                      icon: Icon(Icons.key),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SignBtn(
                        callback: testfunc,
                        title: "Sign In",
                        color: Color.fromRGBO(159, 159, 54, 1)),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 20),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                              height: 50,
                            ),
                          ),
                        ),
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.brown),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SignBtn(
                        callback: register_route,
                        title: "Sign up",
                        color: Color.fromRGBO(245, 176, 103, 1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
