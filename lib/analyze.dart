import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'style/colortheme.dart';
import 'style/textstyle.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Analyze extends StatefulWidget {
  Analyze({Key? key}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  List<AnalyzeItem> analyzeitem = [];

  Future getPeriod() async {
    var url = Uri.parse(
        "https://meloned.relaxlikes.com/api/analysis/viewperiod_melon.php");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      AnalyzeItem item = AnalyzeItem(
        data[i]['period_ID'],
        data[i]['period_name'],
        data[i]['planted_melon'],
        data[i]['total_grades'],
      );
      this.analyzeitem.add(item);
    }
    return analyzeitem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณภาพเมลอน',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPeriod(),
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
                    return analyzeitem.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnalyzeCard(
                                analyzeitem: analyzeitem[index],
                              );
                            })
                        : Center(
                            child: Text(
                              'ไม่มีรายการ',
                              style: TextCustom.normal_mdg20(),
                            ),
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class AnalyzeItem {
  final String period_ID;
  final String period_name;
  final String planted_melon;
  final String total_grades;

  AnalyzeItem(
    this.period_ID,
    this.period_name,
    this.planted_melon,
    this.total_grades,
  );
}

class AnalyzeCard extends StatefulWidget {
  AnalyzeItem analyzeitem;
  AnalyzeCard({Key? key, required this.analyzeitem}) : super(key: key);

  @override
  State<AnalyzeCard> createState() => _AnalyzeCardState();
}

class _AnalyzeCardState extends State<AnalyzeCard> {
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
              Navigator.of(context).pushNamed("/analyzedetail", arguments: {
                'period_ID': widget.analyzeitem.period_ID,
              }).then((value) => setState(() {}));
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.analyzeitem.period_name}',
                        style: TextCustom.bold_b20()),
                    Text(
                        'จำนวนเมลอนที่วิเคราะห์แล้ว : ' +
                            '${widget.analyzeitem.total_grades}/${widget.analyzeitem.planted_melon}' +
                            ' ลูก',
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
