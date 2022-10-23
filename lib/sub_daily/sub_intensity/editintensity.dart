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

class EditIntens extends StatefulWidget {
  final String intenseID;
  final String intensamount;

  const EditIntens({
    Key? key,
    required this.intenseID,
    required this.intensamount,
  }) : super(key: key);

  @override
  State<EditIntens> createState() => _EditHumidState();
}

class _EditHumidState extends State<EditIntens> {

  //variable
  final intensamountController = TextEditingController();

  Future EditIntens() async {
    try {
      var url = Uri.parse(
          'https://meloned.relaxlikes.com/api/dailycare/edit_intense.php');
      var response = await http.post(url, body: {
        'intens_ID': widget.intenseID,
        'lux': intensamountController.text,
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

  //Delete Intensity
  Future RemoveIntense(String intense_ID) async {
    try {
      var url = "https://meloned.relaxlikes.com/api/dailycare/delete_intense.php";
      var response = await http.post(Uri.parse(url), body: {
        'intense_ID': intense_ID,
      });

      var jsonData = json.decode(response.body);

      if (jsonData == "Failed No Data") {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.intenseID);
    print(widget.intensamount);
    intensamountController.text = widget.intensamount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขค่าความเข้มแสง'),
        actions: [
          IconButton(
            onPressed: () {
              RemoveIntense(widget.intenseID);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ความเข้มแสง',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              FormList(
                controller: intensamountController,
                hintText: 'ความเข้มแสง',
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
                          EditIntens();
                          Navigator.pop(context);
                        });
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
