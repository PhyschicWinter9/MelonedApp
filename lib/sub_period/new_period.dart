import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../menu.dart';
import '../period.dart';
import '../daily.dart';
import '../analyze.dart';
import '../style/colortheme.dart';
import '../summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class NewPeriod extends StatefulWidget {
  const NewPeriod({Key? key}) : super(key: key);

  @override
  State<NewPeriod> createState() => _NewPeriodState();
}

class _NewPeriodState extends State<NewPeriod> {
  List greenhouse = [];
  String? selectval;

  //GET REGISTERED GREENHOUSE
  Future RegisterPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/insert_period.php";

    var response = await http.post(Uri.parse(url), body: {
      'greenhouse_ID': selectval,
    });

    var jsonData = json.decode(response.body);
    print(jsonData);

    if (jsonData == "Fail") {
      Fluttertoast.showToast(
        msg: "สร้างรอบการปลูกล้มเหลว",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "สร้างรอบการปลูกสำเร็จ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    }
  }

  //GET GREENHOUSE
  Future getGreenHouse() async {
    var url =
        "https://meloned.relaxlikes.com/api/greenhouse/viewgreenhouse.php";

    var response = await http.get(Uri.parse(url));
    // greenhouse = json.decode(response.body);
    // return json.decode(response.body);

    var jsonData = json.decode(response.body);

    setState(() {
      greenhouse = jsonData;
    });
    return greenhouse;
  }

  @override
  void initState() {
    super.initState();
    getGreenHouse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
        elevation: 0,
        title: const Text(
          'เพิ่มรอบการปลูก',
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
          // width: screen_width,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เลือกโรงเรือน',
                  style: GoogleFonts.kanit(
                      fontSize: 18, color: Color.fromRGBO(116, 116, 39, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Color.fromRGBO(251, 249, 218, 1),
                  height: 50,

                  //////////////////////////////////////////////////////////////////
                  //////////////////////////////////////////////////////////////////
                  /*____________________Dropdown เลือกโรงเรือน_______________________*/
                  //////////////////////////////////////////////////////////////////
                  //////////////////////////////////////////////////////////////////
                  ///

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonFormField2(
                      buttonPadding: EdgeInsets.only(left: 20, right: 10),
                      buttonHeight: 50,
                      buttonWidth: double.infinity,
                      hint: Text(
                        'กรุณาเลือกโรงเรือน',
                        style: GoogleFonts.kanit(
                         color: ColorCustom.mediumgreencolor()
                        )
                      ),
                      isExpanded: true,
                      items: greenhouse.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(
                            item['greenhouse_Name'],
                            style: GoogleFonts.kanit(),
                          ),
                          value: item['greenhouse_ID'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          selectval = newVal as String;
                        });
                      },
                      value: selectval,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextButton(
                        ////////////////////////////////////////////////
                        //ปุ่มบันทึก
                        ////////////////////////////////////////////////
                        onPressed: () {
                          RegisterPeriod();
                        },
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(159, 159, 54, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextButton(
                        ////////////////////////////////////////////
                        //ปุ่มยกเลิก
                        /////////////////////////////////////////////
                        onPressed: () {
                          // Navigator.pop(context);
                          setState(() {
                            Navigator.pop(context);
                          });
                          setState(() {});
                        },
                        child: Text(
                          'ยกเลิก',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(172, 112, 79, 1),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  MaterialPageRoute(builder: (context) => Analyze()),
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
                MaterialPageRoute(builder: (context) => Analyze()),
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
