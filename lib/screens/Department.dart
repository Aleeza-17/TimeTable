import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'mainscreen.dart';

class Departmentcreate extends StatefulWidget {
  Departmentcreate({Key? key}) : super(key: key);

  @override
  State<Departmentcreate> createState() => _DepartmentcreateState();
}

class _DepartmentcreateState extends State<Departmentcreate> {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController ChairIDController = TextEditingController();

  String FieldNull = "";
  String _selectedName = ""; // Selected value from the dropdown

  List<List<dynamic>> _data = [];

  Future<void> fetchData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));

    final results = await conn.query('select * from userregistry');
    List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
        row[3].toString()
      ]);
    }

    setState(() {
      _data = data;
      // Update the state with fetched data
      _selectedName = _data.isNotEmpty
          ? _data[0][1].toString()
          : ''; // Set the default selected value
    });
    print(_selectedName);
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
    String Name = NameController.text;

    String ChairID = ChairIDController.text;

    print(_selectedName);

    if (_selectedName.isNotEmpty && NameController.text.isNotEmpty) {
      var stmt =
          "INSERT INTO department (DepId,Name,ChairId) VALUES (?, ?, ?);";

      // Execute the prepared statement with values
      var result = await conn.query(stmt, [null, Name, _selectedName]);
      NameController.text = "";
      ChairIDController.text = "";
    } else {
      setState(() {
        FieldNull = "Please fill the form";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Registration Of Departments"),
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
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 20),
                  child: Image.asset(
                    "images/BUITEMS_logo.png",
                    width: 130,
                    height: 70,
                  ),
                ),
                SizedBox(
                  height: 139,
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    "User Departments",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                        NameController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Department",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
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
                  child: Text('Select Chair Person'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set blue grey background color
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () => main(),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Colors.blueGrey, // Set blue grey background color
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(40),
                          left: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Registration",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Center(child: Text(FieldNull)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
