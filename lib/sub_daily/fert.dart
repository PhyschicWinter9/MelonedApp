import 'package:flutter/material.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class Fert extends StatefulWidget {
  const Fert({Key? key}) : super(key: key);
  @override
  State<Fert> createState() => _FertState();
}

class _FertState extends State<Fert> {
  List<Ferting> ferting = [
    Ferting('อัลฟา',30,'กรัม','7:25'),
    Ferting('A B',50,'ซีซี','9:25'),
    Ferting('แคลเอ็ม',50,'ซีซี','10:25'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addfert');
                },
                icon: Icon(
                  Icons.add_circle,
                  color: ColorCustom.lightgreencolor(),
                )),
          ],
        ),
        ListView.builder(
          itemCount: ferting.length,
          itemBuilder: (context, index) {
            return FertCard(
              ferting: ferting[index],
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class Ferting {
  final String fertname;
  final int amount;
  final String unit;
  final String time;

  Ferting(this.fertname, this.amount, this.unit, this.time);
}

class FertCard extends StatefulWidget {
  Ferting ferting;
  FertCard({Key? key, required this.ferting}) : super(key: key);

  @override
  State<FertCard> createState() => _FertCardState();
}

class _FertCardState extends State<FertCard> {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.ferting.fertname} '+'(${widget.ferting.amount} ${widget.ferting.unit})',
                        style: TextCustom.normal_dg16()),
                    Text('${widget.ferting.time}',
                        style: TextCustom.normal_dg16()),
                  ],
                ),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/editfert');
                }, icon: Icon(Icons.settings,color: ColorCustom.orangecolor(),size: 30,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

