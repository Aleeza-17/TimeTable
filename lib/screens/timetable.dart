

import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {


  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 260,top: 20),
                child: Image.asset("images/BUITEMS_logo.png",width: 130,height: 70,),
              ),
              SizedBox(height: 78,),
              Padding(
                padding: EdgeInsets.only(),
                child: Text("Time Table (FICT)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.place),
                    hintText: "Room",

                    border: InputBorder.none,

                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Enter Teacher",

                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.contact_mail_sharp),
                    hintText: "Semester",


                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.newspaper_outlined),
                    hintText: "course",


                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.timelapse),
                    hintText: "Timing",


                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.only(left: 7,right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(


                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_view_day),
                    hintText: "Day",


                    border: InputBorder.none,

                  ),
                ),
              ),

              SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: (){


                  },
                  child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(40),left: Radius.circular(40),),
                      ),
                      child: Center(
                        child: Text("add",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )
                  ),
                ),
              ),









            ],

          ),
        ),
      ),
    );
  }
}
