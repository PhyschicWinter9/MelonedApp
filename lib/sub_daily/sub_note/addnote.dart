import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newmelonedv2/reuse/bottombar.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import '../../reuse/sizedbox.dart';
import '../../style/colortheme.dart';
import '../../style/textstyle.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final NotetopicController = TextEditingController();
  final NotedetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
