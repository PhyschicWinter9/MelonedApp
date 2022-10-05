import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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

  final List waterdata;
  final List fertdata;

  ShowDaily({Key? key, required this.waterdata, required this.fertdata})
      : super(key: key);

  @override
  State<ShowDaily> createState() => _ShowDaily();
}

class _ShowDaily extends State<ShowDaily> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    // widget.waterdata.toList();
    // widget.fertdata.toList();
    // print(widget.waterdata.toList());
    // print(widget.fertdata.toList());
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
                  // dataSource: widget.fertdata
                  //     .map((e) => DailyFert(e['fert_name'], e['ferting_amount']()))
                  //     .toList(),
                  // dataSource: widget.fertdata.toList() as List<DailyFert>,
                  // xValueMapper: (DailyFert fert, _) => fert.fertname,
                  // yValueMapper: (DailyFert fert, _) => fert.fertamount,
                  dataSource: [
                    DailyFert('ไฮโดรเมลอน A B', 50),
                    DailyFert('แคลเอ็ม',100),
                    
                  ],
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

class DailyFert {
  DailyFert(this.fertname, this.fertamount);

  final String? fertname;
  final double? fertamount ;

   


  DailyFert.fromJson(Map<String, dynamic> json)
      : fertname = json['fert_name'],
        fertamount = json['ferting_amount'];
}

class DailyWater {
  DailyWater(this.periodname, this.watercount);

  final String periodname;
  final int watercount;

  DailyWater.fromJson(Map<String, dynamic> json)
      : periodname = json['period_name'],
        watercount = json['water_count'];
}
