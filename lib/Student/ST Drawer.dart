import 'package:flutter/material.dart';
import 'package:flutter_application_1/Student/Course.dart';
import 'package:flutter_application_1/Student/Reschedule.dart';

import '../login.dart';
import 'ST TimeTable.dart';

class DrawerCp extends StatelessWidget {
  final String data;

  DrawerCp({required this.data});

  // This widget is the root of your application.
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
                    Text("Student", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.white),
              title: Text("TimeTable", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimeTableView(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.alarm_on, color: Colors.white),
              title: Text("Reschedule", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reschedule(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white),
              title: Text("Course", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Coursest(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle, color: Colors.white),
              title: Text("LOGOUT", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
