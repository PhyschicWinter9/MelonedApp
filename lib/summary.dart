// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newmelonedv2/reuse/container.dart';
import 'package:newmelonedv2/reuse/hamburger.dart';
import 'menu.dart';
import 'period.dart';
import 'daily.dart';
import 'analyze.dart';
import 'reuse/bottombar.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*______Top Bar________*/
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(159, 159, 54, 1),
        elevation: 0,
        title: const Text(
          'Summary',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Hamburger(),

      body: BGContainer(
        child: Column(

        )
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
