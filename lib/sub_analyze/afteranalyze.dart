import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import '../reuse/bottombar.dart';
import '../style/textstyle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AfterAnalyze extends StatefulWidget {
  const AfterAnalyze({Key? key}) : super(key: key);

  @override
  State<AfterAnalyze> createState() => _AfterAnalyzeState();
}

class _AfterAnalyzeState extends State<AfterAnalyze> {
  String period_ID = '';

  Future editPeriod(
    String period_ID,
    String gradeA,
    String gradeB,
    String gradeC,
  ) async {
    var url = Uri.parse(
        "https://meloned.relaxlikes.com/api/analysis/update_from_detect.php");
    var response = await http.post(url, body: {
      'period_ID': period_ID,
      'gradeA': gradeA,
      'gradeB': gradeB,
      'gradeC': gradeC,
    });
    var data = jsonDecode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
        msg: "เพิ่มข้อมูลสำเร็จ",
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
    Navigator.pop(context);
  }

  Future getPeriod(String period_ID) async {
    var url = Uri.parse(
        "https://meloned.relaxlikes.com/api/analysis/view_melon_grade.php");
    var response = await http.post(url, body: {
      'period_ID': period_ID,
    });
    var data = jsonDecode(response.body);
    return data;
  }

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
    String id = data['period_ID'];

    setState(() {
      period_ID = id;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('ผลการวิเคราะห์'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: FutureBuilder(
            future: getPeriod(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.waveDots(
                        size: 50,
                        color: ColorCustom.orangecolor(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'กำลังโหลดข้อมูล...',
                          style: TextCustom.normal_mdg20(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                List list = snapshot.data;
                return snapshot.data.isNotEmpty
                    ? ListView(
                        shrinkWrap: false,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Center(child: data['_objectModel']),
                          ),
                          sizedBox.Boxh20(),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'จำนวนเมลอนที่วิเคราะห์แล้ว : ',
                                      style: TextCustom.normal_dg16(),
                                    ),
                                    Text(
                                        '${list[0]['total_grades']}/${list[0]['planted_melon']}',
                                        style: TextCustom.normal_dg16()),
                                  ],
                                ),
                                sizedBox.Boxh10(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            onPressed: () => {
                              editPeriod(period_ID, gradeA.text, gradeB.text,
                                  gradeC.text)
                            },
                            child:
                                Text('บันทึก', style: TextCustom.buttontext3()),
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
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }
            }),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
