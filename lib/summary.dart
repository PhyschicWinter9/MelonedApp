// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newmelonedv2/menu.dart';
import 'package:newmelonedv2/period.dart';
import 'package:newmelonedv2/daily.dart';
import 'package:newmelonedv2/analyze.dart';
class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
        elevation: 0,
        title: const Text(
          'Summary',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(child: Container(
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(227, 209, 106, 1),
            //       ),
            //     )),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Expanded(child: Container(
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(227, 209, 106, 1),
            //       ),
            //     )),
            //   ],
            // ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Period()),
                  );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Period()),
              );
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
