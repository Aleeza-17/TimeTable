import 'package:flutter/material.dart';
import 'package:flutter_application_1/mysql.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'package:mysql1/mysql1.dart';

class ListofUser extends StatefulWidget {
  ListofUser({Key? key}) : super(key: key);

  @override
  State<ListofUser> createState() => _ListofUserState();
}

class _ListofUserState extends State<ListofUser> {
  List<List<dynamic>> _data = []; // List to store fetched data
var db=new Mysql();
  // Open a connection (testdb should already exist)
  Future<void> fetchData() async {
   
db.getconnection().then((conn) {
  String sql='select * from userregistry';
  conn.query(sql).then((results){
 List<List<dynamic>> data = [];
    for (var row in results) {
      // Convert each row to a List<dynamic> and convert int to String
      data.add([
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
        row[3].toString()
        
        
      ]);
       setState(() {
      _data = data; // Update the state with fetched data
    });
    }
  });});
    
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
        title: Text("List Of Users"),
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
                        color:
                            Colors.blueGrey, // Set light blue background color
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          child: Text(
                            'Email',
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
                            'Password',
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
                            'Status',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
                      ],
                    );
                  }).toList(),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
