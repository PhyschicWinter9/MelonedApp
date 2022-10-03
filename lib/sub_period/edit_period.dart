import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import '../menu.dart';
import '../period.dart';
import '../daily.dart';
import '../analyze.dart';
import '../reuse/bottombar.dart';
import '../style/colortheme.dart';
import '../summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EditPeriodSetting extends StatefulWidget {
  final List list;
  final int index;

  EditPeriodSetting({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  State<EditPeriodSetting> createState() => _NewPeriodState();
}

class _NewPeriodState extends State<EditPeriodSetting> {
  //Variable

  //Controller
  final periodnameController = TextEditingController();
  final plantedmelonController = TextEditingController();

  //GET REGISTERED GREENHOUSE
  Future EditSettingPeriodAPI() async {
    var url = "https://meloned.relaxlikes.com/api/period/edit_period.php";

    var response = await http.post(Uri.parse(url), body: {
      "period_ID": widget.list[widget.index]['period_ID'],
      'planted_melon': plantedmelonController.text,
      'period_name': periodnameController.text,
    });

    var jsonData = json.decode(response.body);
    print(jsonData);

    if (jsonData == "Failed") {
      Fluttertoast.showToast(
        msg: "แก้ไขข้อมูลไม่สำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "แก้ไขข้อมูลสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    }
  }

  //Delete Period
  Future deletePeriod(String period_ID) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/period/deleteperiod.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': widget.list[widget.index]['period_ID'],
      });
      var data = json.decode(response.body);
      // print(data);
      if (data == "Success") {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // getdata();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Period()),
        // );
        Navigator.pop(context);
        setState(() {});
      } else {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    periodnameController.text = widget.list[widget.index]['period_name'];
    plantedmelonController.text = widget.list[widget.index]['planted_melon'];
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        title: Text(
          'แก้ไขรอบการปลูก',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                print(widget.list[widget.index]['period_ID']);
                deletePeriod(widget.list[widget.index]['period_ID']);
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      
      /*______Hamburger Button______*/
      drawer: Hamburger(),

      body: BGContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อรอบการปลูก',
              style: GoogleFonts.kanit(
                  fontSize: 18, color: Color.fromRGBO(116, 116, 39, 1)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, right: 20),
              ),
              controller: periodnameController,
              style: TextCustom.normal_mdg16(),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'จำนวนเมลอน',
              style: TextCustom.normal_dg18(),
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, right: 20),
              ),
              controller: plantedmelonController,
              style: TextCustom.normal_mdg16(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      EditSettingPeriodAPI();
                      setState(() {
                        Navigator.pop(context, true);
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
                SizedBox(
                  width: 15,
                ),
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
      bottomNavigationBar: BottomBar(),
    );
  }
}