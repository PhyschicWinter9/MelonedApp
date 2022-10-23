import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:newmelonedv2/sub_daily/carelist.dart';
import 'package:newmelonedv2/sub_daily/sub_water/addwater.dart';
import 'package:newmelonedv2/sub_daily/sub_water/editwater.dart';
import 'dart:convert';
import '../style/colortheme.dart';
import '../style/textstyle.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class Water extends StatefulWidget {
  const Water({Key? key}) : super(key: key);
  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //Session
  dynamic period_ID;

  @override
  void initState() {
    super.initState();
    getSession();
    setState(() {});
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    // print(id.runtimeType);
    setState(() {
      period_ID = id.toString();
    });
  }

  //Array ของข้อมูลที่จะเอาไปแสดงใน ListViewแบบเรียงลำดับ
  List<Watering> watering = [];

  Future detailWater(String period_ID) async {
    // print("Period ID on Water.dart : $period_ID");
    try {
      var url =
          "https://meloned.relaxlikes.com/api/dailycare/view_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
      });
      // return json.decode(response.body);
      //แปลงข้อมูลให้เป็น JSON
      var data = json.decode(response.body);
      // print(data);
      // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
      for (var i = 0; i < data.length; i++) {
        Watering watering = Watering((i + 1), data[i]['water_ID'],
            data[i]['water_time'], data[i]['mL'], data[i]['period_ID']);
        this.watering.add(watering);
      }
      // ส่งข้อมูลกลับไปแสดงใน ListView
      return watering;
      // print(url);

    } catch (e) {
      print(e);
    }
    // print(watering);
  }

  Future addWater(String period_ID) async {
    var url =
        "https://meloned.relaxlikes.com/api/dailycare/insert_watering.php";
    var response = await http.post(Uri.parse(url), body: {
      'period_ID': period_ID,
    });

    var jsonData = json.decode(response.body);

    if (jsonData == "Failed") {
      Fluttertoast.showToast(
        msg: "เพิ่มข้อมูลไม่สำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "เพิ่มข้อมูลสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // Navigator.pop(context);
      // setState(() {});
      //Addwater and refresh list view data after add water success or fail
      // setState(() {
      //   watering.clear();
      //   detailWater(period_ID);
      // });
    }
  }

  Future<void> _refresh() async {
    final fetchwaterdata = await detailWater(period_ID);
    setState(() {
      watering.clear();
      watering = fetchwaterdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      // addWater(period_ID);
                      // updatelist();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddWater(periodID: period_ID),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: ColorCustom.lightgreencolor(),
                    )),
              ],
            ),
            FutureBuilder(
              future: detailWater(period_ID),
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
                    height: MediaQuery.of(context).size.height*0.8,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: watering.isNotEmpty
                              ? RefreshIndicator(
                                  key: _refreshIndicatorKey,
                                  onRefresh: _refresh,
                                  child: ListView.builder(
                                    itemCount: watering.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return WaterCard(watering: watering[index]);
                                    },
                                  ),
                                )
                              : RefreshIndicator(
                                key: _refreshIndicatorKey,
                                onRefresh: _refresh,
                                child: Container(
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                          'assets/animate/empty.json',
                                          width: 250,
                                          height: 250,
                                        ),
                                        Text(
                                          'ไม่มีข้อมูลการให้น้ำ',
                                          style: TextCustom.normal_mdg20(),
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}

class Watering {
  //water_id is count;
  final int count;
  final String time;
  final String wateramount;
  final String period_ID;
  final String water_ID;

  Watering(
      this.count, this.water_ID, this.time, this.wateramount, this.period_ID);
}

class WaterCard extends StatefulWidget {
  Watering watering;

  WaterCard({Key? key, required this.watering}) : super(key: key);

  @override
  State<WaterCard> createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterCard> {
  //REMOVE
  Future RemoveWater(String water_ID) async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/dailycare/delete_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        'water_ID': water_ID,
      });

      var jsonData = json.decode(response.body);

      if (jsonData == "Failed") {
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditWater(
                    waterid: widget.watering.water_ID,
                    wateramount: widget.watering.wateramount,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('การให้น้ำ ' + '${widget.watering.count}',
                          style: TextCustom.normal_dg16()),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('${widget.watering.time}',
                          style: TextCustom.normal_dg16()),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              RemoveWater(widget.watering.water_ID);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: ColorCustom.orangecolor(),
                            )))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
