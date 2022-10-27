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

class ShowDaily extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();

  ShowDaily({Key? key}) : super(key: key);

  @override
  State<ShowDaily> createState() => _ShowDaily();
}

class _ShowDaily extends State<ShowDaily> {
  //variable
  TooltipBehavior? _tooltipBehavior;
  List waterdata = [];
  List fertdata = [];

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
        title: Text('รายงานสรุปประจำวัน'),
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
                                series: <ChartSeries<DailyFert, String>>[
                                  ColumnSeries<DailyFert, String>(
                                    name: 'สูตรปุ๋ย',
                                    dataSource: fertdata
                                        .map((e) => DailyFert(e['fert_name'],
                                            double.parse(e['ferting_amount'])))
                                        .toList(),
                                    xValueMapper: (DailyFert fert, _) =>
                                        fert.fertname,
                                    yValueMapper: (DailyFert fert, _) =>
                                        fert.fertamount,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                            ),

                            //////// IF USE BAR CHART ////////
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.8,
                            //   child: SfCartesianChart(
                            //     title: ChartTitle(
                            //         text: 'รายงานสรุปประจำวันการให้น้ำ',
                            //         textStyle: TextCustom.bold_b16()),
                            //     legend: Legend(isVisible: false),
                            //     tooltipBehavior: _tooltipBehavior,
                            //     primaryXAxis: CategoryAxis(),
                            //     primaryYAxis: NumericAxis(
                            //         title: AxisTitle(
                            //             text: 'จำนวนการให้น้ำ',
                            //             textStyle: TextCustom.normal_dg16())),
                            //     series: <ChartSeries<DailyWater, String>>[
                            //       ColumnSeries<DailyWater, String>(
                            //           name: 'ชื่อรอบการปลูก',
                            //           dataSource: waterdata
                            //               .map((e) => DailyWater(e['period_name'],
                            //                   double.parse(e['water_count'])))
                            //               .toList(),
                            //           xValueMapper: (DailyWater water, _) =>
                            //               water.periodname,
                            //           yValueMapper: (DailyWater water, _) =>
                            //               water.watercount,
                            //           dataLabelSettings:
                            //               DataLabelSettings(isVisible: true)),
                            //     ],
                            //   ),
                            // ),

                            ////// IF USE TABLE ////////
                            //table for water data
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Title(
                                child: Text(
                                  'รายงานการให้น้ำประจำวัน',
                                  style: TextCustom.bold_b16(),
                                ),
                                color: ColorCustom.browncolor(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'ชื่อรอบการปลูก',
                                    style: TextCustom.normal_b16(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'จำนวนการให้น้ำ',
                                    style: TextCustom.normal_b16(),
                                  )),
                                ],
                                rows: waterdata
                                    .map((e) => DataRow(cells: [
                                          DataCell(Text(
                                            e['period_name'],
                                            style: TextCustom.normal_mdg16(),
                                          )),
                                          DataCell(Text(
                                            e['water_count'],
                                            style: TextCustom.normal_mdg16(),
                                          )),
                                        ]))
                                    .toList(),
                              ),
                            ),
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

// MODEL FOR DATA Keyword: modeldaily
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

  final String? periodname;
  final double? watercount;

  DailyWater.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        watercount = double.parse(json['water_count']);
}
