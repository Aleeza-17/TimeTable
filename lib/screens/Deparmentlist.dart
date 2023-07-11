import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class LisofDepatment extends StatefulWidget {
  LisofDepatment({Key? key}) : super(key: key);

  @override
  State<LisofDepatment> createState() => _LisofDepatmentState();
}

class _LisofDepatmentState extends State<LisofDepatment> {
  List<List<dynamic>> _data = []; // List to store fetched data

  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from department');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([row[0].toString(), row[1].toString(), row[2].toString()]);
    }

    setState(() {
      _data = data; // Update the state with fetched data
    });

    await conn.close();
  }

  initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("List of Departments"),
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
              height: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                  // Wrap the ListView with SingleChildScrollView
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
                      color: Colors.blueGrey, // Set light blue background color
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        child: Text(
                          'Department',
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
                      color: Colors.blueGrey, // Set light blue background color
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        child: Text(
                          'ChairPerson Id',
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
                  return DataRow(cells: [
                    DataCell(
                      Container(
                        width: 150.0,
                        alignment: Alignment.center,
                        child: Text(
                          row[1].toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 150.0,
                        alignment: Alignment.center,
                        child: Text(
                          row[2].toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
