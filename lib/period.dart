import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu.dart';
import 'daily.dart';
import 'analyze.dart';
import 'sub_period/new_period.dart';
import 'sub_period/edit_period.dart';
import 'summary.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'historyperiod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:geolocator/geolocator.dart';

class Period extends StatefulWidget {
  const Period({Key? key}) : super(key: key);

  @override
  State<Period> createState() => _PeriodState();
}

class _PeriodState extends State<Period> {

  @override
  void initState() {
    super.initState();
  }

  Future detailpreiod(String period_ID, String create_date, String harvest_date,
      String greenhouse_ID) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
        'create_date': create_date,
        'harvest_date': harvest_date,
        'greenhouse_ID': greenhouse_ID,
      });
      var data = json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future getPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
        elevation: 0,
        title: const Text(
          'Plant Period',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 20,
            color: Color.fromRGBO(251, 249, 218, 1),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Color.fromRGBO(251, 249, 218, 1),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewPeriod()),
              );
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Color.fromRGBO(227, 209, 106, 1),
            ),
          ),
        ],
      ),
      /*______Hamburger Button______*/
      drawer: Hamburger1(sidemenu: sidemenu),

      /*______content_____*/
      body: Container(
        color: Color.fromRGBO(159, 159, 54, 1),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                //period lists
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryPeriod()),
                            );
                          });
                        },
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Text(
                                'View History',
                                style: GoogleFonts.kanit(
                                    color: Color.fromRGBO(245, 176, 103, 1)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.history,
                                color: Color.fromRGBO(245, 176, 103, 1),
                              ),
                            ],
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(251, 249, 218, 1),
                        )),
                  ],
                ),
                Container(
                  child: FutureBuilder(
                      future: getPeriod(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoadingAnimationWidget.waveDots(
                                  color: Color.fromRGBO(245, 176, 103, 1),
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    'กำลังโหลดข้อมูล...',
                                    style: GoogleFonts.kanit(
                                      fontSize: 20,
                                      color: Color.fromRGBO(159, 159, 54, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                List list = snapshot.data;
                                return Card(
                                  color: Color.fromRGBO(253, 212, 176, 1),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          snapshot.data[index]
                                              ['greenhouse_name'],
                                          style: GoogleFonts.kanit(),
                                        ),
                                        subtitle: Text(
                                          'วันที่ปลูก  ' +
                                              snapshot.data[index]
                                                  ['create_date'],
                                          style: GoogleFonts.kanit(),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.settings),
                                          onPressed: () {
                                            detailpreiod(
                                              snapshot.data[index]['period_ID'],
                                              snapshot.data[index]
                                                  ['create_date'],
                                              snapshot.data[index]
                                                  ['harvest_date'],
                                              snapshot.data[index]
                                                  ['greenhouse_ID'],
                                            );

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPeriod(
                                                          list: list,
                                                          index: index,
                                                        )));
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'คาดว่าจะเก็บเกี่ยวได้ในวันที่ ' +
                                              snapshot.data[index]
                                                  ['harvest_date'],
                                          style: GoogleFonts.kanit(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),

      /*____Bottom Bar____*/
      bottomNavigationBar: MyBottomBar(),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////
  /*_____________Style____________*/
  TextStyle sidemenu = const TextStyle(
    fontFamily: 'Kanit',
    fontSize: 15,
    color: Color.fromRGBO(116, 116, 39, 1),
  );
}

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        color: Color.fromRGBO(159, 159, 54, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //ปุ่ม Period
            Container(
              child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Period()),
                  // );
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Color.fromRGBO(227, 209, 106, 1),
                  size: 40,
                ),
              ),
            ),
            //ปุ่ม Daily
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Daily()),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
            //ปุ่ม Home
            Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(251, 249, 218, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: Color.fromRGBO(227, 209, 106, 1),
                    size: 40,
                  ),
                )),
            //ปุ่ม Analyze
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Analyze()),
                );
              },
              icon: Icon(
                Icons.troubleshoot,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
            Container(
                child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Summary()),
                );
              },
              icon: Icon(
                Icons.insights,
                color: Color.fromRGBO(227, 209, 106, 1),
                size: 40,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class Hamburger1 extends StatelessWidget {
  const Hamburger1({
    Key? key,
    required this.sidemenu,
  }) : super(key: key);

  final TextStyle sidemenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(159, 159, 54, 1),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Surat Lhaodee',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainMenu()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Period',
              style: sidemenu,
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Period()),
              // );
            },
          ),
          ListTile(
            title: Text(
              'Daily Care',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Daily()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Analyze',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Analyze()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Summary',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Summary()),
              );
            },
          ),
        ],
      ),
    );
  }
}
