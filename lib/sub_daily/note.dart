import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../style/colortheme.dart';
import '../style/textstyle.dart';
import 'sub_note/editnote.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);
  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //Session
  dynamic period_ID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  getSession() async {
    dynamic id = await SessionManager().get("period_ID");
    // print(id.runtimeType);
    setState(() {
      period_ID = id.toString();
    });
  }

  //Array ของข้อมูล
  List<Notebook> notebook = [];

  Future detailNote(String period_ID) async {
    try {
      var url = "https://meloned.relaxlikes.com/api/dailycare/view_note.php";
      var response = await http.post(Uri.parse(url), body: {
        "period_ID": period_ID,
      });
      var data = json.decode(response.body);
      //  print(data);
      //  return data;
      for (var i = 0; i < data.length; i++) {
        Notebook notebook = Notebook(data[i]['note_ID'], data[i]['topic'],
            data[i]['detail'], data[i]['last_edit'], data[i]['period_ID']);
        this.notebook.add(notebook);
      }

      //ส่งข้อมูลกลับไปแสดงใน ListView
      return notebook;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refresh() async {
    final fetchnotebookdata = await detailNote(period_ID);
    setState(() {
      notebook.clear();
      notebook = fetchnotebookdata;
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
                    Navigator.pushNamed(context, '/addnote');
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: ColorCustom.lightgreencolor(),
                  )),
            ],
          ),
          FutureBuilder(
            future: detailNote(period_ID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.waveDots(
                        size: 50,
                        color: ColorCustom.orangecolor(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'กำลังโหลดข้อมูล...',
                          style: TextCustom.normal_mdg20(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Expanded(
                        child: notebook.isNotEmpty
                            ? RefreshIndicator(
                                key: _refreshIndicatorKey,
                                onRefresh: _refresh,
                                child: ListView.builder(
                                  itemCount: notebook.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return NoteCard(notebook: notebook[index]);
                                  },
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/animate/empty.json',
                                      width: 250,
                                      height: 250,
                                    ),
                                    Text(
                                      'ไม่มีข้อมูลการจดบันทึก',
                                      style: TextCustom.normal_mdg20(),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class Notebook {
  String noteid;
  String topic;
  String detail;
  String date;
  String period_ID;

  Notebook(this.noteid, this.topic, this.detail, this.date, this.period_ID);
}

class NoteCard extends StatefulWidget {
  Notebook notebook;
  NoteCard({Key? key, required this.notebook}) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  //create session noteid
  createSession() async {
    await SessionManager().set("note_ID", widget.notebook.noteid);
  }

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
              // Navigator.pushNamed(context, '/editnote');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNote(
                    note_ID: widget.notebook.noteid,
                    note_topic: widget.notebook.topic,
                    note_detail: widget.notebook.detail,
                    last_edit: widget.notebook.date,
                  ),
                ),
              );
              createSession();
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.notebook.topic}',
                        style: TextCustom.normal_dg16()),
                    Text('แก้ไขล่าสุด เมื่อ ' + '${widget.notebook.date}',
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
