import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:newmelonedv2/sub_daily/carelist.dart';
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
  const DailyMenu({Key? key, required CareList carelist}) : super(key: key);

  @override
  State<DailyMenu> createState() => _DailyMenuState();
}

class _DailyMenuState extends State<DailyMenu> {
  dynamic period_ID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    setState(() {
      period_ID = id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Period ID on DailyMenu: $period_ID");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('กรีนสวีท'),
          bottom: TabBar(
            tabs: [
              Tab(
                  text: 'การให้น้ำ',
                  icon: Icon(
                    Icons.water_drop,
                  )),
              Tab(text: 'การให้ปุ๋ย', icon: Icon(Icons.science)),
              Tab(text: 'จดบันทึก', icon: Icon(Icons.format_list_bulleted)),
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
