import 'package:flutter/material.dart';
import 'package:flutter_application_1/Monitor/MonitorDrawer.dart';

import 'dart:async';
import 'package:mysql1/mysql1.dart';

class MTimeTableView extends StatefulWidget {
  String myData = ""; // Declare a final variable to store the data

  MTimeTableView({required this.myData});
  @override
  State<MTimeTableView> createState() => _MTimeTableViewState(myData);
}

class _MTimeTableViewState extends State<MTimeTableView> {
  String mydata1 = "";
  _MTimeTableViewState(this.mydata1);
  List<List<dynamic>> _data = [];
  List<List<dynamic>> _cancel = []; // List to store fetched data
  String deletedata = "";

  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from TimeTable');
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
        row[6].toString(),
        row[7].toString()
      ]);
    }
    print(mydata1);
    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  Future<void> cancel_class() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from cancel_class');
    List<List<dynamic>> cancel = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      cancel.add([
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
        row[3].toString(),
        row[4].toString(),
        row[5].toString(),
        row[6].toString()
      ]);
      // print(cancel[3].toString());
    }

    setState(() {
      _cancel = cancel; // Update the state with fetched data
    });

    await conn.close();
  }

  @override
  void initState() {
    cancel_class();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'images/WhatsApp Image 2023-06-24 at 6.07.56 AM.jpeg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Time Table"),
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
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                    // Wrap the ListView with SingleChildScrollView
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
                              'Room',
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
                              'Day',
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
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 22),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 22),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 22),
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
                    ],
                    rows: _data.map((row) {
                      bool isCancelled =
                          _cancel.any((cancelRow) => row[0] == cancelRow[3]);
                      Color rowColor =
                          isCancelled ? Colors.red : Colors.transparent;

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
                            return rowColor;
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
                        ],
                      );
                    }).toList(),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
