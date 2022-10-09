import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:newmelonedv2/reuse/waitingchart.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';

import '../../reuse/bottombar.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';

class ShowWeekly extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();

  ShowWeekly({Key? key}) : super(key: key);

  @override
  State<ShowWeekly> createState() => _ShowWeekly();
}

class _ShowWeekly extends State<ShowWeekly> {
  //variable
  TooltipBehavior? _tooltipBehavior;
  List waterdata = [];
  List fertdata = [];

  //Session
  dynamic greenhouse_ID;
  dynamic endofweek;

  getSession() async {
    dynamic greenhouseID = await SessionManager().get("greenhouseid");
    dynamic date = await SessionManager().get("seletedate");
    setState(() {
      greenhouse_ID = greenhouseID.toString();
      endofweek = date.toString();
      print(greenhouse_ID);
      print(endofweek);
    });
  }

  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/weekly/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "end_week_day": endofweek,
      });

      var data = json.decode(response.body);
      //set null to 0 for chart
      for (var i = 0; i < data.length; i++) {
        if (data[i]['water_count'] == null) {
          data[i]['water_count'] = 0;
        }
      }
      setState(() {
        waterdata.addAll(data);
      });
      return waterdata;
    } catch (e) {
      print(e);
    }
  }

  Future getFertilizer() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/weekly/get_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "end_week_day": endofweek,
      });
      var data = json.decode(response.body);
      setState(() {
        //set null to 0 for chart
        for (var i = 0; i < data.length; i++) {
          if (data[i]['ferting_amount'] == null) {
            data[i]['ferting_amount'] = 0;
          }
        }
        fertdata.addAll(data);
      });
      print(fertdata);
      return fertdata;
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    await getWatering();
    await getFertilizer();
  }

  Future getAllData() async {
    await getSession();
    await getData();
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
        title: Text('รายงานสรุปประจำสัปดาห์'),
      ),
      drawer: Hamburger(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: BGContainer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //loading screen while waiting for data
                fertdata.isEmpty && waterdata.isEmpty
                    ? Center(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Lottie.asset(
                                'assets/animate/chartloading.json',
                                width: 200,
                                height: 200,
                              ),
                              Text(
                                'กำลังประมวลผล',
                                style: TextCustom.normal_mdg20(),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: 'รายงานการให้ปุ๋ยประจำวัน',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),

                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                      text: 'สูตรปุ๋ย',
                                      textStyle: TextCustom.normal_dg16()),
                                ),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'ปริมาณปุ๋ย',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<WeeklyFert, String>>[
                                  ColumnSeries<WeeklyFert, String>(
                                      name: 'สูตรปุ๋ย',
                                      dataSource: fertdata
                                          .map((e) => WeeklyFert(e['fert_name'],
                                              double.parse(e['ferting_amount'])))
                                          .toList(),
                                      xValueMapper: (WeeklyFert fert, _) =>
                                          fert.fertname,
                                      yValueMapper: (WeeklyFert fert, _) =>
                                          fert.fertamount,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true)),
                                ],
                              ),
                            ),

                            //////// IF USE BAR CHART ////////
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: 'รายงานสรุปประจำวันการให้น้ำ',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'จำนวนการให้น้ำ',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<WeeklyWater, String>>[
                                  ColumnSeries<WeeklyWater, String>(
                                      name: 'ชื่อรอบการปลูก',
                                      dataSource: waterdata
                                          .map((e) => WeeklyWater(e['period_name'],
                                              double.parse(e['water_count'])))
                                          .toList(),
                                      xValueMapper: (WeeklyWater water, _) =>
                                          water.periodname,
                                      yValueMapper: (WeeklyWater water, _) =>
                                          water.watercount,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true)),
                                ],
                              ),
                            ),

                            ////// IF USE TABLE ////////
                            //table for water data
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Center(
                            //   child: Title(
                            //     child: Text(
                            //       'รายงานสรุปประจำวันการให้น้ำ',
                            //       style: TextCustom.bold_b16(),
                            //     ),
                            //     color: ColorCustom.browncolor(),
                            //   ),
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   child: DataTable(
                            //     columns: [
                            //       DataColumn(
                            //           label: Text(
                            //         'ชื่อรอบการปลูก',
                            //         style: TextCustom.normal_b16(),
                            //       )),
                            //       DataColumn(
                            //           label: Text(
                            //         'จำนวนการให้น้ำ',
                            //         style: TextCustom.normal_b16(),
                            //       )),
                            //     ],
                            //     rows: waterdata
                            //         .map((e) => DataRow(cells: [
                            //               DataCell(Text(
                            //                 e['period_name'],
                            //                 style: TextCustom.normal_mdg16(),
                            //               )),
                            //               DataCell(Text(
                            //                 e['water_count'],
                            //                 style: TextCustom.normal_mdg16(),
                            //               )),
                            //             ]))
                            //         .toList(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

//NoSuchMethodError: Class 'String' has no instance method 'call'.
//Receiver: "ferting_amount"

class WeeklyFert {
  WeeklyFert(this.fertname, this.fertamount);

  final String? fertname;
  final double? fertamount;

  WeeklyFert.fromJson(Map<String, dynamic> json)
      : fertname = json['fert_name'],
        fertamount = double.parse(json['ferting_amount']);
}

class WeeklyWater {
  WeeklyWater(this.periodname, this.watercount);

  final String? periodname;
  final double? watercount;

  WeeklyWater.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        watercount = double.parse(json['water_count']);
}
