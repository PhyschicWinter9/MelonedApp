import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/sub_summary/showreport/showperiod.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class SummaryPeriod extends StatefulWidget {
  

  final _formKey = GlobalKey<FormState>();
  final _periodKey = GlobalKey<FormFieldState>();
  //const SummaryPeriod({Key? key}) : super(key: key);

  @override
  State<SummaryPeriod> createState() => _SummaryPeriodState();
}

class _SummaryPeriodState extends State<SummaryPeriod> {
  //Variable
  List greenhouse = [];
  List period = [];
  String? selectedValuegreenhouse;
  String? selectedValueperiod;


  //Function
  createSession() async {
    await SessionManager().set("periodid", selectedValueperiod);
  }

  resetSession() async {
    await SessionManager().destroy();
  }

  //GET DATA FROM API
  //GET GREENHOUSE IN SUMMARY PERIOD PAGE
  Future getGreenHouse() async {
    var url =
        "https://meloned.relaxlikes.com/api/summary/period/viewgreenhouse.php";
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    setState(() {
      greenhouse = data;
    });
    return greenhouse;
  }

  //GET PERIOD IN SUMMARY PERIOD PAGE when click dropdown button1 (greenhouse)
  Future getPeriod() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/period/get_period.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": selectedValuegreenhouse,
      });

      var data = json.decode(response.body);

      setState(() {
        period = data;
      });
      print(period);
      return period;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getGreenHouse();
    resetSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายรอบปลูก'),
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'โรงเรือน',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //icon: Icon(Icons.house),
              ),
              isExpanded: true,
              hint: Text(
                'เลือกโรงเรือน',
                style: TextCustom.normal_mdg16(),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: greenhouse.map((gvalue) {
                return DropdownMenuItem(
                  value: gvalue['greenhouse_ID'],
                  child: Text(
                    gvalue['greenhouse_Name'],
                    style: TextCustom.normal_mdg16(),
                  ),
                );
              }).toList(),
              validator: (gvalue) {
                if (gvalue == null) {
                  return 'กรุณาเลือกโรงเรือน';
                }
                return null;
              },
              onChanged: (gvalue) {
                setState(() {
                  selectedValuegreenhouse = gvalue.toString();
                  widget._periodKey.currentState!.reset();
                  getPeriod();
                });
              },
            ),
            sizedBox.Boxh10(),
            //รอบรายการปลูก
            Text(
              'รายรอบการปลูก',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            DropdownButtonFormField2(
              key: widget._periodKey,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //icon: Icon(Icons.house),
              ),
              isExpanded: true,
              hint: Text(
                'รอบการปลูก',
                style: TextCustom.normal_mdg16(),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: period.map((pvalue) {
                return DropdownMenuItem(
                  value: pvalue['period_ID'],
                  child: Text(
                    pvalue['period_name'],
                    style: TextCustom.normal_mdg16(),
                  ),
                );
              }).toList(),
              validator: (pvalue) {
                if (pvalue == null) {
                  return 'กรุณาเลือกรอบการปลูก';
                }
                return null;
              },
              // reset dropdownlist when click on first dropdownlist flutter
              onChanged: (pvalue) {
                setState(() {
                  selectedValueperiod = pvalue! as String;
                  print(selectedValueperiod);
                });
              },
            ),

            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {
                // print(selectedValuegreenhouse);
                // print(selectedValueperiod);
                //create session for greenhouse and period
                createSession();
                Navigator.pushNamed(context, '/periodsummary');
              },
              child: Text('ดูรายงาน', style: TextCustom.buttontext2()),
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
