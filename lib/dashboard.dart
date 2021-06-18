import 'package:custom_switch/custom_switch.dart';
import 'package:doctor/appointment_hist.dart';
import 'package:doctor/setting.dart';
import 'package:doctor/video_call.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'available.dart';
import 'color.dart';
import 'doctor_profile.dart';
import 'help.dart';
import 'main.dart';

class Dashboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFFecf1f6),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var icon1 = new Map();
  bool status = false;
  var dcolor = 0;

  Future initialise() async {
    var token = await _firebaseMessaging.getToken();
    print("Instance ID: " + token);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    icon1[0] = ["Profile", "assets/icons/profile.PNG",dprofie()];
    icon1[1] = ["Appointment History", "assets/icons/appointment.PNG",app_his()];
    icon1[2] = ["Video History", "assets/icons/video.PNG",video()];
    icon1[3] = ["Availability", "assets/icons/available.PNG",avail()];
    icon1[4] = ["Settings", "assets/icons/setting.PNG",setting()];
    icon1[5] = ["Help", "assets/icons/help.PNG",help()];
    icon1[6] = ["Logout", "assets/icons/logout.PNG",MyApp()];

    initialise();
    return Scaffold(
      appBar: AppBar(

        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        iconTheme: IconThemeData(
            color: Color(
              0xFF005ccc,
            )),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: Row(children: [
          Text(
            "Dashboard",
            style: GoogleFonts.lato(color: Color(0xFF005ccc), fontSize: 28),
          ),
          Padding(
            padding: EdgeInsets.only(left: 130),
            child: Image(
              image: AssetImage(
                "assets/icons/scanner.png",
              ),
              height: 35,
              width: 35,
            ),
          )
        ]),
        elevation: 0,
      ),
      drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                    ),
                    child: Container(
                      color: Colors.white,
                      margin:
                      EdgeInsets.only(top: 0, bottom: 10, left: 15, right: 15),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0, color: Color(0xFFF6F7F7)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, right: 20),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: new AssetImage(
                                              "assets/icons/vin.jpeg"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50, top: 5),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(children: [
                                        Text(
                                          check.n,
                                          style: GoogleFonts.inter(
                                              fontSize: 21, color: Colors.black),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    //padding: EdgeInsets.zero,
                    children: new List.generate(7, (int index) {
                      return ListTile(
                        title: Text(icon1[index][0]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return icon1[index][2];
                              },
                            ),
                          );
                        },
                        leading: Image(
                          image: AssetImage(icon1[index][1]),
                          width: 40,
                          height: 40,
                        ),
                      );
                    }),
                  ),
                ]),
          )),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              height: 170,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 0),
            child: Container(
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "Available for video Consultance:",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Color(
                            0xff005ccc,
                          )),
                    ),
                    Transform.scale(
                      scale: 0.80,
                      child: CustomSwitch(
                        activeColor: Color(0xFF005ccc),
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 12, right: 12),
            child: Container(
              height: 510,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                      child: Text(
                        "Upcomming Appointments",
                        style: GoogleFonts.lato(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Text(
                        DateFormat.MMMM().format(DateTime.now()) +
                            "-" +
                            DateFormat.y().format(DateTime.now()),
                        style: GoogleFonts.lato(
                            fontSize: 18, color: color().primaryColor()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 5),
                      child: new Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: color().secondaryColor(),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xff005ccc),
                            ),
                            const BoxShadow(
                              color: Color(0xff005ccc),
                              spreadRadius: -12.0,
                              blurRadius: 12.0,
                            ),
                          ],
                        ),
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: new List.generate(7, (int index) {
                            return InkWell(
                              onTap: () => {
                                setState(() {
                                  dcolor = index;
                                })
                              },
                              child: new Container(
                                width: 53,
                                color: (dcolor != index)
                                    ? color().secondaryColor()
                                    : color().primaryColor(),
                                child: new Container(
                                    alignment: Alignment.center,
                                    width: 50.0,
                                    height: 15.0,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(children: [
                                          Text(
                                            DateFormat.d().format(DateTime.now()
                                                .add(Duration(days: index))),
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: (dcolor == index)
                                                    ? color().secondaryColor()
                                                    : color().primaryColor(),
                                                fontSize: 28),
                                          ),
                                          Text(
                                            DateFormat.E().format(DateTime.now()
                                                .add(Duration(days: index))),
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: (dcolor == index)
                                                    ? color().secondaryColor()
                                                    : color().primaryColor(),
                                                fontSize: 15),
                                          ),
                                        ]))),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                        height: 355,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: new List.generate(
                            10,
                                (int index) {
                              return InkWell(
                                onTap: () => {setState(() {})},
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      top: 5, left: 5, right: 15),
                                  child: Container(
                                    //height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0, color: Color(0xFFF6F7F7)),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: new AssetImage(
                                                          "assets/icons/vin.jpeg"),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8, top: 3),
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          "Vinayak Dhage",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 18,
                                                              color: color()
                                                                  .primaryColor()),
                                                        ),
                                                        Text(
                                                          "Emergency appointment",
                                                          style:
                                                          GoogleFonts.inter(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 40),
                                                  child: Card(
                                                      shape: CircleBorder(),
                                                      child: InkWell(
                                                        onTap: () => {
                                                          setState(() {
                                                            //Call();
                                                          })
                                                        },
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.phone_in_talk,
                                                            color: Colors.green,
                                                            size: 30,
                                                          ),
                                                          onPressed: () {},
                                                        ),
                                                      )))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              left: 20,
                                              right: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.watch_later,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2, left: 5),
                                                child: Text(
                                                  "9:00 AM",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left:195 ),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/icons/horizontal_menu.png"),
                                                    height: 25,
                                                    width: 35,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          child: DottedLine(
                                            direction: Axis.horizontal,
                                            lineLength: double.infinity,
                                            lineThickness: 1.0,
                                            dashLength: 2.0,
                                            dashColor: Colors.black,
                                            dashRadius: 10.0,
                                            dashGapLength: 2.0,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: missing_return
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
