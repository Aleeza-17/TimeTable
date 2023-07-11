import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chairp/Attendence.dart';
import 'package:flutter_application_1/Chairp/StudentsList.dart';
import 'package:flutter_application_1/Chairp/teachersview.dart';
import 'package:mysql1/mysql1.dart';

import '../login.dart';
import 'Cancel class.dart';
import 'CancelClasses.dart';
import 'Course.dart';
import 'Reschedule.dart';
import 'Reschedule_dep_class.dart';
import 'TimeTableViewCp.dart';

class DrawerCp extends StatefulWidget {
  final String data;

  DrawerCp({required this.data});

  @override
  _DrawerCpState createState() => _DrawerCpState();
}

class _DrawerCpState extends State<DrawerCp> with WidgetsBindingObserver {
  bool newDataAvailable = false;
  List<List<dynamic>> _data = [];
  int _selectedDept = 0;
  List<List<dynamic>> _dept = [];
  Timer? _timer;

  Future<void> departmentdata() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query(
        'select DepId, Name, ChairId FROM department WHERE ChairId = ${widget.data}');

    List<List<dynamic>> departmentList = [];

    for (var row in results) {
      departmentList.add([
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
      ]);
    }

    if (mounted) {
      setState(() {
        _dept = departmentList;
        _selectedDept = int.parse(_dept[0][0]);
        print(_selectedDept);
      });
    }

    List<List<dynamic>> data = [];

    if (_selectedDept != 0) {
      print(_selectedDept);
      final results = await conn.query(
        'SELECT CancelId, RoomNo, date, TimeTableId, Time, Reason, DepId, subject FROM cancel_class WHERE DepId = $_selectedDept',
      );

      for (var row in results) {
        data.add([
          row[0].toString(),
          row[1].toString(),
          row[2].toString(),
          row[3].toString(),
          row[4].toString(),
          row[5].toString(),
          row[6].toString(),
          row[7].toString(),
        ]);
      }
    } else {
      // Handle the case when _selectedDept is 0
    }

    if (mounted) {
      setState(() {
        newDataAvailable = data.isNotEmpty && data.length > _data.length;
        _data = data;
      });
    }

    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      departmentdata();
    });
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      departmentdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueGrey, // Set blue-gray background color
        child: ListView(
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/Capture1.JPG'), // Replace 'path_to_background_image' with the actual path to your background image
                  fit: BoxFit.cover,
                ),
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors
                      .transparent, // Set the background color of the DrawerHeader to transparent
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50,
                      backgroundImage: AssetImage(
                          'images/BUITEMS_logo.png'), // Replace 'path_to_profile_image' with the actual path to your profile image
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Chair Person", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
              title: Text(
                "TimeTable",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CPTimeTableView1(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_2, color: Colors.white),
              title: Text("Students", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => listofstudents(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_3_rounded, color: Colors.white),
              title: Text("Faculty", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => listofTeachers(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: Colors.white),
              title: Text("List Of Cancelled Class",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cancelclassescp(myData: widget.data),
                  ),
                );
              },
              trailing: newDataAvailable
                  ? ClipOval(
                      child: Container(
                        color: Colors.red,
                        width: 15,
                        height: 15,
                        child: Center(),
                      ),
                    )
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.cancel_schedule_send, color: Colors.white),
              title: Text("Class Cancelled",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cancel_Class(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attachment, color: Colors.white),
              title: Text("My Rescheduled ",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reschedule(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_email, color: Colors.white),
              title: Text("List Of Reschedule Class",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        reschedule_class_list(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white),
              title: Text("Courses", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Coursecp(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_red_eye, color: Colors.white),
              title: Text("Attendance", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Attendcp(myData: widget.data),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle, color: Colors.white),
              title: Text("LOGOUT", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
