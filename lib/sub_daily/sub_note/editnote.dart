import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/reuse/bottombar.dart';
import '/reuse/container.dart';
import '/reuse/hamburger.dart';
import '../../reuse/sizedbox.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';

class EditNote extends StatefulWidget {
  final String note_ID;
  final String note_topic;
  final String note_detail;
  final String last_edit;
  // final String period_ID;

  const EditNote(
      {Key? key,
      required this.note_ID,
      required this.note_topic,
      required this.note_detail,
      required this.last_edit})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  //Session
  dynamic note_ID;

  getSession() async {
    dynamic noteid = await SessionManager().get("note_ID");
    setState(() {
      note_ID = noteid.toString();
    });
  }

  final NotetopicController = TextEditingController();
  final NotedetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSession();
    //Get Value from API and set to controller
    NotetopicController.text = widget.note_topic;
    NotedetailController.text = widget.note_detail;
  }

  Future getNote() async {
    var url =
        Uri.parse('https://meloned.relaxlikes.com/api/dailycare/view_note.php');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // print(data);
    return data;
  }

  Future editNote(String Noteid, String Notetopic, String Notedetail) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/dailycare/edit_note.php";
      var response = await http.post(Uri.parse(url), body: {
        'note_ID': Noteid,
        'topic': Notetopic,
        'detail': Notedetail,
      });
      var data = json.decode(response.body);
      print(data);
      //Success show toast
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "แก้ไขบันทึกสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: "แก้ไขบันทึกไม่สำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  //Delete Note
  Future RemoveNote(String note_ID) async {
    try {
      var url = "https://meloned.relaxlikes.com/api/dailycare/delete_note.php";
      var response = await http.post(Uri.parse(url), body: {
        'note_ID': note_ID,
      });

      var jsonData = json.decode(response.body);

      if (jsonData == "Failed") {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "ลบข้อมูลสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('แก้ไขโน้ต'),
        actions: [
          IconButton(
            onPressed: () {
              RemoveNote(
                widget.note_ID,
              );
              Navigator.pop(context, true);
              setState(() {
                getNote();
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'หัวข้อ',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              FormList(
                controller: NotetopicController,
                hintText: 'หัวข้อ',
                hideText: false,
                maxLength: 30,
                keyboardType: TextInputType.text,
                minLines: 1,
              ),
              sizedBox.Boxh10(),
              Text(
                'รายละเอียด',
                style: TextCustom.textboxlabel(),
              ),
              sizedBox.Boxh5(),
              FormList(
                controller: NotedetailController,
                hintText: '',
                hideText: false,
                maxLength: 255,
                minLines: 10,
                keyboardType: TextInputType.multiline,
              ),
              sizedBox.Boxh5(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        editNote(note_ID, NotetopicController.text,
                            NotedetailController.text);
                      },
                      child: Text('บันทึก', style: TextCustom.buttontext()),
                      style: ElevatedButton.styleFrom(
                        primary: ColorCustom.mediumgreencolor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  sizedBox.Boxw10(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //back and refresh previous page
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        'ยกเลิก',
                        style: TextCustom.buttontext(),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class FormList extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hideText;
  final int maxLength;
  final TextInputType keyboardType;
  final int minLines;

  FormList({
    required this.controller,
    required this.hintText,
    required this.hideText,
    required this.maxLength,
    required this.keyboardType,
    required this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: hideText,
      cursorColor: ColorCustom.darkgreencolor(),
      maxLength: maxLength,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: null,
      style: TextCustom.normal_dg16(),
    );
  }
}
