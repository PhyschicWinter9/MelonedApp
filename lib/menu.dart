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
                                    color: Color.fromRGBO(159, 159, 54, 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // client.getCurretWeather(lat, lon);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Period()),
                                        );
                                      });
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 75,
                                      color: Color.fromRGBO(227, 209, 106, 1),
                                    ))),
                            sizedBox.Boxh5(),
                            Text('รอบการปลูก',style: TextCustom.bold_b16(),),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 176, 103, 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Daily()),
                                        );
                                      });
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 75,
                                      color: Color.fromRGBO(251, 249, 218, 1),
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
                                    color: Color.fromRGBO(255, 214, 104, 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                //ปุ่มเมนู analyze
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Analyze()),
                                      );
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
                                    color: Color.fromRGBO(227, 209, 106, 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                height: 130,
                                width: 130,
                                //ปุ่มเมนู Summary
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Summary()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.insights,
                                      size: 75,
                                      color: Color.fromRGBO(172, 112, 79, 1),
                                    ))),
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