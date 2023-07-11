
import 'package:flutter/material.dart';
import 'package:flutter_application_1/mysql.dart';




import 'ST Drawer.dart';

class Coursest extends StatefulWidget {
  

   String myData=""; // Declare a final variable to store the data

  Coursest({required this.myData});
  @override
  State<Coursest> createState() => _CoursestState(myData);
}

class _CoursestState extends State<Coursest> {
 String mydata1="";
   _CoursestState(this.mydata1);
  List<List<dynamic>> _data = []; // List to store fetched data
  int _selectedDept=0;
  String batch="";
  var db= new Mysql();
  List<List<dynamic>> _dept = [];
Future<void> departmentdata() async {
 db.getconnection().then((conn) {
  String sql='select DepId,Batch FROM  students  WHERE UserId  = $mydata1';
  conn.query(sql).then((results){
List<List<dynamic>> deparmentlist= [];

  for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
   deparmentlist.add([row[0].toString(), row[1].toString()]);

   setState(() {
    _dept = deparmentlist; 
    
   
    // _selectedDept = _dept.isNotEmpty ? _dept[0][0].toString() : ''; // Set the default selected value
   _selectedDept=int.parse(_dept[0][0]);
   batch=_dept[0][1];
   print("this is:$_selectedDept");
   print("this is $batch");


  });
  }
  List<List<dynamic>> data = [];
  if(_selectedDept !=0)
{
  String sql='SELECT Courseid ,Course,creditHour,DepId,FacultyId,Batch FROM course  WHERE DepId = $_selectedDept && Batch= $batch' ;
   conn.query(sql).then((results){
    for (var row in results) {
    // Convert each row to a List<dynamic> and convert int to String
    data.add([row[0].toString(), row[1].toString(), row[2].toString(), row[3].toString(), row[4].toString(), row[5].toString() ]);
  
   setState(() {
      _data = data;
      print(data); // Update the state with fetched data
    });
  }});
  } });
 });

}
 
  

  



 
  // Open a connection (testdb should already exist)
  
void initState() {
    super.initState();
    departmentdata(); 
    print(_data);
   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Courses hhh"),
      ),

      drawer: DrawerCp(data: mydata1),
      body: Container(
           width: double.infinity, // Adjust the width as needed
  height: double.infinity, // Adjust the height as needed
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/WhatsApp Image 2023-06-24 at 6.07.56 AM.jpeg'),
      fit: BoxFit.cover,
    ),
  ),
        child: Column(
          children: [
             SizedBox(height: 15,),
          
        SizedBox(height: 15,),
                
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
          color: Colors.blueGrey, // Set light blue background color
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            child: Text(
              'Course',
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
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            child: Text(
              'credit Hour',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white, // Set white font color
              ),
            ),
          ),
        ),
          ),
          // DataColumn(
          //   label: Material(
          //     color: Colors.lightBlue, // Set light blue background color
          //     child: Container(
          //       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 31),
          //       child: Text(
          //         'Department',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white, // Set white font color
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // DataColumn(
          //   label: Material(
          //     color: Colors.lightBlue, // Set background color of the header cell
          //     child: Container(
          //       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 22),
          //       child: Text(
          //         'Teacher',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 16,
          //           color: Colors.white, // Set white font color
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          DataColumn(
        label: Material(
          color: Colors.blueGrey, // Set background color of the header cell
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 22),
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
              return Theme.of(context).colorScheme.primary.withOpacity(0.2);
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
          // DataCell(
          //   Container(
          //     width: 100,
          //     alignment: Alignment.center,
          //     child: Text(row[3].toString()),
          //   ),
          // ),
          // DataCell(
          //   Container(
          //     width: 100,
          //     alignment: Alignment.center,
          //     child: Text(row[4].toString()),
          //   ),
          // ),
          DataCell(
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Text(row[5].toString()),
            ),
          ),
        ],
          );
        }).toList(),
      )
      
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}