import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/reuse/bottombar.dart';
import '/reuse/container.dart';
import '/reuse/hamburger.dart';
import '/sub_daily/sub_fert/fertdropdown.dart';
import '../../reuse/sizedbox.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddHumid extends StatefulWidget {
  final String periodID;

  AddHumid({
    Key? key,
    required this.periodID,
  }) : super(key: key);

  @override
  State<AddHumid> createState() => _AddHumidState();
}

class _AddHumidState extends State<AddHumid> {
  //variable
  final wateramountController = TextEditingController();

  Future AddHumid(String period_ID) async {
    var url =
        "https://meloned.relaxlikes.com/api/dailycare/insert_watering.php";
    var response = await http.post(Uri.parse(url), body: {
      'period_ID': period_ID,
      'ml': wateramountController.text,
    });

    var jsonData = json.decode(response.body);

    if (jsonData == "Failed") {
      Fluttertoast.showToast(
        msg: "เพิ่มข้อมูลไม่สำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "เพิ่มข้อมูลสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );

    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มค่าความชื้น'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ปริมาณ',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              FormList(
                controller: wateramountController,
                hintText: 'ปริมาณ',
                hideText: false,
              ),
              sizedBox.Boxh10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          AddHumid(widget.periodID);
                          Navigator.pop(context);
                        });
                        //Alertbox Confirm
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       title: Text('แก้ไขข้อมูล',
                        //           style: TextCustom.pureKanit()),
                        //       content: Text('คุณต้องการแก้ไขข้อมูลใช่หรือไม่',
                        //           style: TextCustom.pureKanit()),
                        //       actions: [
                        //         TextButton(
                        //           onPressed: () {
                        //             setState(() {
                        //               AddHumid();
                        //               Navigator.pop(context);
                        //               Navigator.pop(context);
                        //             });
                        //           },
                        //           child: Text('ตกลง',
                        //               style: TextCustom.pureKanit()),
                        //         ),
                        //         TextButton(
                        //           onPressed: () {
                        //             Navigator.pop(context);
                        //           },
                        //           child: Text('ยกเลิก',
                        //               style: TextCustom.pureKanit()),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                      child: Text('บันทึก', style: TextCustom.buttontext()),
                      style: ElevatedButton.styleFrom(
                        primary: ColorCustom.mediumgreencolor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  sizedBox.Boxw10(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ยกเลิก',
                        style: TextCustom.buttontext(),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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

class FormList extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hideText;
  FormList({
    required this.controller,
    required this.hintText,
    required this.hideText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: hideText,
      cursorColor: ColorCustom.darkgreencolor(),
      style: TextCustom.normal_mdg16(),
    );
  }
}
