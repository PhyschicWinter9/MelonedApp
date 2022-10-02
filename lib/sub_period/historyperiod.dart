import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import '../menu.dart';
import '../daily.dart';
import '../analyze.dart';
import '../reuse/bottombar.dart';
import '../style/textstyle.dart';
import 'new_period.dart';
import 'detail_period.dart';
import '../summary.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HistoryPeriod extends StatefulWidget {
  const HistoryPeriod({Key? key}) : super(key: key);

  @override
  State<HistoryPeriod> createState() => _PeriodState();
}

class _PeriodState extends State<HistoryPeriod> {
  //Initial Seleted Value
  // String greenhouse_namevalue = "";

  // var items = [
  //   'โรงเรือน 1',
  //   'โรงเรือน 2',
  //   'โรงเรือน 3',
  // ];

  Future detailpreiod(String period_ID, String create_date, String harvest_date,
      String greenhouse_ID) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
        'create_date': create_date,
        'harvest_date': harvest_date,
        'greenhouse_ID': greenhouse_ID,
      });
      var data = json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future getPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/viewhistoryperiod.php";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        title: Text(
          'ประวัติรอบการปลูก',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            //period lists
            Container(
              child: FutureBuilder(
                  future: getPeriod(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.waveDots(
                                color: Color.fromRGBO(245, 176, 103, 1),
                                size: 50,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'กำลังโหลดข้อมูล...',
                                  style: GoogleFonts.kanit(
                                    fontSize: 20,
                                    color: Color.fromRGBO(159, 159, 54, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return snapshot.data.length != 0
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  List list = snapshot.data;
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              snapshot.data[index]
                                                  ['greenhouse_name'],
                                              style: GoogleFonts.kanit(),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'วันที่ปลูก  ' +
                                                      snapshot.data[index]
                                                          ['create_date'],
                                                  style: GoogleFonts.kanit(),
                                                ),
                                                Text(
                                                  'วันที่เก็บเกี่ยว' +
                                                      snapshot.data[index]
                                                          ['harvest_date'],
                                                  style: GoogleFonts.kanit(
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorCustom.lightyellowcolor(),
                                        onPrimary:
                                            ColorCustom.lightgreencolor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Column(
                              children: [
                                Lottie.asset(
                                  'assets/animate/empty.json',
                                  width: 250,
                                  height: 250,
                                ),
                                Text(
                                  'ไม่มีประวัติรอบการปลูก',
                                  style: TextCustom.normal_mdg20(),
                                ),
                              ],
                            );
                    }
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
