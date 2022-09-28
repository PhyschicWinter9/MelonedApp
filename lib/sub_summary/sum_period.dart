import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class SummaryPeriod extends StatefulWidget {
  final List<String> greenhouse = [
    'โรงเรือน 1',
    'โรงเรือน 2',
    'โรงเรือน 3',
  ];

  final List<String> period = [
    'กรีนสวีท รอบ 22-08-2021',
    'เจียไต๋ รอบ 22-10-2021',
    'เน็ตเมลอน รอบ 22-12-2021',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  //const SummaryPeriod({Key? key}) : super(key: key);

  @override
  State<SummaryPeriod> createState() => _SummaryPeriodState();
}

class _SummaryPeriodState extends State<SummaryPeriod> {
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
                style: TextStyle(
                  color: ColorCustom.mediumgreencolor(),
                ),
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
              items: widget.greenhouse.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: ColorCustom.mediumgreencolor(),
                    ),
                  ),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกโรงเรือน';
                }
              },
              onChanged: (value) {},
              onSaved: (value) {
                widget.selectedValue = value.toString();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
