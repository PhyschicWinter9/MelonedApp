import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/textstyle.dart';

import '../../reuse/bottombar.dart';
import '../../style/colortheme.dart';

class ShowDaily extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  ShowDaily({Key? key}) : super(key: key);

  @override
  State<ShowDaily> createState() => _ShowDaily();
}

class _ShowDaily extends State<ShowDaily> {
  TooltipBehavior? _tooltipBehavior;

  List waterdata1 = [];
  List fertdata1 = [];

  //Session
  dynamic greenhouse_ID;
  dynamic selectedDate;

  getSession() async {
    dynamic greenhouseID = await SessionManager().get("greenhouseid");
    dynamic date = await SessionManager().get("seletedate");
    setState(() {
      greenhouse_ID = greenhouseID.toString();
      selectedDate = date.toString();
      print(greenhouse_ID);
      print(selectedDate);
    });
  }

  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/daily/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "selected_date": selectedDate,
      });

      var data = json.decode(response.body);
      setState(() {
        waterdata1.addAll(data);
      });
      return waterdata1;
    } catch (e) {
      print(e);
    }
  }

  Future getFertilizer() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/daily/get_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "selected_date": selectedDate,
      });
      var data = json.decode(response.body);
      setState(() {
        //set null to 0 for chart
        for (var i = 0; i < data.length; i++) {
          if (data[i]['ferting_amount'] == null) {
            data[i]['ferting_amount'] = 0;
          }
        }
        fertdata1.addAll(data);
      });
      print(fertdata1);
      return fertdata1;
    } catch (e) {
      print(e);
    }
  }

  Future getAllData() async {
    await getSession();
    await getWatering();
    await getFertilizer();
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานสรุปประจำวัน'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //show syncfusion flutter charts
            SfCartesianChart(
              title: ChartTitle(
                  text: 'รายงานสรุปประจำวัน',
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.kanit().fontFamily)),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<DailyFert, String>>[
                ColumnSeries<DailyFert, String>(
                  name: 'ชื่อปุ๋ย',
                  dataSource: fertdata1
                      .map((e) => DailyFert(
                          e['fert_name'], double.parse(e['ferting_amount'])))
                      .toList(),

                  // dataSource: fertdata1,
                  // dataSource: fertdata1.toList() as List<DailyFert>,
                  // xValueMapper: (DailyFert fert, _) => fert.fertname,
                  // yValueMapper: (DailyFert fert, _) => fert.fertamount,
                  // dataSource: [
                  //   DailyFert('ไฮโดรเมลอน A B', 50),
                  //   DailyFert('แคลเอ็ม', 100),
                  // ],
                  xValueMapper: (DailyFert fert, _) => fert.fertname,
                  yValueMapper: (DailyFert fert, _) => fert.fertamount,
                ),
                // LineSeries<Daily, String>(
                //     name: 'ปริมาณปุ๋ยที่ให้',
                //     dataSource: widget.fertdata,
                //     xValueMapper: (Daily fert, _) => fert.time,
                //     yValueMapper: (Daily fert, _) => fert.fert,
                //     dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

//NoSuchMethodError: Class 'String' has no instance method 'call'.
//Receiver: "ferting_amount"

class DailyFert {
  DailyFert(this.fertname, this.fertamount);

  final String? fertname;
  final double? fertamount;

  DailyFert.fromJson(Map<String, dynamic> json)
      : fertname = json['fert_name'],
        fertamount = double.parse(json['ferting_amount']);
}

class DailyWater {
  DailyWater(this.periodname, this.watercount);

  final String periodname;
  final int watercount;

  DailyWater.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        watercount = json['water_count'];
}
