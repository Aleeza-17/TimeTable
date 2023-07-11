import 'package:flutter/material.dart';

import 'dart:async';
import 'package:mysql1/mysql1.dart';

import '../screens/TimeTableView.dart';
import 'CpDrawer.dart';

class cancel_Class extends StatefulWidget {
  String myData = ""; // Declare a final variable to store the data

  cancel_Class({required this.myData});
  @override
  State<cancel_Class> createState() => _cancel_ClassState(myData);
}

class _cancel_ClassState extends State<cancel_Class> {
  String mydata1 = "";
  _cancel_ClassState(this.mydata1);
  String _selectedDept = "";
  String class_name = "";
  String time = "";
  String subject = "";
  final TextEditingController reasonController = TextEditingController();

  String FieldNull = "";
  String _selectedName = "";

  List<List<dynamic>> _data = [];
  List<List<dynamic>> _dept = [];

  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from timetable');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
        row[3].toString(),
        row[4].toString(),
        row[5].toString(),
        row[6].toString()
      ]);
    }

    setState(() {
      _data = data;
      // Update the state with fetched data
      _selectedName = _data.isNotEmpty
          ? _data[0][1].toString()
          : ''; // Set the default selected value
    });

    await conn.close();
  }

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

    String Reason = reasonController.text;

    print(class_name);
    print(time);
    print(Reason);

    if (class_name.isNotEmpty && time.isNotEmpty && Reason.isNotEmpty) {
      var stmt =
          "INSERT INTO cancel_class (CancelId,RoomNo,date,TimeTableId,Time,Reason,DepId,subject) VALUES (?,?,?, ?, ?, ?, ?,?);";

      // // Execute the prepared statement with values
      var result = await conn.query(stmt, [
        null,
        class_name,
        DateTime.now().toUtc(),
        _selectedName,
        time,
        Reason,
        _selectedDept,
        subject
      ]);

      reasonController.text = "";
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
    fetchData();
    _selectedName;
    class_name;
    subject;
    time; // Fetch data when the widget is inserted into the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Class Cancelling"),
      ),
      drawer: DrawerCp(data: mydata1),
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
                        reasonController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Reason",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchData(); // Fetch data when button is pressed

                    if (_data != null && _data.isNotEmpty) {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(0, 0, 0, 0),
                        items: _data.map((List<dynamic> item) {
                          return PopupMenuItem<String>(
                            value: item[1].toString(),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedName = item[0].toString();
                                  class_name = item[1].toString();
                                  time = item[3].toString();
                                  subject = item[5].toString();
                                  Navigator.pop(context);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(item[1].toString()),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      flex: 1,
                                      child: Text(item[3].toString()),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      flex: 1,
                                      child: Text(item[5].toString()),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      flex: 1,
                                      child: Text(item[6].toString()),
                                    ),
                                  ],
                                ),
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
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  child: Text('Select class'),
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
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  child: Text('Select Department'),
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
                        color: Colors.blueGrey, // Set blueGrey color
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(40),
                          left: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
