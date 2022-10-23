import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:newmelonedv2/sub_daily/sub_intensity/addintensity.dart';
import 'dart:convert';
import '../style/colortheme.dart';
import '../style/textstyle.dart';
import 'sub_intensity/editintensity.dart';

class Intense extends StatefulWidget {
  const Intense({Key? key}) : super(key: key);
  @override
  State<Intense> createState() => _IntenseState();
}

class _IntenseState extends State<Intense> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //List
  List<Intensity> intensity = [];

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

  Future detailIntensity(String period_ID) async {

    try {
        var url =
            "https://meloned.relaxlikes.com/api/dailycare/view_intense.php";
        var response = await http.post(Uri.parse(url), body: {
          'period_ID': period_ID,
        });
        // return json.decode(response.body);
        //แปลงข้อมูลให้เป็น JSON
        var data = json.decode(response.body);
        // print(data);
        // วนลูปข้อมูลที่ได้จาก API แล้วเก็บไว้ใน Array
        for (var i = 0; i < data.length; i++) {
          Intensity intensity = Intensity((i + 1), data[i]['intense_ID'],
              data[i]['intense_time'], data[i]['lux'], data[i]['period_ID']);
          this.intensity.add(intensity);
        }
        // ส่งข้อมูลกลับไปแสดงใน ListView
        return intensity;


    } catch (e) {
      print(e);
    }
    // print(watering);
  }

  Future<void> _refresh() async {
    final fetchintensedata = await detailIntensity(period_ID);
    setState(() {
      intensity.clear();
      intensity = fetchintensedata;
    });
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
                                AddIntense(periodID: period_ID)));
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: ColorCustom.lightgreencolor(),
                  )),
            ],
          ),
          FutureBuilder(
            future: detailIntensity(period_ID),
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
                        child: intensity.isNotEmpty
                            ? RefreshIndicator(
                                key: _refreshIndicatorKey,
                                onRefresh: _refresh,
                                child: ListView.builder(
                                  itemCount: intensity.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return IntensityCard(
                                      intensity: intensity[index],
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
                                        'ไม่มีข้อมูลเกี่ยวกับความเข้มแสง',
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

class Intensity {
  final int count;
  final String time;
  final String intenseamount;
  final String period_ID;
  final String intense_ID;

  Intensity(this.count, this.intense_ID, this.time, this.intenseamount,
      this.period_ID);
}

class IntensityCard extends StatefulWidget {
  Intensity intensity;
  IntensityCard({Key? key, required this.intensity}) : super(key: key);

  @override
  State<IntensityCard> createState() => _IntensityCardState();
}

class _IntensityCardState extends State<IntensityCard> {
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => EditIntens(
              //               intensID: widget.intensity.intense_ID,
              //               intensamount: widget.intensity.intenseamount,
              //             )));
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
                              Text('ความเข็มแสง', style: TextCustom.normal_dg16()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.intensity.intenseamount}',
                                      style: TextCustom.normal_mdg16()),
                                  SizedBox(width: 5),
                                  Text('Lux', style: TextCustom.normal_dg16()),
                                ],
                              ),
                              Text('${widget.intensity.time}',
                                  style: TextCustom.normal_dg16()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditIntens(
                                            intenseID:
                                                widget.intensity.intense_ID,
                                            intensamount:
                                                widget.intensity.intenseamount,
                                          )));
                            },
                            icon: Icon(
                              Icons.settings,
                              color: ColorCustom.orangecolor(),
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
