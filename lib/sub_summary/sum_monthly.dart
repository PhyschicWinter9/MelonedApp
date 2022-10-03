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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class SummaryMonthly extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  //const SummaryMonthly({Key? key}) : super(key: key);

  @override
  State<SummaryMonthly> createState() => _SummaryMonthlyState();
}

class _SummaryMonthlyState extends State<SummaryMonthly> {
  //Variable
  List greenhouse = [];
  String? selectedValue;
  DateTime? _selected;

  TextEditingController monthController = TextEditingController();

  //GET DATA FROM API
  //GET GREENHOUSE IN SUMMARY MONTHLY PAGE
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
    monthController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายเดือน'),
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
              'เดือนที่ต้องการดูสรุป',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: monthController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'ยังไม่ได้เลือกเดือน',
                  ),
                  style: TextCustom.normal_mdg16(),
                  readOnly: true,
                  onTap: () async {
                    // getPicker();
                    
                    String? locale;
                    final localeObj = locale != null ? Locale(locale) : null;
                    DateTime? selected = await showMonthYearPicker(
                      context: context,
                      initialDate: _selected ?? DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2100),
                      locale: localeObj,
                    );
                    
                    if (selected != null) {
                      String formattedMonth = DateFormat('MM-yyyy').format(selected);
                      setState(() {
                        monthController.text = formattedMonth.toString();
                      });
                    } else {
                      print('ยังไม่ได้เลือกเดือน');
                    }
                  },
                ),
              ],
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {
                //Chnage formate date
                var date = monthController.text;
                var dateSplit = date.split('-');
                var monthChangeFormat = dateSplit[1];
                var yearChangeFormat = dateSplit[0];
                // print(monthChangeFormat);
                // print(yearChangeFormat);
                
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
