import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import '../../style/colortheme.dart';

class DropDownList2 extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  State<DropDownList2> createState() => _DropDownList2State();
}

class _DropDownList2State extends State<DropDownList2> {
  List fertname = [];
  String? selectedValue;

  creteSession() async {
    await SessionManager().set("fert_ID", selectedValue);
  }

 
  Future getFert() async {
    var url = "https://meloned.relaxlikes.com/api/dailycare/view_fertilize.php";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    var data = json.decode(response.body);
    setState(() {
      fertname = data;
    });
    return fertname;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: Text(
        'เลือกสูตรปุ๋ย',
        style: TextCustom.normal_mdg16()
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
      items: fertname.map((value) {
        return DropdownMenuItem(
          value: value['fert_ID'].toString(),
          child: Text(
            value['fert_name'],
            style: TextCustom.normal_mdg16(),
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'เลือกสูตรปุ๋ย';
        }
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          creteSession();
        });
      
      },
      // onSaved: (value) {
      //   selectedValue = value.toString();
      // },
    );
  }
}
