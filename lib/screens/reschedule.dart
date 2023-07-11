import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Reschedule extends StatefulWidget {
  Reschedule({Key? key}) : super(key: key);

  @override
  State<Reschedule> createState() => _RescheduleState();
}

class _RescheduleState extends State<Reschedule> {
  final TextEditingController StarttimeController = TextEditingController();
  final TextEditingController EndtimeController = TextEditingController();
  final TextEditingController SubjectController = TextEditingController();
  final TextEditingController TeacherController = TextEditingController();
  final TextEditingController BatchController = TextEditingController();
  final TextEditingController RoomNoController = TextEditingController();
  String FieldNull = "";

  String _selectedDept = ""; // Selected value from the dropdown

  List<List<dynamic>> _data = [];
  List<List<dynamic>> _dept = [];

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

  Future main() async {
    // Open a connection (testdb should already exist)
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));
    print("database");

    String Starttime = StarttimeController.text;
    String Endtime = EndtimeController.text;
    String suject = SubjectController.text;
    String Teacher = TeacherController.text;
    String _Batch = BatchController.text;
    String _RoomNo = RoomNoController.text;
    print(Starttime);
    print(Endtime);

    print(_Batch);
    print(_selectedDept);
    if (_Batch.isNotEmpty &&
        _selectedDept.isNotEmpty &&
        Starttime.isNotEmpty &&
        Endtime.isNotEmpty) {
      var stmt =
          "INSERT INTO reschedule (RescheduledId ,StartTime,EndTime,Subject,date,Teacher,DepId,	Batch,RoomNo) VALUES (?,?,?,?,?, ?, ?, ?, ?);";

      // // Execute the prepared statement with values
      var result = await conn.query(stmt, [
        null,
        Starttime,
        Endtime,
        suject,
        DateTime.now().toUtc(),
        Teacher,
        _selectedDept,
        _Batch,
        _RoomNo
      ]);

      RoomNoController.text = "";
      StarttimeController.text = "";
      EndtimeController.text = "";
      SubjectController.text = "";
      TeacherController.text = "";
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
    _selectedDept;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Reschedule Class"),
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
                        RoomNoController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Room",
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
                        StarttimeController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Start_Time",
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
                        EndtimeController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "End_Time",
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
                        SubjectController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Subject",
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
                        TeacherController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Teacher",
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
                  child: Text('Add User Department'),
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
                            "Reschedule",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
