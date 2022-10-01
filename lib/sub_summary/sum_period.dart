import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class SummaryPeriod extends StatefulWidget {
  final List<String> period = [
    'กรีนสวีท รอบ 22-08-2021',
    'เจียไต๋ รอบ 22-10-2021',
    'เน็ตเมลอน รอบ 22-12-2021',
  ];

  final _formKey = GlobalKey<FormState>();
  //const SummaryPeriod({Key? key}) : super(key: key);

  @override
  State<SummaryPeriod> createState() => _SummaryPeriodState();
}

class _SummaryPeriodState extends State<SummaryPeriod> {
  //Variable
  List greenhouse = [];
  String? selectedValue;

  //GET DATA FROM API
   //GET GREENHOUSE IN SUMMARY PERIOD PAGE
  Future getGreenHouse() async {
    var url = "https://meloned.relaxlikes.com/api/summary/viewgreenhouse.php";
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    setState(() {
      greenhouse = data;
    });
    return greenhouse;
  }

  @override
  void initState() {
    super.initState();
    getGreenHouse();
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
              items: greenhouse.map((value) {
                return DropdownMenuItem(
                  value: value['greenhouse_ID'],
                  child: Text(
                    value['greenhouse_Name'],
                    style: TextCustom.normal_mdg16(),
                  ),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกโรงเรือน';
                }
              },
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                  print(selectedValue);
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
