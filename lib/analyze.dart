import 'package:flutter/material.dart';
import 'menu.dart';
import 'period.dart';
import 'daily.dart';
import 'summary.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';

class Analyze extends StatefulWidget {
  const Analyze({Key? key}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quality Analyze',),
      ),
      drawer: Hamburger(),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(251, 249, 218, 1),
                height: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo_camera,
                          size: 50,
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      ////////////////////////////////////////////////
                      //ปุ่มวิเคราะห์
                      ////////////////////////////////////////////////
                      onPressed: () {},
                      child: Text(
                        "วิเคราะห์ภาพ",
                        style: TextStyle(
                          color: Color.fromARGB(172, 112, 79, 1),
                          fontSize: 20,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 214, 104, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}