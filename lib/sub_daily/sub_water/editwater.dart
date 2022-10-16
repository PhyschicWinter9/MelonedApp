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

class EditWater extends StatefulWidget {
  final String waterid;
  final String wateramount;

  const EditWater({
    Key? key,
    required this.waterid,
    required this.wateramount,
  }) : super(key: key);

  @override
  State<EditWater> createState() => _EditWaterState();
}

class _EditWaterState extends State<EditWater> {

  //variable
  final wateramountController = TextEditingController();

  Future EditWater() async {
    try {
      var url = Uri.parse(
          'https://meloned.relaxlikes.com/api/dailycare/edit_watering.php');
      var response = await http.post(url, body: {
        'water_ID': widget.waterid,
        'ml': wateramountController.text,
      });
      var data = jsonDecode(response.body);
      // return data;
      //Success show toast
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "แก้ไขข้อมูลสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: "แก้ไขข้อมูลไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.waterid);
    print(widget.wateramount);
    wateramountController.text = widget.wateramount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขการให้น้ำ'),
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
                          EditWater();
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
                        //               EditWater();
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
