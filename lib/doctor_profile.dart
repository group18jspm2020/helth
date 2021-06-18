import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:doctor/Screens/Login/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color.dart';
import 'package:http/http.dart' as http;

class dprofie extends StatelessWidget {
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
      home: StepperDemo(),
    );
  }
}

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  final _controller = ScrollController();
  String email = "cs";
  bool i = false, j = false, k = false, l = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          print("def");
          return Container(); // your widget while loading
        }
        print("fff");
        Timer(
          Duration(seconds: 0),
              () => _controller.jumpTo(_controller.position.maxScrollExtent),
        );
        return Scaffold(
            body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()),);
                },
              ),
              backgroundColor: color().primaryColor(),
              expandedHeight: 300,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage("assets/icons/vin.jpeg"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.only(top: 0, bottom: 5, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Color(0xFFF6F7F7)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 300,
                                  child: Text(
                                    check.n,
                                    style: TextStyle(
                                        fontFamily: 'playfair', fontSize: 25),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: IconButton(
                                    icon: Icon(
                                      !i ? Icons.edit : Icons.save,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (!i)
                                          i = true;
                                        else
                                          i = false;
                                      });
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()),);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              check.degree,
                              style: TextStyle(
                                  fontFamily: 'playfair',
                                  fontSize: 20,
                                  color: color().primaryColor()),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 5,
                              initialValue:check.desc,
                              style: GoogleFonts.lato(
                                  fontSize: 17, color: Colors.grey),
                              textAlign: TextAlign.justify,
                              readOnly: !i ? true : false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: "First Name",
                                  fillColor: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          check.spec,
                          style: GoogleFonts.inter(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () => {
                            setState(() async {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Rating()));
                            })
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(children: [
                              Text(
                                "4" + "/5",
                                style: TextStyle(
                                    fontFamily: 'playfair',
                                    fontSize: 30,
                                    color: color().primaryColor()),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "79" + "  Rating",
                                    style: GoogleFonts.lato(
                                        fontSize: 15, color: Colors.grey),
                                  )),
                              Text(
                                "& " + "5" + " Reviews",
                                style: GoogleFonts.lato(
                                    fontSize: 15, color: Colors.grey),
                              )
                            ]),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(children: [
                          Text(
                            check.exp,
                            style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 30,
                                color: color().primaryColor()),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "Year of",
                                style: GoogleFonts.lato(
                                    fontSize: 15, color: Colors.grey),
                              )),
                          Text(
                            "Experience",
                            style: GoogleFonts.lato(
                                fontSize: 15, color: Colors.grey),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(children: [
                          Text(
                            "500+",
                            style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 30,
                                color: color().primaryColor()),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "Patient",
                                style: GoogleFonts.lato(
                                    fontSize: 15, color: Colors.grey),
                              )),
                          Text(
                            "Treated",
                            style: GoogleFonts.lato(
                                fontSize: 15, color: Colors.grey),
                          )
                        ]),
                      ),
                    ),
                  ],
                )
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 15, right: 15, bottom: 10),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Row(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Icon(Icons.location_on,
                                        color: color().primaryColor(),
                                        size: 30),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5, top: 5),
                                    child: Text("Address",
                                        style: GoogleFonts.inter(
                                            color: Colors.black, fontSize: 22)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 180),
                                    child: IconButton(
                                      icon: Icon(
                                        !j ? Icons.edit : Icons.save,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (!j)
                                            j = true;
                                          else
                                            j = false;
                                        });
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()),);
                                      },
                                    ),
                                  ),
                                ]),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 5,
                                    initialValue:check.add,
                                    style: GoogleFonts.lato(
                                        fontSize: 17, color: Colors.grey),
                                    textAlign: TextAlign.justify,
                                    readOnly: !j ? true : false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600]),
                                        hintText: "First Name",
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ],
                            )))
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Row(children: [
                                      Icon(Icons.call,
                                          color: color().primaryColor(),
                                          size: 35),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Phone Number",
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 22)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 105),
                                        child: IconButton(
                                          icon: Icon(
                                            !k ? Icons.edit : Icons.save,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (!k)
                                                k = true;
                                              else
                                                k = false;
                                            });
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()),);
                                          },
                                        ),
                                      ),
                                    ])),
                                Row(children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Container(
                                      width: 230,
                                      child: TextFormField(
                                        minLines: 1,
                                        maxLines: 5,
                                        initialValue:
                                            check.mn,
                                        style: GoogleFonts.lato(
                                            fontSize: 18, color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                        readOnly: !k ? true : false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            filled: true,
                                            hintStyle: new TextStyle(
                                                color: Colors.grey[600]),
                                            hintText: "First Name",
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ])
                              ],
                            )))),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Row(children: [
                                      Icon(Icons.email,
                                          color: color().primaryColor(),
                                          size: 35),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Email Address",
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 22)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 105),
                                        child: IconButton(
                                          icon: Icon(
                                            !l ? Icons.edit : Icons.save,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (!l)
                                                l = true;
                                              else
                                                l = false;
                                            });
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()),);
                                          },
                                        ),
                                      ),
                                    ])),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 5,
                                    initialValue: check.email,
                                    style: GoogleFonts.lato(
                                        fontSize: 19, color: Colors.grey),
                                    textAlign: TextAlign.justify,
                                    readOnly: !l ? true : false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600]),
                                        hintText: "First Name",
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ],
                            )))),
              ]),
            ),
          ],
        )); //place your widget here
      },
    );
  }

  getdata() async {
    final response = await http.post(await Uri.parse('https://run.mocky.io/v3/f63e7412-9d50-472e-85f5-eb8e125e8124'),);
    if (response.statusCode == 200) {
      Map d = json.decode(response.body);
      check.id=d["user"]["id"].toString();
      check.email=d["user"]["email"].toString();
      check.mn=d["user"]["country_code"].toString()+" " +d["user"]["phone"].toString();
      check.n="Dr "+d["doctor"]["first_name"].toString()+" "+d["doctor"]["last_name"].toString();
      check.degree=d["doctor"]["degree"].toString();
      check.spec=d["doctor"]["speciality"].toString()+" specilist";
      check.exp=d["experience"].toString();
      check.desc='Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old';
      check.add=d["address"][0]["house_no"].toString()+" "+d["address"][0]["locality"].toString();
    } else {
      print(response.statusCode);
    }
  }
}

class check{
  static String email = "",
  pass = "",
  n = "",
  mn = "",
  dob = "",
  gender = "",
  add = "",
  spec = "",
  degree = "",
  desc = "",
  exp="",
  id="";
}