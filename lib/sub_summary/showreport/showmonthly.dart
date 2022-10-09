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

class ShowMonthly extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();

  ShowMonthly({Key? key}) : super(key: key);

  @override
  State<ShowMonthly> createState() => _ShowMonthly();
}

class _ShowMonthly extends State<ShowMonthly> {
  //variable
  TooltipBehavior? _tooltipBehavior;
  List waterdata = [];
  List fertdata = [];

  //Session
  dynamic greenhouse_ID;
  dynamic selectedDateyear;
  dynamic selectedDatemonth;

  getSession() async {
    dynamic greenhouseID = await SessionManager().get("greenhouseid");
    dynamic dateyear = await SessionManager().get("seletedateyear");
    dynamic datemonth = await SessionManager().get("seletedatemonth");
    setState(() {
      greenhouse_ID = greenhouseID.toString();
      selectedDateyear = dateyear.toString();
      selectedDatemonth = datemonth.toString();
    });
  }

  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/monthly/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "year": selectedDateyear,
        "month": selectedDatemonth,
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
          "https://meloned.relaxlikes.com/api/summary/monthly/get_fertilizing.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "year": selectedDateyear,
        "month": selectedDatemonth,
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
        title: Text(
          //convert month number to month name
          'รายงานสรุปประจำเดือน ' + selectedDatemonth + ' / ' + selectedDateyear,
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //loading screen while waiting for data
              fertdata.isEmpty && waterdata.isEmpty
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
                              series: <ChartSeries<MonthlyFert, String>>[
                                ColumnSeries<MonthlyFert, String>(
                                    // name: 'ชื่อปุ๋ย',
                                    dataSource: fertdata
                                        .map((e) => MonthlyFert(
                                            e['period_id'],
                                            e['fert_name'],
                                            double.parse(e['ferting_amount'])))
                                        .toList(),
                                    xValueMapper: (MonthlyFert fert, _) =>
                                        fert.fertname,
                                    yValueMapper: (MonthlyFert fert, _) =>
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
                              series: <ChartSeries<MonthlyWater, String>>[
                                ColumnSeries<MonthlyWater, String>(
                                    name: 'ชื่อรอบการปลูก',
                                    dataSource: waterdata
                                        .map((e) => MonthlyWater(
                                            e['water_time'],
                                            double.parse(e['water_count'])))
                                        .toList(),
                                    xValueMapper: (MonthlyWater water, _) =>
                                        water.watertime,
                                    yValueMapper: (MonthlyWater water, _) =>
                                        water.watercount,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class MonthlyFert {
  MonthlyFert(this.period_id, this.fertname, this.fertingamount);

  final String? period_id;
  final String? fertname;
  final double? fertingamount;

  MonthlyFert.fromJson(Map<String, dynamic> json)
      : period_id = json['period_id'],
        fertname = json['fert_name'],
        fertingamount = double.parse(json['ferting_amount']);
}

class MonthlyWater {
  MonthlyWater(this.watertime, this.watercount);

  final String? watertime;
  final double? watercount;

  MonthlyWater.fromJson(Map<String, dynamic> json)
      : watertime = json['water_time'],
        watercount = double.parse(json['water_count']);
}
