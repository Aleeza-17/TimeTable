import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 210, top: 20),
                child: Image.asset(
                  "images/BUITEMS_logo.png",
                  width: 130,
                  height: 70,
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(3.1415926535897932 / 10),
                  child: Container(
                      child: Image.asset(
                    'images/welcome.png',
                    width: 280,
                    height: 420,
                  ))),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(40),
                          left: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
