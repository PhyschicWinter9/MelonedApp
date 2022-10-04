import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:intl/intl.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/textstyle.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';

class SummaryDaily extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  // const SummaryDaily({Key? key}) : super(key: key);

  @override
  State<SummaryDaily> createState() => _SummaryDailyState();
}

class _SummaryDailyState extends State<SummaryDaily> {
  //Variable
  List greenhouse = [];
  String? selectedValue;
  var dateChangeFormat;

  //Controller
  TextEditingController dateController = TextEditingController();

  //GET DATA FROM API
  //GET GREENHOUSE IN SUMMARY DAILY PAGE
  Future getGreenHouse() async {
    var url = "https://meloned.relaxlikes.com/api/summary/viewgreenhouse.php";
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    setState(() {
      greenhouse = data;
    });
    return greenhouse;
  }

  //GET WATERING IN SUMMARY DAILY PAGE when click dropdown button1 (greenhouse)
  Future getWatering() async {
    try {
      var url =
          "https://meloned.relaxlikes.com/api/summary/daily/get_watering.php";
      var response = await http.post(Uri.parse(url), body: {
        "greenhouse_ID": selectedValue,
        "selected_date": dateChangeFormat,
      });

      var data = json.decode(response.body);
      print(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getGreenHouse();
    dateController.text = /*'วันที่ 1 มกราคม 2564'*/ "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายวัน'),
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
                  return 'เลือกโรงเรือน';
                }
              },
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                  print(selectedValue);
                });
              },
              // onSaved: (value) {
              //   widget.selectedValue = value.toString();
              // },
            ),
            sizedBox.Boxh10(),
            Text(
              'วันที่ต้องการดูสรุป',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            TextField(
              controller: dateController,
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
                    dateController.text = formattedDate.toString();
                  });
                } else {
                  print('Not Selected');
                }
              },
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {
                //change format date
                var date = dateController.text;
                var dateSplit = date.split('-');
                dateChangeFormat = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
                print(dateChangeFormat);
                getWatering();
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
