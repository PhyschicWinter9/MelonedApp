import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'menu.dart';
import 'period.dart';
import 'daily.dart';
import 'style/colortheme.dart';
import 'style/textstyle.dart';
import 'summary.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';

class Analyze extends StatefulWidget {
  Analyze({Key? key}) : super(key: key);

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  List<AnalyzeItem> analyzeitem = [
    AnalyzeItem('โรงเรือน 1', 60, 20),
    AnalyzeItem('โรงเรือน 2', 60, 0),
    AnalyzeItem('โรงเรือน 3', 60, 0)
  ];

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
        child: ListView.builder(
          itemCount: analyzeitem.length,
          itemBuilder: (context, index) {
            return AnalyzeCard(analyzeitem: analyzeitem[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class AnalyzeItem {
  final String periodName;
  final int totalMelon;
  final int totalMelonAnalyzed;

  AnalyzeItem(this.periodName, this.totalMelon, this.totalMelonAnalyzed);
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
              Navigator.pushNamed(context, '/analyzedetail');
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.analyzeitem.periodName}',
                        style: TextCustom.bold_b20()),
                    Text(
                        'จำนวนเมลอนที่วิเคราะห์แล้ว : ' +
                            '${widget.analyzeitem.totalMelonAnalyzed}/${widget.analyzeitem.totalMelon}' +
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
