import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'dart:io';

import 'package:mysql1/mysql1.dart';

class ExcelMenu extends StatefulWidget {
  const ExcelMenu({Key? key}) : super(key: key);

  @override
  _ExcelMenuState createState() => _ExcelMenuState();
}

class _ExcelMenuState extends State<ExcelMenu> {
  List<List<dynamic>> data = [];

  void _loadExcel() async {
    final filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (filePickerResult == null) return; // Check if no file was selected
    final fileBytes =
        await File(filePickerResult.files.first.path!).readAsBytes();
    final excel = Excel.decodeBytes(fileBytes);

    final table = excel.tables[
        'Sheet1']; // Replace 'Sheet1' with the name of the sheet you want to read
    if (table == null) {
      print("No table found in the Excel file");
      return;
    }

    final rows = table.rows
        .skip(1) // Skip the first row
        .map((row) => row.map((cell) => cell?.value?.toString() ?? '').toList())
        .toList();

    print(excel.tables);

    setState(() {
      data = rows;
    });

    // Call the function to insert data into MySQL database
    await insertDataToDatabase();
  }

  Future<void> insertDataToDatabase() async {
    // Open a connection to the MySQL database
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    print("Connected to database");

    // Loop through each row in the data List and insert into the database
    for (var row in data) {
      var stmt =
          "INSERT INTO TimeTable (Room,Day, Time, Semester, Subject, Teacher, Numid) VALUES (?, ?, ?, ?, ?, ?, ?);";
      var result = await conn.query(stmt, row);
      print("Inserted row with values $row");
    }

    // Close the database connection
    await conn.close();
    print("Database connection closed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Upload Excel File"),
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
        child: data.isEmpty
            ? Center(
                child: ElevatedButton(
                  onPressed: _loadExcel,
                  child: Text('Load Excel File'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: data[0]
                        .sublist(0, data[0].length - 1)
                        .map((item) => DataColumn(label: Text(item.toString())))
                        .toList(), // Exclude the last column
                    rows: List.generate(
                      data.length - 1,
                      (index) => DataRow(
                        cells: data[index + 1]
                            .sublist(0, data[0].length - 1)
                            .map((item) => DataCell(
                                  FittedBox(
                                    child: Text(
                                      item.toString(),
                                      style: TextStyle(
                                          fontSize:
                                              12), // set desired font size
                                    ),
                                  ),
                                ))
                            .toList(), // Exclude the last column
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
