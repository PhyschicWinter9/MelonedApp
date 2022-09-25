import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';

import '../reuse/bottombar.dart';
import '../reuse/container.dart';
import '../reuse/hamburger.dart';

class AnalyzeDetail extends StatefulWidget {
  const AnalyzeDetail({Key? key}) : super(key: key);

  @override
  State<AnalyzeDetail> createState() => _AnalyzeDetailState();
}

class _AnalyzeDetailState extends State<AnalyzeDetail> {
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
            Card(
              color: ColorCustom.lightyellowcolor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'โรงเรือน 1',
                          style: TextCustom.bold_b20(),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('แก้ไข'),
                              sizedBox.Boxw5(),
                              Icon(Icons.settings),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: ColorCustom.lightgreencolor(),
                            onPrimary: ColorCustom.lightyellowcolor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedBox.Boxh5(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนทั้งหมด', style: TextCustom.normal_dg16()),
                        Text('20/60', style: TextCustom.normal_b16()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนเกรด A', style: TextCustom.normal_dg16()),
                        Text('5',style: TextCustom.normal_b16()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนเกรด B', style: TextCustom.normal_dg16()),
                        Text('4',style: TextCustom.normal_b16()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนเกรด C', style: TextCustom.normal_dg16()),
                        Text('1',style: TextCustom.normal_b16()),
                      ],
                    ),
                    sizedBox.Boxh5(),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('ย้อนกลับ'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: ColorCustom.yellowcolor(),
                onPrimary: ColorCustom.lightyellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 20),
                textStyle: TextCustom.buttontext2(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
