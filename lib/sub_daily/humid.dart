import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:newmelonedv2/sub_daily/sub_humid/addhumid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/colortheme.dart';
import '../style/textstyle.dart';
import 'sub_humid/edithumid.dart';

class Humid extends StatefulWidget {
  const Humid({Key? key}) : super(key: key);
  @override
  State<Humid> createState() => _HumidState();
}

class _HumidState extends State<Humid> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //List
  List<Humidity> humidity = [
    Humidity(80.99, '7:25'),
    Humidity(60.25, '12:25'),
    Humidity(79.25, '17:25'),
    Humidity(80.25, '22:25'),
  ];

  //Session Manager
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

  Future detailHumidity(String period_ID) async {
    // print("Period ID on Water.dart : $period_ID");
    try {
      //   var url =
      //       "https://meloned.relaxlikes.com/api/dailycare/view_watering.php";
      //   var response = await http.post(Uri.parse(url), body: {
      //     'period_ID': period_ID,
      //   });
      //   // return json.decode(response.body);
      //   //แปลงข้อมูลให้เป็น JSON
      //   var data = json.decode(response.body);
      //   // print(data);
      //   // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
      //   for (var i = 0; i < data.length; i++) {
      //     Humidity humidity = Humidity((i + 1), data[i]['water_ID'],
      //         data[i]['water_time'], data[i]['mL'], data[i]['period_ID']);
      //     this.humidity.add(humidity);
      //   }
      //   // ส่งข้อมูลกลับไปแสดงใน ListView
      //   return humidity;
      // print(url);

    } catch (e) {
      print(e);
    }
    // print(watering);
  }

  Future<void> _refresh() async {
    // final fetchwaterdata = await detailWater(period_ID);
    // setState(() {
    //   watering.clear();
    //   watering = fetchwaterdata;
    // });
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddHumid(periodID: period_ID)));
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: ColorCustom.lightgreencolor(),
                  )),
            ],
          ),
          FutureBuilder(
            future: detailHumidity(period_ID),
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
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Expanded(
                        child: humidity.isNotEmpty
                            ? RefreshIndicator(
                              key: _refreshIndicatorKey,
                              onRefresh: _refresh,
                              child: ListView.builder(
                                  itemCount: humidity.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return HumidCard(
                                      humidity: humidity[index],
                                    );
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
                                        'ไม่มีข้อมูลค่าความชื้น',
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
    );
  }
}

class Humidity {
  final double humidvalue;
  final String time;

  Humidity(this.humidvalue, this.time);
}

class HumidCard extends StatefulWidget {
  Humidity humidity;
  HumidCard({Key? key, required this.humidity}) : super(key: key);

  @override
  State<HumidCard> createState() => _HumidCardState();
}

class _HumidCardState extends State<HumidCard> {
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
                      builder: (context) => EditHumid(
                            humidID: '1',
                            humidamount: widget.humidity.humidvalue.toString(),
                          )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ความชื้น', style: TextCustom.normal_dg16()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.humidity.humidvalue}',
                                      style: TextCustom.normal_mdg16()),
                                  SizedBox(width: 5),
                                  Text('%RH', style: TextCustom.normal_dg16()),
                                ],
                              ),
                              Text('${widget.humidity.time}',
                                  style: TextCustom.normal_dg16()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Text('${widget.humidity.time}',
                    //       style: TextCustom.normal_dg16()),
                    // ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: ColorCustom.lightgreencolor(),
                            ))),
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
