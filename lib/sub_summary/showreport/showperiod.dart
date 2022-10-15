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

class ShowPeriod extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();

  ShowPeriod({Key? key}) : super(key: key);

  @override
  State<ShowPeriod> createState() => _ShowPeriod();
}

class _ShowPeriod extends State<ShowPeriod> {
  //variable
  TooltipBehavior? _tooltipBehavior;
  List waterdata = [];
  List fertdata = [];
  List<PeriodGrade> gradedata = [];

  //Session
  dynamic period_ID;

  getSession() async {
    dynamic periodID = await SessionManager().get("periodid");
    setState(() {
      period_ID = periodID.toString();
    });
  }

  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/period/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "period_ID": period_ID,
      });

      var data = json.decode(response.body);
      //set null to 0 for chart
      for (var i = 0; i < data.length; i++) {
        if (data[i]['count_water'] == null) {
          data[i]['count_water'] = 0;
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
          "https://meloned.relaxlikes.com/api/summary/period/get_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        "period_ID": period_ID,
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
      return fertdata;
    } catch (e) {
      print(e);
    }
  }

  Future getGrade() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/period/get_grade.php";
      var response = await http.post(Uri.parse(url), body: {
        "period_ID": period_ID,
      });
      var data = json.decode(response.body);
      setState(() {
        //add data to list for chart
        gradedata.add(PeriodGrade('เกรด A', int.parse(data[0]['A'])));
        gradedata.add(PeriodGrade('เกรด B', int.parse(data[0]['B'])));
        gradedata.add(PeriodGrade('เกรด C', int.parse(data[0]['C'])));
      });
      return gradedata;
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    await getWatering();
    await getFertilizer();
    await getGrade();
  }

  Future getAllData() async {
    await getSession();
    await getData();
    print(period_ID);
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
        title: Text(
            //convert month number to month name
            'รายงานสรุปรายรอบการปลูก'),
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
                fertdata.isEmpty && waterdata.isEmpty && gradedata.isEmpty
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
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
                                    text: 'รายงานการให้ปุ๋ยประจำเดือน',
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
                                series: <ChartSeries<PeriodFert, String>>[
                                  ColumnSeries<PeriodFert, String>(
                                      // name: 'ชื่อปุ๋ย',
                                      dataSource: fertdata
                                          .map((e) => PeriodFert(
                                              e['period_id'],
                                              e['fert_name'],
                                              double.parse(
                                                  e['ferting_amount'])))
                                          .toList(),
                                      xValueMapper: (PeriodFert fert, _) =>
                                          fert.fertname,
                                      yValueMapper: (PeriodFert fert, _) =>
                                          fert.fertingamount,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true)),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: 'รายงานสรุปประจำเดือนการให้น้ำ',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'จำนวนการให้น้ำ',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<PeriodWater, String>>[
                                  ColumnSeries<PeriodWater, String>(
                                      name: 'เวลาให้น้ำ',
                                      dataSource: waterdata
                                          .map((e) => PeriodWater(
                                              e['water_time'],
                                              double.parse(e['count_water'])))
                                          .toList(),
                                      xValueMapper: (PeriodWater water, _) =>
                                          water.watertime,
                                      yValueMapper: (PeriodWater water, _) =>
                                          water.watercount,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true)),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCircularChart(
                                title: ChartTitle(
                                    text: 'รายงานคุณภาพของเมลอน',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: _tooltipBehavior,
                                series: <CircularSeries>[
                                  PieSeries<PeriodGrade, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    name: 'คุณภาพของเมลอน',
                                    dataSource: gradedata,
                                    xValueMapper: (PeriodGrade grade, _) =>
                                        grade.grade,
                                    yValueMapper: (PeriodGrade grade, _) =>
                                        grade.amount,
                                    dataLabelMapper: (PeriodGrade grade, _) =>
                                        grade.grade,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                  ),
                                ],
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

class PeriodFert {
  PeriodFert(this.period_id, this.fertname, this.fertingamount);

  final String? period_id;
  final String? fertname;
  final double? fertingamount;

  PeriodFert.fromJson(Map<String, dynamic> json)
      : period_id = json['period_id'],
        fertname = json['fert_name'],
        fertingamount = double.parse(json['ferting_amount']);
}

class PeriodWater {
  PeriodWater(this.watertime, this.watercount);

  final String? watertime;
  final double? watercount;

  PeriodWater.fromJson(Map<String, dynamic> json)
      : watertime = json['water_time'],
        watercount = double.parse(json['count_water']);
}

class PeriodGrade {
  PeriodGrade(this.grade, this.amount);

  String? grade;
  int? amount;
}
