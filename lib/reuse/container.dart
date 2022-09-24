import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BGContainer extends StatefulWidget {
  final Widget child;

  const BGContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<BGContainer> createState() => _BGContainerState();
}

class _BGContainerState extends State<BGContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(159, 159, 54, 1),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: widget.child,
          ),
        ),
    );
  }
}