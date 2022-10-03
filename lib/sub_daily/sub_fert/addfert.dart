import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import '/reuse/bottombar.dart';
import '/reuse/container.dart';
import '/reuse/hamburger.dart';
import '/sub_daily/sub_fert/fertdropdown.dart';
import '../../reuse/sizedbox.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';


class AddFert extends StatefulWidget {
  const AddFert({Key? key}) : super(key: key);

  @override
  State<AddFert> createState() => _AddFertState();
}

class _AddFertState extends State<AddFert> {
  //Session
  dynamic period_ID;
  dynamic selectValfertID;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    setState(() {
      period_ID = id.toString();
    });
  }

  getSessionFert() async {
    dynamic fert_id = await SessionManager().get("fert_ID");
    setState(() {
      selectValfertID = fert_id.toString();
      print("Get Session FERT FERTID ON ADDFERT " + selectValfertID);
    });
  }

  insertFert() async {
    await getSessionFert();
    await addfert(selectValfertID, period_ID);
  }

  Future addfert(String fert_ID, String period_ID) async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/dailycare/insert_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        'fert_ID': fert_ID,
        'ferting_amount': fertamountController.text,
        'period_ID': period_ID,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "เพิ่มข้อมูลสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          fertamountController.clear();
          Navigator.pop(context, true);
        });
      } else if (data == "Failed") {
        Fluttertoast.showToast(
            msg: "เพิ่มข้อมูลไม่สำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (data == "Failed No Data") {
        Fluttertoast.showToast(
            msg: "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  final fertnameController = TextEditingController();
  final fertamountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มการให้ปุ๋ย'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                'ชื่อปุ๋ย',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              DropDownList2(
                  //Get value from dropdown

                  ),
              sizedBox.Boxh10(),
              Text(
                'ปริมาณ',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              FormList(
                controller: fertamountController,
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
                        insertFert();
                        setState(() {});
                      },
                      child: Text('ยืนยัน', style: TextCustom.buttontext()),
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
                        //back and refresh previous page
                        Navigator.pop(context, true);
                        setState(() {});
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
