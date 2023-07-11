import 'package:flutter/material.dart';
import 'package:flutter_application_1/Monitor/MonitorDrawer.dart';

import 'package:mysql1/mysql1.dart';

class Atten_View extends StatefulWidget {
  String myData = ""; // Declare a final variable to store the data

  Atten_View({required this.myData});

  @override
  State<Atten_View> createState() => _Atten_ViewState(myData);
}

class _Atten_ViewState extends State<Atten_View> {
  String mydata1 = "";
  _Atten_ViewState(this.mydata1);
  List<List<dynamic>> _data = []; // List to store fetched data
  String _selectedDept = "";

  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));
    List<List<dynamic>> data = [];

    if (_selectedDept.isEmpty) {
      final results = await conn.query('select * from attendance');

      for (var row in results) {
        // Convert each row to a List<dynamic> and convert int to String
        data.add([
          row[0].toString(),
          row[1].toString(),
          row[2].toString(),
          row[3].toString(),
          row[4].toString(),
          row[5].toString(),
          row[6].toString(),
          row[7].toString(),
          row[8].toString(),
          row[9].toString()
        ]);
      }
    } else {
      // final results = await conn.query('SELECT Courseid ,Course,creditHour,DepId,FacultyId,StuID FROM course WHERE DeptId = $_selectedDept');

      // for (var row in results) {
      //   // Convert each row to a List<dynamic> and convert int to String
      //   data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(), row[4].toString(), row[5].toString()]);
      // }
    }

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }
//  void diplace(){

//  for (var row in _dept) {
//     if (row[0] == _data[3]) {
//       setState(() {
//         _data[3] = row[1];
//       });
//       print(_data[3]);
//     }
//     print(row[0]);
//   }
//   print(_data);
//  }

  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Attendence"),
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
        child: Expanded(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                          color:
                              Colors.blueGrey, // Set light blue background color
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                            child: Text(
                              'RoomNO',
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
                          color:
                              Colors.blueGrey, // Set light blue background color
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                            child: Text(
                              'Date',
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
                          color:
                              Colors.blueGrey, // Set light blue background color
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 31),
                            child: Text(
                              'Time',
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
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                            child: Text(
                              'Semester',
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
                              .blueGrey, // Set background color of the header cell
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                            child: Text(
                              'Subject',
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
                              .blueGrey, // Set background color of the header cell
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                            child: Text(
                              'Teacher',
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
                              .blueGrey, // Set background color of the header cell
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 22),
                            child: Text(
                              'Status',
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
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[5].toString()),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[6].toString()),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(row[7].toString()),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
