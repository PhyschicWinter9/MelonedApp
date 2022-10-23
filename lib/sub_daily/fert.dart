import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:newmelonedv2/sub_daily/sub_fert/editfert.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class Fert extends StatefulWidget {
  const Fert({Key? key}) : super(key: key);
  @override
  State<Fert> createState() => _FertState();
}

class _FertState extends State<Fert> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //Session
  dynamic period_ID;

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    setState(() {
      period_ID = id.toString();
    });
  }

  //Array ของข้อมูลที่จะเอาไปแสดงใน ListViewแบบเรียงลำดับ
  List<Ferting> ferting = [];

  Future detailFert(String period_ID) async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/dailycare/view_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
      });
      // return json.decode(response.body);
      //แปลงข้อมูลให้เป็น JSON
      var data = json.decode(response.body);
      // print(data.toString());
      // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
      for (var i = 0; i < data.length; i++) {
        Ferting ferting = Ferting(
            data[i]['fert_ID'],
            data[i]['fert_name'],
            data[i]['ferting_amount'],
            data[i]['unit'],
            data[i]['ferting_time'],
            data[i]['period_ID'],
            data[i]['ferting_ID']);
        this.ferting.add(ferting);
      }
      // ส่งข้อมูลกลับไปแสดงใน ListView

      return ferting;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refresh() async {
    final fetchfertdata = await detailFert(period_ID);
    setState(() {
      ferting.clear();
      ferting = fetchfertdata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addfert');
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: ColorCustom.lightgreencolor(),
                  )),
            ],
          ),
          FutureBuilder(
            future: detailFert(period_ID),
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
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      Expanded(
                        child: ferting.isNotEmpty
                            ? RefreshIndicator(
                                key: _refreshIndicatorKey,
                                onRefresh: _refresh,
                                child: ListView.builder(
                                  itemCount: ferting.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return FertCard(ferting: ferting[index]);
                                  },
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/animate/empty.json',
                                      width: 250,
                                      height: 250,
                                    ),
                                    Text(
                                      'ไม่มีข้อมูลการให้ปุ๋ย',
                                      style: TextCustom.normal_mdg20(),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class Ferting {
  String fert_ID;
  String fertname;
  String amount;
  String unit;
  String time;
  String periodID;
  String ferting_ID;

  Ferting(this.fert_ID, this.fertname, this.amount, this.unit, this.time,
      this.periodID, this.ferting_ID);
}

class FertCard extends StatefulWidget {
  Ferting ferting;
  FertCard({Key? key, required this.ferting}) : super(key: key);

  @override
  State<FertCard> createState() => _FertCardState();
}

class _FertCardState extends State<FertCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.lightyellowcolor(),
                onPrimary: ColorCustom.yellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.ferting.fertname}',
                          style: TextCustom.normal_dg16()),
                      Text('${widget.ferting.amount} ${widget.ferting.unit}',
                          style: TextCustom.normal_dg16()),
                      Text('${widget.ferting.time}',
                          style: TextCustom.normal_dg16()),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/editfert');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditFert(
                                      fert_ID: widget.ferting.fert_ID,
                                      ferting_amount: widget.ferting.amount,
                                      fert_name: widget.ferting.fertname,
                                      ferting_ID: widget.ferting.ferting_ID,
                                    )));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: ColorCustom.orangecolor(),
                        size: 30,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
