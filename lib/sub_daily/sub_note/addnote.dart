// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:newmelonedv2/reuse/bottombar.dart';
// import 'package:newmelonedv2/reuse/container.dart';
// import 'package:newmelonedv2/reuse/hamburger.dart';
// import '../../reuse/sizedbox.dart';
// import '../../style/colortheme.dart';
// import '../../style/textstyle.dart';

// class AddNote extends StatefulWidget {
//   const AddNote({Key? key}) : super(key: key);

//   @override
//   State<AddNote> createState() => _AddNoteState();
// }

// class _AddNoteState extends State<AddNote> {
//   final NotetopicController = TextEditingController();
//   final NotedetailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('เพิ่มการให้ปุ๋ย'),
//       ),
//       drawer: Hamburger(),
//       body: BGContainer(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'หัวข้อ',
//                 style: TextCustom.textboxlabel(),
//               ),
//               sizedBox.Boxh5(),
//               FormList(
//                 controller: NotetopicController,
//                 hintText: 'หัวข้อ',
//                 hideText: false,
//                 maxLength: 30,
//               ),
//               sizedBox.Boxh10(),
//               Text(
//                 'รายละเอียด',
//                 style: TextCustom.textboxlabel(),
//               ),
//               sizedBox.Boxh5(),
//               FormList(
//                 controller: NotedetailController,
//                 hintText: '',
//                 hideText: false,
//                 maxLength: 255,
                
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomBar(),
//     );
//   }
// }

// class FormList extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool hideText;
//   final int maxLength;

//   FormList({
//     required this.controller,
//     required this.hintText,
//     required this.hideText,
//     required this.maxLength,
//     required this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//       ),
//       obscureText: hideText,
//       cursorColor: ColorCustom.darkgreencolor(),
//       maxLength: maxLength,
//       keyboardType: KeyboardType,
//     );
//   }
// }
