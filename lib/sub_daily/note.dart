import 'package:flutter/material.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);
  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  List<Notebook> notebook = [
    Notebook('ตัดดอก', '22/08/22', '7:30'),
    Notebook('ตรวจพบแมลง', '25/08/22', '8:24'),
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
                  Navigator.pushNamed(context, '/addnote');
                },
                icon: Icon(
                  Icons.add_circle,
                  color: ColorCustom.lightgreencolor(),
                )),
          ],
        ),
        ListView.builder(
          itemCount: notebook.length,
          itemBuilder: (context, index) {
            return NoteCard(
              notebook: notebook[index],
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class Notebook {
  final String topic;
  final String date;
  final String time;

  Notebook(this.topic, this.date, this.time);
}

class NoteCard extends StatefulWidget {
  Notebook notebook;
  NoteCard({Key? key, required this.notebook}) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.notebook.topic}',
                        style: TextCustom.normal_dg16()),
                    Text(
                        'แก้ไขล่าสุด เมื่อ ' +
                            '${widget.notebook.date}, ${widget.notebook.time}',
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
