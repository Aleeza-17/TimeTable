import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/screens/AddFaculty.dart';
import 'package:flutter_application_1/screens/AddStudent.dart';
import 'package:flutter_application_1/screens/Cancel_class.dart';
import 'package:flutter_application_1/screens/CourseAdd.dart';
import 'package:flutter_application_1/screens/Course_view.dart';
import 'package:flutter_application_1/screens/Deparmentlist.dart';
import 'package:flutter_application_1/screens/Department.dart';
import 'package:flutter_application_1/screens/Facultyview.dart';
import 'package:flutter_application_1/screens/Listofusers.dart';
import 'package:flutter_application_1/screens/StudentsView.dart';
import 'package:flutter_application_1/screens/TimeTableView.dart';
import 'package:flutter_application_1/screens/cancel_class_list.dart';
import 'package:flutter_application_1/screens/mainscreen.dart';
import 'package:flutter_application_1/screens/reschedule.dart';
import 'package:flutter_application_1/screens/reschedule_view.dart';
import 'package:flutter_application_1/screens/signupscreen.dart';

class Drawermain extends StatelessWidget {
  const Drawermain({super.key});

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
                        Text("Admin", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.upload_file, color: Colors.white),
                  title: Text(
                    "Upload file",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ExcelMenu()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.picture_as_pdf, color: Colors.white),
                  title:
                      Text("TimeTable", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimeTableView()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined, color: Colors.white),
                  title: Text("Users", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListofUser()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title:
                      Text("Add User", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.house_outlined, color: Colors.white),
                  title: Text("Add Department",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Departmentcreate()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.house_sharp, color: Colors.white),
                  title: Text("Department List",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LisofDepatment()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_2_outlined, color: Colors.white),
                  title: Text("Faculty List",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListofFaculty()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text("Add Faculty",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddFaculty()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.school_sharp, color: Colors.white),
                  title: Text("Students List",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Listofstudents()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.school_outlined, color: Colors.white),
                  title: Text("Add Student",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddStudent()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove_red_eye, color: Colors.white),
                  title: Text("Cancelled Class List",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cancel_class_list()));
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.cancel_schedule_send, color: Colors.white),
                  title: Text("Cancelled Class",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cancel_Class()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mail_lock_sharp, color: Colors.white),
                  title: Text("Rescheduled List",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reschedule_class_list()));
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.mail_outline_outlined, color: Colors.white),
                  title: Text("My Rescheduled",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Reschedule()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book_online_sharp, color: Colors.white),
                  title:
                      Text("Add Course", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CourseAdd()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove_red_eye, color: Colors.white),
                  title: Text("Course", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Course_View()));
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.supervised_user_circle, color: Colors.white),
                  title: Text("LOGOUT", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            )));
  }
}
