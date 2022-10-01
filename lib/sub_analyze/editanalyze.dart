import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../reuse/bottombar.dart';
import '../reuse/container.dart';
import '../reuse/hamburger.dart';

class EditAnalyze extends StatefulWidget {
  const EditAnalyze({Key? key}) : super(key: key);

  @override
  State<EditAnalyze> createState() => _EditAnalyzeState();
}

class _EditAnalyzeState extends State<EditAnalyze> {
  Future editPeriod(
    String period_ID,
    String gradeA,
    String gradeB,
    String gradeC,
  ) async {
    var url = Uri.parse(
        "https://meloned.relaxlikes.com/api/analysis/update_manual.php");
    var response = await http.post(url, body: {
      'period_ID': period_ID,
      'gradeA': gradeA,
      'gradeB': gradeB,
      'gradeC': gradeC,
    });
    var data = jsonDecode(response.body);
    if (data == "Success") {
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
    } else {
      Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาด",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  final gradeA_Controller = TextEditingController();
  final gradeB_Controller = TextEditingController();
  final gradeC_Controller = TextEditingController();
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List list = data['melonList'];
    String period_ID = list[0];
    String period_name = list[1];
    String planted_melon = list[2];
    String total_grades = list[3];
    gradeA_Controller.text = list[4];
    gradeB_Controller.text = list[5];
    gradeC_Controller.text = list[6];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูลการวิเคราะห์',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            Card(
              elevation: 2,
              color: ColorCustom.lightyellowcolor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${period_name}',
                      style: TextCustom.bold_b20(),
                    ),
                    sizedBox.Boxh15(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนทั้งหมด', style: TextCustom.normal_dg16()),
                        Text('${total_grades}/${planted_melon}',
                            style: TextCustom.normal_b16()),
                      ],
                    ),
                    sizedBox.Boxh5(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด A',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            controller: gradeA_Controller,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด B',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            controller: gradeB_Controller,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด C',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            controller: gradeC_Controller,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    sizedBox.Boxh5(),
                  ],
                ),
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () => {
                editPeriod(
                  period_ID,
                  gradeA_Controller.text,
                  gradeB_Controller.text,
                  gradeC_Controller.text,
                ),
              },
              child: Text('บันทึก', style: TextCustom.buttontext3()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.mediumgreencolor(),
                onPrimary: ColorCustom.lightgreencolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text(
                'ยกเลิก',
                style: TextCustom.buttontext3(),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
                onPrimary: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
