import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newmelonedv2/menu.dart';
import 'package:newmelonedv2/period.dart';
import 'package:newmelonedv2/daily.dart';
import 'package:newmelonedv2/analyze.dart';
import 'package:newmelonedv2/summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart ' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EditPeriod extends StatefulWidget {

  final List list;
  final int index;

  const EditPeriod({Key? key,required this.index,required this.list}) : super(key: key);

  @override
  State<EditPeriod> createState() => _EditPeriodState();
}

class _EditPeriodState extends State<EditPeriod> {

    //Variables
    var greenhouseidController = new TextEditingController();
    var periodidController = new TextEditingController();
    var createdateController = new TextEditingController();
    var harvestdateController = new TextEditingController();
    
    

    bool editMode = false;


  //Get Data
  Future getPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  //Delete Period
  Future deletePeriod(String period_ID) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/period/deleteperiod.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': widget.list[widget.index]['period_ID'],
      });
      var data = json.decode(response.body);
      // print(data);
      if (data == "Success") {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        // getdata();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Period()),
        // );
        Navigator.pop(context);
        setState(() {});
      } else {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }


  //Finish
    Future FinishPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/finish_period.php";
    var response = await http.post(Uri.parse(url),body: {
      'period_ID': widget.list[widget.index]['period_ID'],
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      greenhouseidController.text = widget.list[widget.index]['greenhouse_ID'];
      periodidController.text = widget.list[widget.index]['period_ID'];
      createdateController.text = widget.list[widget.index]['create_date'];
      harvestdateController.text = widget.list[widget.index]['harvest_date'];


    }
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
        title: Text(
          'รายละเอียดการปลูก',
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //////////////////////////////////////////////////////////
              //////////////////////////////////////////////////////////
              /*____________________ลบรอบการปลูก_______________________*/
              //////////////////////////////////////////////////////////
              //////////////////////////////////////////////////////////
              setState(() {
                print(widget.list[widget.index]['period_ID']);
                deletePeriod(widget.list[widget.index]['period_ID']);
                
              });
            },
            icon: Icon(
              Icons.delete_outline,
              size: 30,
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
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      //GreenhouseID Row
                      Row(
                        children: [
                          Text(
                            'หมายเลขโรงเรือน',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 18,
                              color: Color.fromRGBO(172, 112, 79, 1),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // TExt show data from sql when select period
                          Expanded(
                            child: TextField(
                              controller: greenhouseidController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 18,
                                  color: Color.fromRGBO(172, 112, 79, 1),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),

                        ],
                      ),

                      // Start Date Row
                      Row(
                        children: [
                          Text(
                            'วันที่สร้างรอบการปลูก',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 18,
                              color: Color.fromRGBO(172, 112, 79, 1),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              controller: createdateController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 18,
                                  color: Color.fromRGBO(172, 112, 79, 1),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),

                      //Harvest Date Row
                      Row(
                        children: [
                          Text(
                            'วันที่คาดว่าจะเก็บเกี่ยว',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 18,
                              color: Color.fromRGBO(172, 112, 79, 1),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              controller: harvestdateController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 18,
                                  color: Color.fromRGBO(172, 112, 79, 1),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),

                      // left day row
                      Row(
                        children: [
                          Text(
                            'อายุเมลอน',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 18,
                              color: Color.fromRGBO(172, 112, 79, 1),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              controller: periodidController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 18,
                                  color: Color.fromRGBO(172, 112, 79, 1),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Color.fromRGBO(253, 212, 176, 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      /////////////////////////////////////////////////////////////////////
                      /////////////////////////////////////////////////////////////////////
                      /*เสร็จสิ้นรอบการปลูก ย้ายรอบการปลูกนี้ไปไว้ใน History ดูได้อย่างเดียวแต่แก้ไขไม่ได้*/
                      ////////////////////////////////////////////////////////////////////
                      ////////////////////////////////////////////////////////////////////
                      onPressed: () {
                        
                        setState(() {
                          FinishPeriod();

                        });
                      },
                      child: Text(
                        'เสร็จสิ้นรอบการปลูก',
                        style: GoogleFonts.kanit(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
                      ),
                    )),
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
