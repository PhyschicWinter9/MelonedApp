// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'reuse/container.dart';
import 'sub_daily/carecard.dart';
import 'sub_daily/carelist.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';
import 'sub_daily/carelist.dart';
import 'sub_daily/carecard.dart';

class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);
  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  List<CareList> carelist = [
    CareList('กรีนสวีท', 2, 2, 3),
    CareList('เจียไต๋', 2, 2, 3),
    CareList('แคนตาลูป', 2, 2, 3),
    CareList('เน็ตเมลอน', 2, 2, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การดูแลประจำวัน',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: ListView.builder(
          itemCount: carelist.length,
          itemBuilder: (context, index) {
            return CareCard(carelist: carelist[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
