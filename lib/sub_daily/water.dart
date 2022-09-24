import 'package:flutter/material.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class Water extends StatefulWidget {
  const Water({Key? key}) : super(key: key);
  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  List<Watering> watering = [
    Watering(1, '7:25'),
    Watering(2, '12:25'),
    Watering(3, '17:25')
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
          itemCount: watering.length,
          itemBuilder: (context, index) {
            return WaterCard(
              watering: watering[index],
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class Watering {
  final int count;
  final String time;

  Watering(this.count, this.time);
}

class WaterCard extends StatefulWidget {
  Watering watering;
  WaterCard({Key? key, required this.watering}) : super(key: key);

  @override
  State<WaterCard> createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterCard> {
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
                    Text('การให้น้ำ ' + '${widget.watering.count}',
                        style: TextCustom.normal_dg16()),
                    Text('${widget.watering.time}',
                        style: TextCustom.normal_dg16()),
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
