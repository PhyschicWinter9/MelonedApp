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

class ShowYearly extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();

  ShowYearly({Key? key}) : super(key: key);

  @override
  State<ShowYearly> createState() => _ShowYearly();
}

class _ShowYearly extends State<ShowYearly> {
  //variable
  TooltipBehavior? _tooltipBehavior;
  List waterdata = [];
  List<YearlyFeart> fertdata = [];
  List<PeriodGrade> gradedata = [];
  List<YearlyFeartFixed> fertdatafixed = [];

  //Session
  dynamic greenhouse_ID;
  dynamic year;

  getSession() async {
    dynamic greenhouseID = await SessionManager().get("greenhouseid");
    dynamic date = await SessionManager().get("year");
    setState(() {
      greenhouse_ID = greenhouseID.toString();
      year = date.toString();
      print(greenhouse_ID);
      print(year);
    });
  }

  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/yearly/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "selected_year": year,
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

  //NOT WORKING YET
  // Future getFertilizer() async {
  //   try {
  //     var url =
  //         "https://meloned.relaxlikes.com/api/summary/yearly/get_fertilizing.php";
  //     var response = await http.post(Uri.parse(url), body: {
  //       "greenhouse_ID": greenhouse_ID,
  //       "selected_year": year,
  //     });
  //     var data = json.decode(response.body);
  //     setState(() {
  //       for (var i = 0; i < data.length; i++) {
  //         fertdata.add(YearlyFeart(data[i]['period_name'], data[i]['fert_name'],
  //             double.parse(data[i]['sum_fert'])));
  //       }
  //     });
  //     print(fertdata.toString());
  //     return fertdata;
  //   } catch (e) {
  //     print(e);
  //   }

  // }
  Future getFertilizerfixed() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/yearly/get_fertilizingfixed.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "selected_year": year,
      });
      var data = json.decode(response.body);
      setState(() {
        for (var i = 0; i < data.length; i++) {
          //check if all data in list = null then set to 0 or blank for chart because chart can't show null
          if (data[i]['period_name'] == null &&
              data[i]['??????????????????'] == null &&
              data[i]['??????????????????????????????AB'] == null &&
              data[i]['?????????????????????'] == null &&
              data[i]['???????????????'] == null &&
              data[i]['??????????????????'] == null) {
            // set to 0
            data[i]['period_name'] = '?????????????????????????????????';
            data[i]['??????????????????'] = 0;
            data[i]['??????????????????????????????AB'] = 0;
            data[i]['?????????????????????'] = 0;
            data[i]['???????????????'] = 0;
            data[i]['??????????????????'] = 0;
          } else {
            fertdatafixed.add(YearlyFeartFixed(
                data[i]['period_name'],
                double.parse(data[i]['??????????????????']),
                double.parse(data[i]['??????????????????????????????AB']),
                double.parse(data[i]['?????????????????????']),
                double.parse(data[i]['???????????????']),
                double.parse(data[i]['??????????????????'])));
          }
        }
      });
      return fertdatafixed;
    } catch (e) {
      print(e);
    }
  }

  Future getGrade() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/yearly/get_grade.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": greenhouse_ID,
        "year": year,
      });
      var data = json.decode(response.body);
      setState(() {
        //add data to list for chart
        for (var i = 0; i < data.length; i++) {
          gradedata.add(PeriodGrade(
              data[i]['period_name'],
              int.parse(data[i]['A']),
              int.parse(data[i]['B']),
              int.parse(data[i]['C'])));
        }
      });
      return gradedata;
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    await getWatering();
    await getFertilizerfixed();
    await getGrade();
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
          '?????????????????????????????????????????????' + year.toString(),
        ),
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
                                '???????????????????????????????????????',
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
                                    text: '??????????????????????????????????????????????????????????????????',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: '??????????????????????????????????????????',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<YearlyWater, String>>[
                                  ColumnSeries<YearlyWater, String>(
                                    name: '??????????????????????????????????????????',
                                    dataSource: waterdata
                                        .map((e) => YearlyWater(
                                            e['period_name'],
                                            double.parse(e['water_count'])))
                                        .toList(),
                                    xValueMapper: (YearlyWater water, _) =>
                                        water.periodname,
                                    yValueMapper: (YearlyWater water, _) =>
                                        water.watercount,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                            ),

                            //////// STACK COLUMN CHART OF FERT ////////
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: '?????????????????????????????????????????????????????????????????????',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                      text: '??????????????????????????????????????????',
                                      textStyle: TextCustom.normal_dg16()),
                                ),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: '??????????????????????????????',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<YearlyFeartFixed, String>>[
                                  StackedColumnSeries<YearlyFeartFixed, String>(
                                    name: '????????????????????????',
                                    dataSource: fertdatafixed,
                                    xValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.periodname,
                                    yValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.alpha,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<YearlyFeartFixed, String>(
                                    name: '????????????????????????',
                                    dataSource: fertdatafixed,
                                    xValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.periodname,
                                    yValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.hydromelonAB,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<YearlyFeartFixed, String>(
                                    name: '????????????????????????',
                                    dataSource: fertdatafixed,
                                    xValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.periodname,
                                    yValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.kalM,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<YearlyFeartFixed, String>(
                                    name: '????????????????????????',
                                    dataSource: fertdatafixed,
                                    xValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.periodname,
                                    yValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.gamma,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<YearlyFeartFixed, String>(
                                    name: '????????????????????????',
                                    dataSource: fertdatafixed,
                                    xValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.periodname,
                                    yValueMapper: (YearlyFeartFixed fert, _) =>
                                        fert.omega,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              ),
                            ),
                            //////// STACK COLUMN CHART OF MELON ////////
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: '??????????????????????????????????????????????????????',
                                    textStyle: TextCustom.bold_b16()),
                                legend: Legend(isVisible: false),
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                      text: '??????????????????????????????????????????',
                                      textStyle: TextCustom.normal_dg16()),
                                ),
                                primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: '??????????????????????????????',
                                        textStyle: TextCustom.normal_dg16())),
                                series: <ChartSeries<PeriodGrade, String>>[
                                  StackedColumnSeries<PeriodGrade, String>(
                                    name: '???????????? A',
                                    dataSource: gradedata,
                                    xValueMapper: (PeriodGrade grade, _) =>
                                        grade.periodname,
                                    yValueMapper: (PeriodGrade grade, _) =>
                                        grade.gradeA,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<PeriodGrade, String>(
                                    name: '???????????? B',
                                    dataSource: gradedata,
                                    xValueMapper: (PeriodGrade grade, _) =>
                                        grade.periodname,
                                    yValueMapper: (PeriodGrade grade, _) =>
                                        grade.gradeB,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  StackedColumnSeries<PeriodGrade, String>(
                                    name: '???????????? C',
                                    dataSource: gradedata,
                                    xValueMapper: (PeriodGrade grade, _) =>
                                        grade.periodname,
                                    yValueMapper: (PeriodGrade grade, _) =>
                                        grade.gradeC,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
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
                            //       '?????????????????????????????????????????????????????????????????????????????????',
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
                            //         '??????????????????????????????????????????',
                            //         style: TextCustom.normal_b16(),
                            //       )),
                            //       DataColumn(
                            //           label: Text(
                            //         '??????????????????????????????????????????',
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

// MODEL FOR DATA Keyword: modelyearly

class YearlyFeart {
  YearlyFeart(this.periodname, this.fertname, this.fertamount);

  final String? periodname;
  final String? fertname;
  final double? fertamount;

  YearlyFeart.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        fertname = json['fert_name'],
        fertamount = double.parse(json['sum_fert']);
}

class YearlyFeartFixed {
  YearlyFeartFixed(this.periodname, this.alpha, this.hydromelonAB, this.kalM,
      this.gamma, this.omega);

  final String? periodname;
  final double? alpha;
  final double? hydromelonAB;
  final double? kalM;
  final double? gamma;
  final double? omega;

  YearlyFeartFixed.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        alpha = double.parse(json['??????????????????']),
        hydromelonAB = double.parse(json['??????????????????????????????AB']),
        kalM = double.parse(json['?????????????????????']),
        gamma = double.parse(json['???????????????']),
        omega = double.parse(json['??????????????????']);
}

class YearlyWater {
  YearlyWater(this.periodname, this.watercount);

  final String? periodname;
  final double? watercount;

  YearlyWater.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        watercount = double.parse(json['water_count']);
}

class PeriodGrade {
  PeriodGrade(
    this.periodname,
    this.gradeA,
    this.gradeB,
    this.gradeC,
  );

  String? periodname;
  int? gradeA;
  int? gradeB;
  int? gradeC;
}
