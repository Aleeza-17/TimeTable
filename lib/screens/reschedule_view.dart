import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class reschedule_class_list extends StatefulWidget {
  reschedule_class_list({Key? key}) : super(key: key);

  @override
  State<reschedule_class_list> createState() => _reschedule_class_listState();
}

class _reschedule_class_listState extends State<reschedule_class_list> {
  List<List<dynamic>> _data = []; // List to store fetched data
  String _selectedDept = "";
  List<List<dynamic>> _dept = [];
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
      final results = await conn.query('select * from reschedule');

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
          row[8].toString()
        ]);
      }
    } else {
      final results = await conn.query(
          'SELECT RescheduleId,StartTime,EndTime,Subject,date,Teacher,DepId,Batch,RoomNo FROM reschedule WHERE DepId = $_selectedDept');

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
          row[8].toString()
        ]);
      }
    }

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  void initState() {
    super.initState();
    fetchData();
    departmentdata(); // Fetch data when the widget is inserted into the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("List Of Reschedule Classes"),
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
        child: Column(
          children: [
            SizedBox(
              height: 15,
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
                }
              },
              child: Text('Select Department'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey, // Set blue-gray background color
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: InkWell(
                onTap: () => fetchData(),
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
                        "Search Department",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
              ),
            ),
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
                            'RoomNo',
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
                            'Start_Time',
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
                            'End_Time',
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
                            'subject',
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
                            'Batch',
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
                            child: Text(row[8].toString()),
                          ),
                        ),
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
                            child: Text(row[7].toString()),
                          ),
                        ),
                      ].asMap().entries.map<DataCell>((entry) {
                        final index = entry.key;
                        final cell = entry.value;

                        return DataCell(
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: index != 6
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
          ],
        ),
      ),
    );
  }
}
