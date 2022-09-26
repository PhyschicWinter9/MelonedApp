import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';

import '../reuse/bottombar.dart';
import '../reuse/container.dart';
import '../reuse/hamburger.dart';

class EditAnalyze extends StatefulWidget {
  const EditAnalyze({Key? key}) : super(key: key);

  @override
  State<EditAnalyze> createState() => _EditAnalyzeState();
}

class _EditAnalyzeState extends State<EditAnalyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูลการวิเคราะห์',
        ),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            Card(
              elevation: 2,
              color: ColorCustom.lightyellowcolor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'โรงเรือน 1',
                      style: TextCustom.bold_b20(),
                    ),
                    sizedBox.Boxh15(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('เมลอนทั้งหมด', style: TextCustom.normal_dg16()),
                        Text('20/60', style: TextCustom.normal_b16()),
                      ],
                    ),
                    sizedBox.Boxh5(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด A',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด B',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('เมลอนเกรด C',
                                style: TextCustom.normal_dg16())),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                            ),
                            cursorColor: ColorCustom.darkgreencolor(),
                            style: TextCustom.normal_dg16(),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    sizedBox.Boxh5(),
                  ],
                ),
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {},
              child: Text('บันทึก', style: TextCustom.buttontext3()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.mediumgreencolor(),
                onPrimary: ColorCustom.lightgreencolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'ยกเลิก',
                style: TextCustom.buttontext3(),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
                onPrimary: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 20),
                padding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
