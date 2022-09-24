import 'package:flutter/material.dart';

class Hamburger extends StatelessWidget {
  

  Hamburger({
    Key? key,
  }) : super(key: key);

  final TextStyle sidemenu = TextStyle(
    fontFamily: 'Kanit',
    fontSize: 15,
    color: Color.fromRGBO(116, 116, 39, 1),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(159, 159, 54, 1),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Surat Lhaodee',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'หน้าหลัก',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/menu');
            },
          ),
          ListTile(
            title: Text(
              'รอบการปลูก',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/period');
            },
          ),
          ListTile(
            title: Text(
              'การดูแลประจำวัน',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/daily');
            },
          ),
          ListTile(
            title: Text(
              'วิเคราะห์คุณภาพ',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/analyze');
            },
          ),
          ListTile(
            title: Text(
              'สรุป',
              style: sidemenu,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/summary');
            },
          ),
        ],
      ),
    );
  }
}
