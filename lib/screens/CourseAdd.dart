import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'dart:async';
import 'package:mysql1/mysql1.dart';

class CourseAdd extends StatefulWidget {
  CourseAdd({Key? key}) : super(key: key);

  @override
  State<CourseAdd> createState() => _CourseAddState();
}

class _CourseAddState extends State<CourseAdd> {
  final TextEditingController CourseController = TextEditingController();

  final TextEditingController CreditController = TextEditingController();
  final TextEditingController BatchController = TextEditingController();

  String FieldNull = "";
  String departmentna = "";
  String _selectedDept = ""; // Selected value from the dropdown
  String FacultyId = "";
  List<List<dynamic>> _data = [];
  List<List<dynamic>> _dept = [];
  List<List<dynamic>> _faculty = [];

  ///For Department list
  Future<void> departmentdata() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from department');

    List<List<dynamic>> deparmentlist = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      deparmentlist
          .add([row[0].toString(), row[1].toString(), row[2].toString()]);
    }

    setState(() {
      _dept = deparmentlist;
      _selectedDept = _dept.isNotEmpty
          ? _dept[0][1].toString()
          : ''; // Set the default selected value
    });

    await conn.close();
  }

  Future<void> Faculty() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from faculty');

    List<List<dynamic>> FacultyIdlist = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      FacultyIdlist.add(
          [row[0].toString(), row[1].toString(), row[2].toString()]);
    }

    setState(() {
      _faculty = FacultyIdlist;
      FacultyId = FacultyId.isNotEmpty
          ? FacultyId[0].toString()
          : ''; // Set the default selected value
    });

    await conn.close();
  }

  Future main() async {
    // Open a connection (testdb should already exist)
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));
    print("database");

    String Course = CourseController.text;
    String Credit = CreditController.text;
    String Batch = BatchController.text;

    print(_selectedDept);
    if (Batch.isNotEmpty &&
        _selectedDept.isNotEmpty &&
        Course.isNotEmpty &&
        Credit.isNotEmpty) {
      var stmt =
          "INSERT INTO course (Courseid  ,Course,creditHour,DepId,FacultyId,Department,Batch) VALUES (?, ?, ?, ?, ?, ?, ?);";

      // // Execute the prepared statement with values
      var result = await conn.query(stmt, [
        null,
        Course,
        Credit,
        _selectedDept,
        FacultyId,
        departmentna,
        Batch
      ]);

      CourseController.text = "";
      CreditController.text = "";
      BatchController.text = "";
    } else {
      setState(() {
        FieldNull = "Please fill the form";
      });
    }
  }

  void initState() {
    super.initState();
    departmentdata();
    Faculty();
    _selectedDept;
    FacultyId;
    departmentna;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Assign Course"),
      ),
      drawer: Drawermain(),
      body: Container(
        width: double.infinity, // Adjust the width as needed
        height: double.infinity, // Adjust the height as needed
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/WhatsApp Image 2023-06-24 at 6.07.56 AM.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller:
                        CourseController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Course",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller:
                        CreditController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Credit Hours",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller:
                        BatchController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Batch",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    departmentdata(); // Fetch data when button is pressed

                    if (_dept != null && _dept.isNotEmpty) {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(0, 0, 0, 0),
                        items: _dept.map((List<dynamic> item) {
                          return PopupMenuItem<String>(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedDept = item[0].toString();
                                  departmentna = item[1].toString();
                                  Navigator.pop(context);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(item[1].toString()),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      // Handle case when _data is null or empty
                      print('No data to display in the dropdown menu.');
                    }
                  },
                  child: Text('Select  Department'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set blue-gray background color
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Faculty(); // Fetch data when button is pressed

                    if (_faculty != null && _faculty.isNotEmpty) {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(0, 0, 0, 0),
                        items: _faculty.map((List<dynamic> item) {
                          return PopupMenuItem<String>(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  FacultyId = item[0].toString();
                                  Navigator.pop(context);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(item[1].toString()),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      // Handle case when _data is null or empty
                      print('No data to display in the dropdown menu.');
                    }
                  },
                  child: Text('Select Teacher'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set blue-gray background color
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: InkWell(
                    onTap: () => main(),
                    child: Container(
                        width: MediaQuery.of(context).size.width - 140,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(40),
                            left: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Assign Course",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
