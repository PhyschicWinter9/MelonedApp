import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  
  const EditNote({Key? key,required this.note_ID,required this.note_topic,required this.note_detail,required this.last_edit}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool editMode = false;

  final NotetopicController = TextEditingController();
  final NotedetailController = TextEditingController();

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   NotetopicController.dispose();
  //   NotedetailController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Get Value from API and set to controller
    NotetopicController.text = widget.note_topic;
    NotedetailController.text = widget.note_detail;
  }

  Future getNote () async {
    var url = Uri.parse('https://meloned.relaxlikes.com/api/dailycare/view_note.php');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data);
  }


  Future editNote (String Noteid,String Notetopic, String Notedetail) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/dailycare/edit_note.php";
      var response = await http.post(Uri.parse(url), body: {
        'note_ID': Noteid,
        'Notetopic': Notetopic,
        'Notedetail': Notedetail,
      });
      var data = json.decode(response.body);
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
            onPressed: () {},
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
                minLines: 15,
                keyboardType: TextInputType.multiline,
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
