import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:newmelonedv2/sub_daily/sub_humid/addhumid.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';
import 'sub_humid/edithumid.dart';

class Humid extends StatefulWidget {
  const Humid({Key? key}) : super(key: key);
  @override
  State<Humid> createState() => _HumidState();
}

class _HumidState extends State<Humid> {
  //List
  List<Humidity> humidity = [
    Humidity(80.99, '7:25'),
    Humidity(60.25, '12:25'),
    Humidity(79.25, '17:25'),
    Humidity(80.25, '22:25'),
  ];

  //Session Manager
  dynamic period_ID;

  @override
  void initState() {
    super.initState();
    getSession();
    setState(() {});
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    // print(id.runtimeType);
    setState(() {
      period_ID = id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddHumid(periodID: period_ID)));
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: ColorCustom.lightgreencolor(),
                  )),
            ],
          ),
          Column(
            children: [
              ListView.builder(
                itemCount: humidity.length,
                itemBuilder: (context, index) {
                  return HumidCard(
                    humidity: humidity[index],
                    //  return Text(humidity[index].toString()
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Humidity {
  final double humidvalue;
  final String time;

  Humidity(this.humidvalue, this.time);
}

class HumidCard extends StatefulWidget {
  Humidity humidity;
  HumidCard({Key? key, required this.humidity}) : super(key: key);

  @override
  State<HumidCard> createState() => _HumidCardState();
}

class _HumidCardState extends State<HumidCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
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
                      builder: (context) => EditHumid(
                            humidID: '1',
                            humidamount: widget.humidity.humidvalue.toString(),
                          )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ความชื้น', style: TextCustom.normal_dg16()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.humidity.humidvalue}',
                                      style: TextCustom.normal_mdg16()),
                                  SizedBox(width: 5),
                                  Text('%RH', style: TextCustom.normal_dg16()),
                                ],
                              ),
                              Text('${widget.humidity.time}',
                                  style: TextCustom.normal_dg16()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Text('${widget.humidity.time}',
                    //       style: TextCustom.normal_dg16()),
                    // ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: ColorCustom.lightgreencolor(),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
