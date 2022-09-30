import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/sub_login/form.dart';
import 'dart:io';
import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';
import '../reuse/bottombar.dart';
import '../style/textstyle.dart';

class AfterAnalyze extends StatefulWidget {
  const AfterAnalyze({Key? key}) : super(key: key);

  @override
  State<AfterAnalyze> createState() => _AfterAnalyzeState();
}

class _AfterAnalyzeState extends State<AfterAnalyze> {
  var gradeA = TextEditingController();
  var gradeB = TextEditingController();
  var gradeC = TextEditingController();
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List tempGrade = data['temp'];
    gradeA.text = tempGrade[0].toString();
    gradeB.text = tempGrade[1].toString();
    gradeC.text = tempGrade[2].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการวิเคราะห์'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: ListView(
          shrinkWrap: false,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(child: data['_objectModel']
                  // child: Text(
                  //   'รูปเมลอนพร้อมกรอบดีเทคเตอร์',
                  //   style: TextCustom.previewtext(),
                  // ),
                  ),
            ),
            sizedBox.Boxh20(),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'จำนวนเมลอนที่วิเคราะห์ : ',
                        style: TextCustom.normal_dg16(),
                      ),
                      Text('20/60', style: TextCustom.normal_dg16()),
                    ],
                  ),
                  sizedBox.Boxh10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('จำนวนเมลอนเกรด A : ',
                              style: TextCustom.normal_dg16())),
                      Expanded(
                          child: TextField(
                        controller: gradeA,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(),
                          disabledBorder: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                        cursorColor: ColorCustom.darkgreencolor(),
                        style: TextCustom.normal_dg18(),
                        keyboardType: TextInputType.number,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('จำนวนเมลอนเกรด B : ',
                              style: TextCustom.normal_dg16())),
                      Expanded(
                          child: TextField(
                        controller: gradeB,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(),
                          disabledBorder: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                        cursorColor: ColorCustom.darkgreencolor(),
                        style: TextCustom.normal_dg18(),
                        keyboardType: TextInputType.number,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('จำนวนเมลอนเกรด C : ',
                              style: TextCustom.normal_dg16())),
                      Expanded(
                          child: TextField(
                        controller: gradeC,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(),
                          disabledBorder: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(),
                        ),
                        cursorColor: ColorCustom.darkgreencolor(),
                        style: TextCustom.normal_dg16(),
                        keyboardType: TextInputType.number,
                      )),
                    ],
                  ),
                ],
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {},
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
