import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reuse/container.dart';
import 'style/textstyle.dart';
import 'reuse/bottombar.dart';
import 'reuse/hamburger.dart';
import 'style/colortheme.dart';
import 'sub_period/detail_period.dart';
import 'package:http/http.dart' as http;
import 'sub_period/historyperiod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Period extends StatefulWidget {
  const Period({Key? key}) : super(key: key);

  @override
  State<Period> createState() => _PeriodState();
}

class _PeriodState extends State<Period> {
  @override
  void initState() {
    super.initState();
    getPeriod();
    refresh();
  }

  Future detailpreiod(String period_ID, String create_date, String harvest_date,
      String greenhouse_ID) async {
    try {
      String url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
      var response = await http.post(Uri.parse(url), body: {
        'period_ID': period_ID,
        'create_date': create_date,
        'harvest_date': harvest_date,
        'greenhouse_ID': greenhouse_ID,
      });
      var data = json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future getPeriod() async {
    var url = "https://meloned.relaxlikes.com/api/period/viewperiod.php";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body);
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getPeriod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รอบการปลูก'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/newperiod');
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      drawer: Hamburger(),
      body: BGContainer(
        child: Column(
          children: [
            //period lists
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HistoryButton(),
              ],
            ),
            Container(
              child: FutureBuilder(
                  future: getPeriod(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.waveDots(
                              color: ColorCustom.orangecolor(),
                              size: 50,
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
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: refresh,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              List list = snapshot.data;
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                snapshot.data[index]
                                                    ['greenhouse_name'],
                                                style: TextCustom.bold_b16(),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'วันที่ปลูก  ' +
                                                        snapshot.data[index]
                                                            ['create_date'],
                                                    style: TextCustom
                                                        .normal_dg14(),
                                                  ),
                                                  Text(
                                                    'วันที่คาดว่าจะเก็บเกี่ยว ' +
                                                        snapshot.data[index]
                                                            ['harvest_date'],
                                                    style: TextCustom
                                                        .normal_dg14(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.settings,
                                            size: 30,
                                            color: ColorCustom.orangecolor(),
                                          ),
                                          onPressed: () {
                                            detailpreiod(
                                              snapshot.data[index]['period_ID'],
                                              snapshot.data[index]
                                                  ['create_date'],
                                              snapshot.data[index]
                                                  ['harvest_date'],
                                              snapshot.data[index]
                                                  ['greenhouse_ID'],
                                            );
                                
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPeriod(
                                                        list: list,
                                                        index: index,
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorCustom.lightyellowcolor(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class HistoryButton extends StatelessWidget {
  const HistoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/historyperiod');
        },
        child: SizedBox(
          height: 20,
          child: Row(
            children: [
              Text(
                'View History',
                style: GoogleFonts.kanit(color: ColorCustom.orangecolor()),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.history,
                color: ColorCustom.orangecolor(),
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          //backgroundColor: Color.fromRGBO(251, 249, 218, 1),
          primary: ColorCustom.lightyellowcolor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        
        );
  }
}
