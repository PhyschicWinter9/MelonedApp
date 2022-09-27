import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newmelonedv2/sub_daily/carelist.dart';
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
  //Session
  dynamic period_ID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    print(id.runtimeType);
    setState(() {
      period_ID = id.toString();
    });
  }

  bool editMode = false;

  //Array ของข้อมูลที่จะเอาไปแสดงใน ListViewแบบเรียงลำดับ
  List<Watering> watering = [];

  //Get Data from API
  // Future getWater() async {
  //   var url = "https://meloned.relaxlikes.com/api/dailycare/view_water.php";
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   // return json.decode(response.body);
  //   //แปลงข้อมูลให้เป็น JSON
  //   var data = json.decode(response.body);

  //   // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
  //   for (var i = 0; i < data.length; i++) {
  //     Watering watering = Watering(data[i]['watering_ID'],
  //         data[i]['watering_time'], data[i]['period_ID']);
  //     this.watering.add(watering);
  //   }

  //   //ส่งข้อมูลกลับไปแสดงใน ListView
  //   return watering;

  //   //Debug ดูข้อมูลที่ได้จาก API
  //   // print(watering[1].water_name);
  // }


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
        Watering watering = Watering(
            (i+1), data[i]['water_time'], data[i]['period_ID']);
        this.watering.add(watering);
      }
      // ส่งข้อมูลกลับไปแสดงใน ListView

      return watering;
      // print(url);
      // print(watering);
    } catch (e) {
      print(e);
    }
    // print(watering);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {},
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
              return Expanded(
                child: watering.isNotEmpty
                    ? ListView.builder(
                        itemCount: watering.length,
                        itemBuilder: (BuildContext context, int index) {
                          return WaterCard(watering: watering[index]);
                        },
                      )
                    : Container(
                        child: Center(
                          child: Text(
                            'ไม่มีข้อมูลการให้น้ำ',
                            style: TextCustom.normal_mdg20(),
                          ),
                        ),
                      ),
              );
            }
          },
        ),
      ],
    );
  }
}

class Watering {
  //water_id is count;
  final int count;
  final String time;
  final String period_ID;

  Watering(this.count, this.time, this.period_ID);
}

class WaterCard extends StatefulWidget {
  Watering watering;

  WaterCard({Key? key, required this.watering}) : super(key: key);

  @override
  State<WaterCard> createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterCard> {
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
            onPressed: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('การให้น้ำ ' + '${widget.watering.count}',
                        style: TextCustom.normal_dg16()),
                    Text('${widget.watering.time}',
                        style: TextCustom.normal_dg16()),
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
