import 'package:flutter/material.dart';
import '../style/textstyle.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Image.asset(
            'assets/icon/logo.png',
            width: 60,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(251, 249, 218, 1),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'MELO',
          style: TextCustom.logofont1(),
        ),
        Text(
          'NED',
          style: TextCustom.logofont2(),
        ),
      ],
    );
  }
}