import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chairp/CpDrawer.dart';

import 'package:mysql1/mysql1.dart';

class listofTeachers extends StatefulWidget {
  String myData = ""; // Declare a final variable to store the data

  listofTeachers({required this.myData});
  @override
  State<listofTeachers> createState() => _listofTeachersState(myData);
}

class _listofTeachersState extends State<listofTeachers> {
  String mydata1 = "";
  _listofTeachersState(this.mydata1);
  List<List<dynamic>> _data = []; // List to store fetched data
  int _selectedDept = 0;
  List<List<dynamic>> _dept = [];
  Future<void> departmentdata() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query(
        'select DepId ,Name,ChairId FROM  department  WHERE ChairId = $mydata1');

    List<List<dynamic>> deparmentlist = [];

    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      deparmentlist
          .add([row[0].toString(), row[1].toString(), row[2].toString()]);
    }

    setState(() {
      _dept = deparmentlist;

      // _selectedDept = _dept.isNotEmpty ? _dept[0][0].toString() : ''; // Set the default selected value
      _selectedDept = int.parse(_dept[0][0]);

      print(_selectedDept);
    });
    List<List<dynamic>> data = [];

    if (_selectedDept != 0) {
      print(_selectedDept);
      final results = await conn.query(
          'SELECT FacultyId,FirstName,LastName,Email,Phone,UserId,	DeptId FROM faculty WHERE DeptId = $_selectedDept');

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
    } else {}

    setState(() {
      _data = data; // Update the state with fetched data
    });
    await conn.close();
  }
  // Open a connection (testdb should already exist)

  void initState() {
    super.initState();
    departmentdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("List of Teachers"),
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
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: DataTable(
                    horizontalMargin: 16,
                    columnSpacing: 16,
                    headingRowHeight: 32,
                    dataRowHeight: 48,
                    headingTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue, // Set light blue color
                    ),
                    dataTextStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    columns: [
                      DataColumn(
                        label: Material(
                          color: Colors
                              .blueGrey, // Set light blue background color
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 15),
                            child: Text(
                              'FirstName',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white, // Set white font color
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Material(
                          color: Colors
                              .blueGrey, // Set light blue background color
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 14),
                            child: Text(
                              'LastName',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white, // Set white font color
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Material(
                          color: Colors
                              .blueGrey, // Set light blue background color
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 31),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Set white font color
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Material(
                          color: Colors
                              .blueGrey, // Set background color of the header cell
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 22),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white, // Set white font color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: _data.map((row) {
                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            // Set the white border color at the bottom of each row
                            if (states.contains(MaterialState.selected)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2);
                            }
                            return null;
                          },
                        ),
                        cells: [
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[1].toString()),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[2].toString()),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[3].toString()),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[4].toString()),
                            ),
                          ),
                        ].asMap().entries.map<DataCell>((entry) {
                          final index = entry.key;
                          final cell = entry.value;

                          return DataCell(
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: index != 3
                                      ? BorderSide(
                                          color: Colors
                                              .white, // Set white border color
                                          width: 1.0, // Set border width
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                              child: cell.child,
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
