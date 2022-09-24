import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
    final List<String> fertname = [
    'อัลฟา',
    'ปุ๋ยไฮโดรเมลอน A B',
    'แคลเอ็ม',
  ];
  String? selectedValue;

  DropDownList({Key? key}) : super(key: key);

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: widget.fertname.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme
                          .of(context)
                          .hintColor,
                ),
              ),
            );
          }).toList(),
          value: widget.selectedValue,
          onChanged: (value) {
            setState(() {
              widget.selectedValue = value as String?;
            });
          },
          buttonHeight: 40,
          buttonWidth: double.infinity,
          itemHeight: 40,
        ),
      ),
    ),
  );
}
}