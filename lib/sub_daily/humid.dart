import 'package:flutter/material.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class Humid extends StatefulWidget {
  const Humid({Key? key}) : super(key: key);
  @override
  State<Humid> createState() => _HumidState();
}

class _HumidState extends State<Humid> {
  List<Humidity> humidity = [
    Humidity(80.99999, '7:25'),
    Humidity(60.25546336, '12:25'),
    Humidity(79.255858, '17:25')
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_circle,color: ColorCustom.lightgreencolor(),)),
          ],
        ),
        ListView.builder(
          itemCount: humidity.length,
          itemBuilder: (context, index) {
            return HumidCard(
              humidity: humidity[index],
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
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
            onPressed: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex : 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ความชื้น', style: TextCustom.normal_dg16()),
                          Text('${widget.humidity.humidvalue}',style: TextCustom.normal_mdg16()),
                          Text('%RH', style: TextCustom.normal_dg16()),
                        ],
                      ),
                    ),

                    Expanded(
                      flex : 1,
                      child: Text('${widget.humidity.time}',
                          style: TextCustom.normal_dg16()),
                    ),
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
