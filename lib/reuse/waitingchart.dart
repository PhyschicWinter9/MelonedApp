import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../style/textstyle.dart';

class WaitingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            children: [
              Lottie.asset(
                "assets/animate/chartloading.json",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "กำลังประมวลผล",
                style: TextCustom.bold_b16(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}