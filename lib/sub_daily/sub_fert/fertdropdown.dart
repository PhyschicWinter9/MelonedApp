import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../style/colortheme.dart';


class DropDownList2 extends StatefulWidget {
  
  final List<String> fertname = [
    'อัลฟา',
    'ปุ๋ยไฮโดรเมลอน A B',
    'แคลเอ็ม',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();


  @override
  State<DropDownList2> createState() => _DropDownList2State();
}

class _DropDownList2State extends State<DropDownList2> {
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
      items: widget.fertname.map((String value) {
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
  );
}
}