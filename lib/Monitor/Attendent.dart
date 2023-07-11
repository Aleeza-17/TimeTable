import 'package:flutter/material.dart';
import 'package:flutter_application_1/Monitor/MonitorDrawer.dart';

import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Attendence extends StatefulWidget {
  String myData = ""; // Declare a final variable to store the data

  Attendence({required this.myData});
  @override
  State<Attendence> createState() => _AttendenceState(myData);
}

class _AttendenceState extends State<Attendence> {
  final TextEditingController status = TextEditingController();
  String mydata1 = "";
  _AttendenceState(this.mydata1);
  String _selectedDept = "";
  String class_name = "";
  String time = "";

  String subject = "";
  String Semester = "";
  String teacher = "";

  String tabid = "";
  String? selectedValue;
  List<String?> dropdownItems = [
    null, // null value for "Select option"
    ' present',
    'Absent',
    'Leave',
  ];

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

    print(class_name);
    print(time);

    String status1 = selectedValue!;

    if (class_name.isNotEmpty && time.isNotEmpty) {
      var stmt =
          "INSERT INTO attendance (AttId,Room,Date,Time,Semester,Subject,Teacher,Status,TtbId,DepId) VALUES (?,?,?, ?, ?, ?, ?,?,?,?);";

      // // Execute the prepared statement with values
      var result = await conn.query(stmt, [
        null,
        class_name,
        DateTime.now().toUtc(),
        time,
        Semester,
        subject,
        teacher,
        status1,
        tabid,
        _selectedDept
      ]);

      setState(() {
        dropdownItems; // Reset the selected value to null
      });
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
    time;
    teacher;
    status;
    tabid;
    Semester;

    // Fetch data when the widget is inserted into the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Mark Status"),
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
                  height: 30,
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IntrinsicWidth(
                    child: Center(
                      child: DropdownButton<String?>(
                        value: selectedValue,
                        hint: Text(
                          'Select option',
                          style: TextStyle(fontSize: 10),
                        ),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        elevation: 12,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        items: dropdownItems
                            .map<DropdownMenuItem<String?>>((String? value) {
                          return DropdownMenuItem<String?>(
                            value: value,
                            child: value == null
                                ? Text('Select option')
                                : Text(value),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                        selectedItemBuilder: (BuildContext context) {
                          return dropdownItems.map<Widget>((String? item) {
                            return Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 20,
                              color: Colors.blueGrey,
                              child: Text(
                                item ?? 'Select option',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
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
                                  tabid = item[0].toString();
                                  class_name = item[1].toString();
                                  time = item[3].toString();
                                  Semester = item[4].toString();
                                  subject = item[5].toString();
                                  teacher = item[6].toString();
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
                                      child: Text(item[4].toString()),
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
                  child: Text('Select class'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set blue-gray background color
                  ),
                ),
                SizedBox(
                  height: 30,
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
                  child: Text('Select Department'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set blue-gray background color
                  ),
                ),
                SizedBox(
                  height: 30,
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
                            "Submit  ",
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
