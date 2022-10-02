// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'reuse/container.dart';
import 'style/colortheme.dart';
import 'style/textstyle.dart';
import 'sub_daily/carecard.dart';
import 'sub_daily/carelist.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';
import 'sub_daily/carelist.dart';
import 'sub_daily/carecard.dart';
import 'package:http/http.dart' as http;

class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);
  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  //Array ของข้อมูลที่จะเอาไปแสดงใน ListViewแบบเรียงลำดับ
  List<CareList> carelist = [];

  //ดึงข้อมูลจาก API
  Future getDaily() async {
    var url =
        "https://meloned.relaxlikes.com/api/dailycare/view_period_daily.php";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    // return json.decode(response.body);
    //แปลงข้อมูลให้เป็น JSON
    var data = json.decode(response.body);

    // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
    for (var i = 0; i < data.length; i++) {
      CareList carelist = CareList(data[i]['period_name'], data[i]['water_num'],
          data[i]['fert_num'], data[i]['note_num'], data[i]['period_ID']);
      this.carelist.add(carelist);
    }

    //ส่งข้อมูลกลับไปแสดงใน ListView
    return carelist;

    //Debug ดูข้อมูลที่ได้จาก API
    // print(carelist[1].water_num);
  }

  // send period_ID to water page
  Future sendPeriodID(String period_ID) async {
    try {
      String url =
          "https://meloned.relaxlikes.com/api/dailycare/view_period_daily.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
      });
      var data = json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การดูแลประจำวัน',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDaily(),
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
                    return carelist.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CareCard(
                                carelist: carelist[index],
                              );
                            },
                          )
                        : Column(
                            children: [
                              Lottie.asset(
                                'assets/animate/empty.json',
                                width: 250,
                                height: 250,
                              ),
                              Text(
                                'ไม่มีรายการดูแลประจำวัน',
                                style: TextCustom.normal_mdg20(),
                              ),
                            ],
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
