import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '/reuse/bottombar.dart';
import '/reuse/container.dart';
import '/reuse/hamburger.dart';
import '../../reuse/sizedbox.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //Session
  dynamic period_ID;

  @override
  void initState() {
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

  final NotetopicController = TextEditingController();
  final NotedetailController = TextEditingController();

  Future addNote() async {
    try {
      var url = Uri.parse(
          'https://meloned.relaxlikes.com/api/dailycare/insert_note.php');
      var response = await http.post(url, body: {
        "period_ID": period_ID,
        'topic': NotetopicController.text,
        'detail': NotedetailController.text,
      });
      var data = jsonDecode(response.body);
      // print(data);
      //Success show toast
      if (data == 'Success') {
        Fluttertoast.showToast(
            msg: "สร้างโน้ตสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pop(context);
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: "สร้างโน้ตไม่สำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }

      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('โน้ตใหม่'),
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
                minLines: 12,
                keyboardType: TextInputType.multiline,
              ),
              sizedBox.Boxh10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addNote();
                      },
                      child: Text('ยืนยัน', style: TextCustom.buttontext()),
                      style: ElevatedButton.styleFrom(
                        primary: ColorCustom.mediumgreencolor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  sizedBox.Boxw5(),
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
    );
  }
}
