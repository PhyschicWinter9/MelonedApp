import 'package:flutter/material.dart';
import 'analyze.dart';
import 'period.dart';
import 'reuse/bottombar.dart';
import 'reuse/container.dart';
import 'reuse/hamburger.dart';
import 'sub_daily/fert.dart';
import 'sub_daily/note.dart';
import 'sub_daily/water.dart';
import 'summary.dart';

import 'style/colortheme.dart';

class DailyMenu extends StatefulWidget {
  const DailyMenu({Key? key}) : super(key: key);

  @override
  State<DailyMenu> createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('กรีนสวีท'),
          bottom: TabBar(
            
            tabs: [
              Tab(
                text: 'การให้น้ำ',
                icon: Icon(Icons.water_drop,),
              ),
              Tab(text: 'การให้ปุ๋ย', icon: Icon(Icons.science)),
              Tab(text: 'โน้ต', icon: Icon(Icons.format_list_bulleted)),
            ],
          ),
        ),
        drawer: Hamburger(),
        body: BGContainer(
          child: TabBarView(
            children: [
              Water(),
              Fert(),
              Note(),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
