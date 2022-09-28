import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'package:intl/intl.dart';
import 'package:newmelonedv2/reuse/sizedbox.dart';
import 'package:newmelonedv2/style/textstyle.dart';

import '../reuse/bottombar.dart';
import '../style/colortheme.dart';

class SummaryDaily extends StatefulWidget {
  final List<String> greenhouse = [
    'โรงเรือน 1',
    'โรงเรือน 2',
    'โรงเรือน 3',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  // const SummaryDaily({Key? key}) : super(key: key);

  @override
  State<SummaryDaily> createState() => _SummaryDailyState();
}

class _SummaryDailyState extends State<SummaryDaily> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            Text('โรงเรือน',style: TextCustom.textboxlabel(),),
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
                  return 'เลือกสูตรปุ๋ย';
                }
              },
              onChanged: (value) {},
              onSaved: (value) {
                widget.selectedValue = value.toString();
              },
            ),
            sizedBox.Boxh10(),
            Text('วันที่ต้องการสรุป',style: TextCustom.textboxlabel(),),
            sizedBox.Boxh5(),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon:  Icon(Icons.calendar_today),
                hintText: 'กรุณาใส่วันที่'
              ),
              style: TextStyle(
                color: ColorCustom.mediumgreencolor(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate=await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if(pickedDate!=null){
                  String formattedDate=DateFormat('dd-MM-yyyy').format(pickedDate);
                  setState(() {
                    dateController.text = formattedDate.toString();
                  });
                }else{
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
