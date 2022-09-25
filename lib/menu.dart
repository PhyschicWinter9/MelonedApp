// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'reuse/container.dart';
import 'style/textstyle.dart';
import 'sub_menu/weatherapi.dart';
import 'period.dart';
import 'daily.dart';
import 'analyze.dart';
import 'summary.dart';
import 'reuse/hamburger.dart';
import 'reuse/bottombar.dart';
import 'reuse/sizedbox.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก',),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WeatherAPI(),
            sizedBox.Boxh20(),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorCustom.mediumgreencolor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/period');
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 75,
                                      color: ColorCustom.yellowcolor(),
                                    ))),
                            sizedBox.Boxh5(),
                            Text('รอบการปลูก',style: TextCustom.bold_b16(),),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorCustom.orangecolor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/daily');
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 75,
                                      color: ColorCustom.lightyellowcolor(),
                                    ))),
                            sizedBox.Boxh5(),
                            Text('การดูแลรายวัน',style: TextCustom.bold_b16(),),
                          ],
                        ),
                      ],
                    ),
                    sizedBox.Boxh10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorCustom.yellowcolor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                //ปุ่มเมนู analyze
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/analyze');
                                    },
                                    icon: Icon(
                                      Icons.troubleshoot,
                                      size: 75,
                                      color: Colors.white,
                                    ))),
                            sizedBox.Boxh5(),
                            Text('วิเคราะห์คุณภาพ',style: TextCustom.bold_b16(),),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: ColorCustom.lightgreencolor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                //ปุ่มเมนู Summary
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/summary');
                                    },
                                    icon: Icon(
                                      Icons.insights,
                                      size: 75,
                                      color: ColorCustom.darkgreencolor()),
                                    )),
                            sizedBox.Boxh5(),
                            Text('สรุป',style: TextCustom.bold_b16(),),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}