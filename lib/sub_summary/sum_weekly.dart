import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../reuse/container.dart';
import '../reuse/hamburger.dart';
import 'package:intl/intl.dart';
import '../reuse/sizedbox.dart';
import '../style/textstyle.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';

class SummaryWeekly extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  // const SummaryWeekly({Key? key}) : super(key: key);

  @override
  State<SummaryWeekly> createState() => _SummaryWeeklyState();
}

class _SummaryWeeklyState extends State<SummaryWeekly> {
  //Variable
  List greenhouse = [];
  String? selectedValue;

  //Controller
  TextEditingController datestartController = TextEditingController();
  TextEditingController dateendController = TextEditingController();
  //GET DATA FROM API
  //GET GREENHOUSE IN SUMMARY WEEKLY PAGE
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

  DateTimeRange? _selectDateTime;
  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'ตกลง',
    );
    if (result != null) {
      print(result.start.toString());
      setState(() {
        _selectDateTime = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายสัปดาห์'),
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
            sizedBox.Boxh5(),
            Text(
              'วันที่เริ่มต้น',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            TextField(
              controller: datestartController,
              decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  hintText: 'กรุณาใส่วันที่'),
              style: TextCustom.normal_mdg16(),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  setState(() {
                    datestartController.text = formattedDate.toString();
                  });
                } else {
                  print('Not Selected');
                }
              },
            ),
            sizedBox.Boxh5(),
            Text(
              'วันที่สิ้นสุด',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            TextField(
              controller: dateendController,
              decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  hintText: 'กรุณาใส่วันที่'),
              style: TextCustom.normal_mdg16(),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  setState(() {
                    dateendController.text = formattedDate.toString();
                  });
                } else {
                  print('Not Selected');
                }
              },
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {},
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
