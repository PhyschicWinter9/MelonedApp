import 'package:flutter/material.dart';
import 'package:newmelonedv2/dailymenu.dart';
import 'package:newmelonedv2/style/colortheme.dart';
import 'package:newmelonedv2/style/textstyle.dart';
import 'package:newmelonedv2/sub_daily/carelist.dart';

class CareCard extends StatefulWidget {
  CareList carelist;
  CareCard({Key? key, required this.carelist}) : super(key: key);

  @override
  State<CareCard> createState() => _CareCardState();
}

class _CareCardState extends State<CareCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorCustom.lightyellowcolor(),
          onPrimary: ColorCustom.yellowcolor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DailyMenu()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.carelist.period_name}', style: TextCustom.bold_b20()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('จำนวนการให้น้ำวันนี้', style: TextCustom.normal_dg16()),
                Text('${widget.carelist.water_num}',
                    style: TextCustom.normal_dg16()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('จำนวนการให้ปุ๋ยวันนี้', style: TextCustom.normal_dg16()),
                Text('${widget.carelist.fert_num}',
                    style: TextCustom.normal_dg16()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('จำนวนโน้ตของทั้งรอบการปลูก',
                    style: TextCustom.normal_dg16()),
                Text('${widget.carelist.note_num}',
                    style: TextCustom.normal_dg16()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
