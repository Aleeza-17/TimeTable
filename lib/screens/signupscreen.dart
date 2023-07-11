import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Drawermain.dart';

import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'mainscreen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  String FieldNull = "";
  Future main() async {
    // Open a connection (testdb should already exist)
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'unitabledb',
    ));
    print("database");
    String email = emailController.text;

    String password = passwordController.text;
    String status = statusController.text;
    print(email);
    print(password);
    print(status);
    if (passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        statusController.text.isNotEmpty) {
      var stmt =
          "INSERT INTO userregistry (id, Email, Password, Status) VALUES (?, ?, ?, ?);";

      // Execute the prepared statement with values
      var result = await conn.query(stmt, [null, email, password, status]);
      emailController.text = "";
      passwordController.text = "";
      statusController.text = "";
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
        title: Text("User Registration"),
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
                    "User Registration",
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
                        emailController, // Assign the TextEditingController
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
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
                    controller:
                        passwordController, // Assign the TextEditingController

                    decoration: InputDecoration(
                      icon: Icon(Icons.key_outlined, color: Colors.white),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
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
                    controller: statusController,
                    decoration: InputDecoration(
                      icon:
                          Icon(Icons.person_pin_outlined, color: Colors.white),
                      hintText: "status",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
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
                          "User Registration",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                // SizedBox(height: 14,),

                // Padding(
                //   padding: const EdgeInsets.all(0),
                //   child: TextButton(onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                //   }, child: Text("login")),
                // ),

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
