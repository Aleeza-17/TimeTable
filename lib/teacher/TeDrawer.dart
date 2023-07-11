import 'package:flutter/material.dart';
import 'package:flutter_application_1/teacher/Cancel_Class.dart';
import 'package:flutter_application_1/teacher/Course.dart';
import 'package:flutter_application_1/teacher/Reschedul%20class.dart';
import 'package:flutter_application_1/teacher/Reschedul.dart';
import 'package:flutter_application_1/teacher/TimeTable.dart';

import '../login.dart';

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
                    Text("Teacher", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.picture_as_pdf), title: Text("TimeTable"),
            //   onTap: () {

            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeTableView(myData:data)));
            //   },

            // ),

            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.white),
              title: Text("Time Table", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeTimeTableView(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.alarm_on, color: Colors.white),
              title: Text(" Class Cancelled",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cancel_Class(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_red_eye, color: Colors.white),
              title: Text("Rescheduled Class",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            reschedule_class_list(myData: data)));
              },
            ),
            ListTile(
              leading: Icon(Icons.send_time_extension, color: Colors.white),
              title:
                  Text("My Reschedule ", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reschedule(myData: data)));
              },
            ),

            ListTile(
              leading: Icon(Icons.bookmark_add_rounded, color: Colors.white),
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
