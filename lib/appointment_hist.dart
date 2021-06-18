import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'color.dart';

class app_his extends StatelessWidget {
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
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment",style: TextStyle(fontSize: 21,color: Colors.blue),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => list_appointment()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          ),
          Container(
            height: 11,
            width: 20,
          )
        ],
      ),
      body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: new List.generate(
              10,
                  (int index) {
                return InkWell(
                  onTap: () => {setState(() {})},
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 5, right: 5),
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
                                            "asset/dash/1.png"),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vinayak Dhage",
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: color()
                                                    .primaryColor()),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 05,
                                                left: 05,
                                                right: 10,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2, left: 5),
                                                  child: Text(
                                                    "15 may 2021, 9:00 AM",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left:65 ),
                                                    child: Image(
                                                      image: AssetImage(
                                                          "asset/dash/horizontal_menu.png"),
                                                      height: 25,
                                                      width: 35,
                                                    )),
                                              ],
                                            ),
                                          ),

                                        ]),
                                  ),
                                ),
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
    );
  }
}
