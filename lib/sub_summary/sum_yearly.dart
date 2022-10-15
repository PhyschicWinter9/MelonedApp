import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
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

class SummaryYearly extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  //const SummaryYearly({Key? key}) : super(key: key);

  @override
  State<SummaryYearly> createState() => _SummaryYearlyState();
}

class _SummaryYearlyState extends State<SummaryYearly> {
  //Variable
  List greenhouse = [];
  String? selectedValue;
  DateTime? _selected;

  //Function
  createSession() async {
    await SessionManager().set('greenhouseid', selectedValue);
    await SessionManager().set("year", yearController.text);
  }

  resetSession() async {
    await SessionManager().destroy();
  }


  TextEditingController yearController = TextEditingController();

  //GET DATA FROM API
  //GET GREENHOUSE IN SUMMARY YEARLY PAGE
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
    resetSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สรุปรายปี'),
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
              'ปีที่ต้องการดูสรุป',
              style: TextCustom.textboxlabel(),
            ),
            sizedBox.Boxh5(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'ยังไม่ได้เลือกปี',
                  ),
                  style: TextCustom.normal_mdg16(),
                  readOnly: true,
                  onTap: () async {
                    // getPicker();
                    String? locale;
                    final localeObj = locale != null ? Locale(locale) : null;
                    DateTime? selected = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("เลือกปี"),
                          content: Container(
                            // Need to use container to add size constraint.
                            width: 300,
                            height: 300,
                            child: YearPicker(
                              firstDate: DateTime(DateTime.now().year - 100, 1),
                              lastDate: DateTime(DateTime.now().year + 100, 1),
                              initialDate: DateTime.now(),
                              selectedDate: DateTime.now(),
                              onChanged: (DateTime dateTime) {
                                setState(() {
                                  _selected = dateTime;
                                });
                                Navigator.pop(context, _selected);
                              },
                            ),
                          ),
                        );
                      },
                    );

                    // showMonthYearPicker(
                    //   initialMonthYearPickerMode: MonthYearPickerMode.year,
                    //   context: context,
                    //   initialDate: _selected ?? DateTime.now(),
                    //   firstDate: DateTime(2019),
                    //   lastDate: DateTime(2100),
                    //   locale: localeObj,
                    // );
                    if (selected != null) {
                      String formattedYear =
                          DateFormat('yyyy').format(_selected!);
                      setState(() {
                        yearController.text = formattedYear.toString();
                      });
                    } else {
                      print('ยังไม่ได้เลือกปี');
                    }
                  },
                ),
              ],
            ),
            sizedBox.Boxh10(),
            ElevatedButton(
              onPressed: () {
                createSession();
                Navigator.pushNamed(context, '/yearlysummary');
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
