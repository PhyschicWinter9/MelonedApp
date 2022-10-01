import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../reuse/bottombar.dart';
import '../reuse/container.dart';
import '../reuse/hamburger.dart';

class AnalyzeDetail extends StatefulWidget {
  const AnalyzeDetail({Key? key}) : super(key: key);

  @override
  State<AnalyzeDetail> createState() => _AnalyzeDetailState();
}

class _AnalyzeDetailState extends State<AnalyzeDetail> {
  String period_ID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getPeriod() async {
    var url = Uri.parse(
        "https://meloned.relaxlikes.com/api/analysis/view_melon_grade.php");
    var response = await http.post(url, body: {
      'period_ID': period_ID,
    });
    var data = jsonDecode(response.body);
    return data;
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    String id = data['period_ID'];
    setState(() {
      period_ID = id;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณภาพเมลอน',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/addanalyze", arguments: {
                'period_ID': period_ID
              }).then((value) => setState(() {}));
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            FutureBuilder(
                future: getPeriod(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List list = snapshot.data;
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? Card(
                          elevation: 2,
                          color: ColorCustom.lightyellowcolor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${list[0]['period_name']}',
                                      style: TextCustom.bold_b20(),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            "/editanalyze",
                                            arguments: {
                                              'melonList': [
                                                list[0]['period_ID'],
                                                list[0]['period_name'],
                                                list[0]['planted_melon'],
                                                list[0]['total_grades'],
                                                list[0]['gradeA'],
                                                list[0]['gradeB'],
                                                list[0]['gradeC'],
                                              ]
                                            }).then((value) => setState(() {}));
                                      },
                                      child: Row(
                                        children: [
                                          Text('แก้ไข'),
                                          sizedBox.Boxw5(),
                                          Icon(Icons.settings),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: ColorCustom.lightgreencolor(),
                                        onPrimary:
                                            ColorCustom.lightyellowcolor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox.Boxh5(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('เมลอนทั้งหมด',
                                        style: TextCustom.normal_dg16()),
                                    Text(
                                        '${list[0]['total_grades']}/${list[0]['planted_melon']}',
                                        style: TextCustom.normal_b16()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('เมลอนเกรด A',
                                        style: TextCustom.normal_dg16()),
                                    Text('${list[0]['gradeA']}',
                                        style: TextCustom.normal_b16()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('เมลอนเกรด B',
                                        style: TextCustom.normal_dg16()),
                                    Text('${list[0]['gradeB']}',
                                        style: TextCustom.normal_b16()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('เมลอนเกรด C',
                                        style: TextCustom.normal_dg16()),
                                    Text('${list[0]['gradeC']}',
                                        style: TextCustom.normal_b16()),
                                  ],
                                ),
                                sizedBox.Boxh5(),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text('ย้อนกลับ', style: TextCustom.buttontext2()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.yellowcolor(),
                onPrimary: ColorCustom.lightyellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
