import 'package:flutter/material.dart';
import '../style/colortheme.dart';

//กำหนด style textfield
class SignUpList extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool hideText;
 SignUpList(
    {
      required this.controller,
      required this.hintText,
      required this.hideText,
      required this.icon,
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
      ),
      obscureText: hideText,
      cursorColor: ColorCustom.darkgreencolor(),
    );
  }
}