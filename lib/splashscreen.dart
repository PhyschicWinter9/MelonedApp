import 'dart:async';
import 'dart:io';
import 'menu.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      //Request permission to access location
      Permission.location,
      //Request permission to access storage
      Permission.accessMediaLocation,
      Permission.manageExternalStorage,
      Permission.storage,
      //Request permission to access camera
      Permission.camera,
    ].request();
  }

  //internet connection check function here and Showdialog if no internet
  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      //if internet connection is available
      //then navigate to home screen
      Future.delayed(const Duration(seconds: 6), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainMenu()));
      });
    } else {
      //if internet connection is not available
      //then show dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowDialogConnection();
          });
    }
  }

  //Cheack Internet Connection after Checking Permission
  Future<void> checkPermissionAndInternet() async {
    await checkPermission();
    await checkInternet();
  }

  @override
  void initState() {
    super.initState();
    //Cheack Internet Connection after Checking Permission
    checkPermissionAndInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(116, 116, 39, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(251, 249, 218, 1),
                ),
                padding: EdgeInsets.all(30),
                child: Image.asset(
                  'assets/icon/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'MELO',
                          style: GoogleFonts.kanit(
                            fontSize: 50,
                            color: Color.fromRGBO(245, 176, 103, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'NED',
                          style: GoogleFonts.kanit(
                              fontSize: 50,
                              color: Color.fromRGBO(227, 209, 106, 1),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                //loading animation
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Color.fromRGBO(227, 209, 106, 1),
                      size: 65,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'กำลังเริ่มต้น...',
                      style: GoogleFonts.kanit(
                        fontSize: 20,
                        color: Color.fromRGBO(227, 209, 106, 1),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDialogConnection extends StatelessWidget {
  const ShowDialogConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ไม่มีการเชื่อมต่ออินเตอร์เน็ต',style: GoogleFonts.kanit()),
      content: Text('โปรดเชื่อมต่ออินเตอร์เน็ตและลองอีกครั้ง',style: GoogleFonts.kanit(),),
      actions: [
        TextButton(
          onPressed: () {
            //Close App
            exit(0);
          },
          child: Text('ตกลง',style: GoogleFonts.kanit(),),
        )
      ],
    );
  }
}
