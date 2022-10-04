import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newmelonedv2/period.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import '../reuse/bottombar.dart';
import '../reuse/hamburger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart ' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EditPeriod extends StatefulWidget {
  final List list;
  final int index;

  const EditPeriod({Key? key, required this.index, required this.list})
      : super(key: key);

  @override
  State<EditPeriod> createState() => _EditPeriodState();
}

class _EditPeriodState extends State<EditPeriod> {
  //Variables
  var greenhouseidController = new TextEditingController();
  var plantmelonController = new TextEditingController();
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
    var response = await http.post(Uri.parse(url), body: {
      'period_ID': widget.list[widget.index]['period_ID'],
    });
    return json.decode(response.body);
  }

  void SubmitPeriod() async {
    //create asyn function
    await FinishPeriod();
    Navigator.pop(context);
    print('SubmitPeriod Function Success');
    //Refresh
    setState(() {
      //refresh previous page
      Period();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      greenhouseidController.text = widget.list[widget.index]['greenhouse_ID'];
      plantmelonController.text = widget.list[widget.index]['planted_melon'];
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
        title: Text(
          'รายละเอียดการปลูก',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                print(widget.list[widget.index]['period_ID']);
                deletePeriod(widget.list[widget.index]['period_ID']);
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorCustom.lightyellowcolor(),
              ),
              child: Column(
                children: [
                  //GreenhouseID Row
                  Row(
                    children: [
                      Text(
                        'หมายเลขโรงเรือน',
                        style: TextCustom.bold_b16(),
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
                          ),
                          enabled: false,
                          style: TextCustom.normal_dg16(),
                        ),
                      ),
                    ],
                  ),

                  // Start Date Row
                  Row(
                    children: [
                      Text(
                        'วันที่สร้างรอบการปลูก',
                        style: TextCustom.bold_b16(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: createdateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          enabled: false,
                          style: TextCustom.normal_dg16(),
                        ),
                      ),
                    ],
                  ),

                  //Harvest Date Row
                  Row(
                    children: [
                      Text(
                        'วันที่คาดว่าจะเก็บเกี่ยว',
                        style: TextCustom.bold_b16(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: harvestdateController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          enabled: false,
                          style: TextCustom.normal_dg16(),
                        ),
                      ),
                    ],
                  ),

                  // left day row
                  Row(
                    children: [
                      Text(
                        'จำนวนเมลอน',
                        style: TextCustom.bold_b16(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: plantmelonController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          enabled: false,
                          style: TextCustom.normal_dg16(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sizedBox.Boxh5(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // FinishPeriod();
                  SubmitPeriod();
                });
              },
              child: Text('เสร็จสิ้นรอบการปลูก', style: TextCustom.buttontext2()),
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: ColorCustom.yellowcolor(),
                onPrimary: ColorCustom.lightyellowcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
