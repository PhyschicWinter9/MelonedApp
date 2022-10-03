// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'reuse/bottombar.dart';
import 'style/textstyle.dart';


class Summary extends StatefulWidget {
  Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายงานสรุป',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dailysummaryform');
              },
              child: Text(
                'สรุปรายวัน',
                style: TextCustom.semibold_dg20(),
              ),
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.lightyellowcolor(),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.11125),
              ),
            ),
            sizedBox.Boxh20(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weeklysummaryform');
              },
              child: Text(
                'สรุปรายสัปดาห์',
                style: TextCustom.semibold_dg20(),
              ),
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.lightgreencolor(),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.11125),
              ),
            ),
            sizedBox.Boxh20(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/monthlysummaryform');
              },
              child: Text(
                'สรุปรายเดือน',
                style: TextCustom.semibold_dg20(),
              ),
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.yellowcolor(),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.11125),
              ),
            ),
            sizedBox.Boxh20(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/yearlysummaryform');
              },
              child: Text(
                'สรุปรายปี',
                style: TextCustom.semibold_dg20(),
              ),
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.orangecolor(),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.11125),
              ),
            ),
            sizedBox.Boxh20(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/periodsummaryform');
              },
              child: Text(
                'สรุปรายรอบการปลูก',
                style: TextCustom.semibold_dg20(),
              ),
              style: ElevatedButton.styleFrom(
                primary: ColorCustom.creamcolor(),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.height * 0.11125),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class ElevatedSummary extends StatelessWidget {
  final String title;
  final Color colorPrimary;
  final VoidCallback onClick;
  ElevatedSummary(this.title, this.colorPrimary, this.onClick);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text(
        title,
        style: TextCustom.semibold_dg20(),
      ),
      style: ElevatedButton.styleFrom(
        primary: colorPrimary,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, MediaQuery.of(context).size.height * 0.11125),
      ),
    );
  }
}
