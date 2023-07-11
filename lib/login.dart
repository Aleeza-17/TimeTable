import 'dart:async';

import 'package:flutter_application_1/mysql.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'Chairp/StudentsList.dart';

import 'Chairp/TimeTableViewCp.dart';
import 'Monitor/MTimeTable.dart';
import 'Student/ST TimeTable.dart';
import 'screens/mainscreen.dart';
import 'teacher/TimeTable.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
var db=new Mysql()
;  MaterialColor myColor = Colors.blue;
  String Invslid = "";
  bool _obscurePassword = true;
  //Open a connection (testdb should already exist)
  Future<void> fetchData() async {
    db.getconnection().then((conn) {
  String sql='select * from userregistry';
  conn.query(sql).then((results){
if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      for (var row in results) {
//print(row[1]);
//print(row[2]);
//print(row[3]);
        if (row[1] == emailController.text &&
            row[2] == passwordController.text &&
            row[3] == "admin") {
          print('admin');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ExcelMenu()));
        } else if (row[1] == emailController.text &&
            row[2] == passwordController.text &&
            row[3] == "cp") {
          final Data = row[0];
          // DrawerCp(Data.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CPTimeTableView1(myData: Data.toString())));
        } else if (row[1] == emailController.text &&
            row[2] == passwordController.text &&
            row[3] == "student") {
          print("student");
          final Data = row[0];
          // DrawerCp(Data.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimeTableView(myData: Data.toString())));
        }

        //     else if(row[1] == emailController.text  &&
        //     row[2] == passwordController.text &&
        //     row[3] == "CP")
        //     {
        //    final Data =row[0];
        //      // DrawerCp(Data.toString());
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>(myData: Data.toString())));
        //     }
        else if (row[1] == emailController.text &&
            row[2] == passwordController.text &&
            row[3] == "teacher") {
          print("teacher");
          final Data = row[0];
          // DrawerCp(Data.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TeTimeTableView(myData: Data.toString())));
        } else if (row[1] == emailController.text &&
            row[2] == passwordController.text &&
            row[3] == "attendent") {
          final Data = row[0];
          // DrawerCp(Data.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MTimeTableView(myData: Data.toString())));
        } else {
          setState(() {
            Invslid = "Invalid email or password";
          });
        }
      }

      emailController.text = "";
      passwordController.text = "";
      statusController.text = "";
    } else {
      setState(() {
        Invslid = "Please fill email or password";
      });
    }

  });});

    print(emailController.text);
    print(passwordController.text);

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    width: 260,
                    height: 180,
                  ),
                ),
                SizedBox(
                  height: 165,
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    "Login",
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
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText:
                        _obscurePassword, // Obfuscate the password text
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.key_outlined,
                        color: Colors.white,
                      ),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () => fetchData(),
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ExcelMenu()));
                    // },
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
                            "Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),

                // SizedBox(height: 14,),
                // Center(child: Text("Don't have any account?")),
                // Padding(
                //   padding: const EdgeInsets.all(0),
                //   child: TextButton(onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                //   }, child: Text("signup")),
                // ),

                SizedBox(
                  height: 14,
                ),
                Text(
                  Invslid,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
