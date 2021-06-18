import 'dart:convert';
import 'dart:io';
import 'package:doctor/storage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

import 'dashboard.dart';

class form extends StatelessWidget {
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
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  int _gender_value = 1, spec_value = 1;
  PickResult selectedPlace;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate1 = DateTime.now();

  bool i = true;
  String time = "";
  String time1 = "";
  String addressp;
  var _image;

  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController mobile_no = new TextEditingController();
  TextEditingController address1 = new TextEditingController();
  TextEditingController address2 = new TextEditingController();
  TextEditingController degree = new TextEditingController();
  TextEditingController duration = new TextEditingController();
  TextEditingController descpt = new TextEditingController();
  TextEditingController Appointment_charge = new TextEditingController();
  TextEditingController videocall_charge = new TextEditingController();

  void _uploadImage() async {
    final _picker = ImagePicker();

    var _pickedImage = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = _pickedImage.path;
    });
  }

  Future _handle() async {
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.camera]);
  }

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimLocationPicker(
            searchHint: 'warje,pune',
            awaitingForLocation: "warje,pune",
          );
        });
    if (result != null) {
      Map s;
      setState(() => addressp = result['desc']);
    } else {
      return;
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        i = false;
      });
  }

  _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate1 = picked;
        i = false;
      });
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10 && value.length != 0)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  timeM(context) async {
    TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
    );
    setState(() => time = newTime.format(context));
    //var m= TimeOfDay.fromDateTime(DateTime.parse(newTime.toString()));
  }

  timeE(context) async {
    TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
    );
    setState(() => time1 = newTime.format(context));
    //var m= TimeOfDay.fromDateTime(DateTime.parse(newTime.toString()));
  }

  @override
  Widget build(BuildContext context) {
    _handle();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Personal'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: TextField(
                              controller: fname,
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
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: TextField(
                              controller: lname,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: "Last Name",
                                  fillColor: Colors.white),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            width: 340.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  value: _gender_value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "Gender",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Male",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Female",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Trans",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 4),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _gender_value = value;
                                    });
                                  },
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: Row(children: [
                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    _selectDate(context);
                                  })
                                },
                                child: Text(
                                  (i)
                                      ? "Date of birth"
                                      : "${selectedDate.toLocal()}"
                                          .split(' ')[0],
                                  style: GoogleFonts.lato(
                                      fontSize: 18, color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 170),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey[600],
                                    ),
                                    iconSize: 32,
                                    onPressed: () => _selectDate(context),
                                  ))
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: "Email: " + value.email,
                                  fillColor: Colors.white),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              autovalidate: true,
                              validator: (input) =>
                                  EmailValidator.validate(input) ||
                                          (input.length == 0)
                                      ? null
                                      : "Check your email",
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(children: [
                              Text(
                                "+91",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Container(
                                width: 262,
                                child: TextFormField(
                                    controller: mobile_no,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600]),
                                        hintText: "Personal Phone Number",
                                        fillColor: Colors.white),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    autovalidate: true,
                                    validator: (input) =>
                                        validateMobile(input)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white),
                                padding: EdgeInsets.all(5.0),
                              ),
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 17),
                          child: Text(
                            "Address:",
                            style: GoogleFonts.lato(fontSize: 21),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: TextField(
                              controller: address1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: "Shop no./Plot no",
                                  fillColor: Colors.white),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container(
                            child: TextField(
                              controller: address2,
                              onTap: () => {
                                /*Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PlacePicker(
                                      apiKey:
                                          "AIzaSyCZ0FkQMRH-lTclBeKRfgDecKyBVZqhC20",
                                      //initialPosition:StepperDemo.kInitialPosition,
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,
                                      usePlaceDetailSearch: true,
                                      onPlacePicked: (result) {
                                        selectedPlace = result;
                                        print(selectedPlace);
                                        Navigator.of(context).pop();
                                      });
                                })),*/

                                getLocationWithNominatim(),
                                setState(() {})
                              },
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: (addressp == null)
                                      ? "Locality"
                                      : addressp,
                                  fillColor: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Professional'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 340.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  value: spec_value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "Specialist",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Heart",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Dental",
                                        style: GoogleFonts.lato(
                                            color: Colors.grey[600],
                                            fontSize: 18),
                                      ),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Lungs",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 4),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Kidney",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 5),
                                    DropdownMenuItem(
                                        child: Text(
                                          "ENT",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 6),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Stomach",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 7),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Brain",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 8),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Eye",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 9),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Bone",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 10),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Gync",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 11),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Other",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[600],
                                              fontSize: 18),
                                        ),
                                        value: 12),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      spec_value = value;
                                    });
                                  },
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            child: TextField(
                              controller: degree,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  hintText: "Education detail/Degree",
                                  fillColor: Colors.white),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3, bottom: 20),
                          child: Text(
                            "Practice start date :",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 270,
                            child: Row(children: [
                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    _selectDate1(context);
                                  })
                                },
                                child: Text(
                                  (i)
                                      ? "select Date"
                                      : "${selectedDate1.toLocal()}"
                                          .split(' ')[0],
                                  style: GoogleFonts.lato(
                                      fontSize: 18, color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 100),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey[600],
                                    ),
                                    iconSize: 32,
                                    onPressed: () => _selectDate1(context),
                                  ))
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3, bottom: 20),
                          child: Text(
                            "Appointment Duration(min):",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: NumberInputWithIncrementDecrement(
                            controller: duration,
                            min: 10,
                            max: 60,
                            incDecFactor: 5,
                            initialValue: 10,
                            decIconSize: 30,
                            incIconSize: 30,
                            widgetContainerDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3, bottom: 20),
                          child: Text(
                            "Appointment starting time :",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 275,
                            height: 55,
                            child: Row(children: [
                              InkWell(
                                onTap: () => timeM(context),
                                child: Text(
                                  (time.isEmpty) ? "select Time" : time,
                                  style: GoogleFonts.lato(
                                      fontSize: 18, color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 105),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.watch_later,
                                      color: Colors.grey[600],
                                    ),
                                    iconSize: 32,
                                    onPressed: () => timeM(context),
                                  ))
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3, bottom: 20),
                          child: Text(
                            "Appointment End time :",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 275,
                            height: 55,
                            child: Row(children: [
                              InkWell(
                                onTap: () => timeE(context),
                                child: Text(
                                  (time1.isEmpty) ? "select Time" : time1,
                                  style: GoogleFonts.lato(
                                      fontSize: 18, color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 105),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.watch_later,
                                      color: Colors.grey[600],
                                    ),
                                    iconSize: 32,
                                    onPressed: () => timeE(context),
                                  ))
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 20),
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Profile'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 95),
                          child: InkWell(
                            onTap: () => {_uploadImage()},
                            child: Container(
                              height: 160,
                              width: 160,
                              alignment: Alignment.center, // T
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (_image != null)
                                        ? FileImage(File(_image))
                                        : AssetImage("assets/icons/1.png"),
                                    fit: BoxFit.fill),
                              ), // his is needed
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "Description:",
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 5,
                              controller: descpt,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'description',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            padding: EdgeInsets.all(15.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 17),
                          child: Text(
                            "Charger per Appontment:",
                            style: GoogleFonts.lato(fontSize: 21),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(children: [
                              Text(
                                "\u{20B9}",
                                style: TextStyle(
                                  fontSize: 21.0,
                                ),
                              ),
                              Container(
                                width: 262,
                                child: TextFormField(
                                  controller: Appointment_charge,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      filled: true,
                                      hintStyle: new TextStyle(
                                          color: Colors.grey[600]),
                                      hintText: "Enter Amount",
                                      fillColor: Colors.white),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  autovalidate: true, ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white),
                                padding: EdgeInsets.all(5.0),
                              ),
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18)),
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 17),
                          child: Text(
                            "Charger per Video consultance:",
                            style: GoogleFonts.lato(fontSize: 21),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 115),
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(children: [
                              Text(
                                "\u{20B9}",
                                style: TextStyle(
                                  fontSize: 21.0,
                                ),
                              ),
                              Container(
                                width: 262,
                                child: TextFormField(
                                    controller: videocall_charge,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600]),
                                        hintText: "Enter Amount",
                                        fillColor: Colors.white),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    autovalidate: true, ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white),
                                padding: EdgeInsets.all(5.0),
                              ),
                            ]),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(18)),
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => fun()) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  fun() {
    if (_currentStep == 0) {
      value.fn = fname.text.toString();
      value.ln = lname.text.toString();
      value.mn = mobile_no.text.toString();
      value.add = address1.text.toString();
      value.loc = addressp;
      value.dob = "${selectedDate.toLocal()}".split(' ')[0];
      var gen = ["g", "g", "M", "F", "T"];
      value.gender = gen[_gender_value];

      if (value.fn.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter First name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.ln.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Last name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.dob.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter date of birth",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (_gender_value < 2) {
        Fluttertoast.showToast(
            msg: "Enter gneder",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.mn.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Mobile no",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.add.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter shop no./plot no.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else {
        print(value.email);
        print(value.pass);
        print(value.fn);
        print(value.ln);
        print(value.mn);
        print(value.loc);
        print(value.dob);
        print(value.gender);
        print(value.add);
        _currentStep += 1;
      }
    }
    else if (_currentStep == 1) {
      var spec = [
        "d",
        "d",
        "Heart",
        "Dental",
        "lungs",
        "Kidney",
        "ENT",
        "Stomach",
        "Brain",
        "Eye",
        "Bone",
        "Gyne",
        "other"
      ];
      value.spec = spec[spec_value];
      value.degree = degree.text.toString();
      value.pract = "${selectedDate1.toLocal()}".split(' ')[0];
      value.duration = duration.text.toString();
      value.st = time1;
      value.et = time;
      if (spec_value < 2) {
        Fluttertoast.showToast(
            msg: "select Specilisation",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.degree.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Degree",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.duration.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Apointment duration",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.st.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter apointment start time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else if (value.et.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Apointment end time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      } else {
        print(value.spec);
        print(value.degree);
        print(value.pract);
        print(value.duration);
        print(value.st);
        print(value.et);
        _currentStep += 1;
      }
    }
    else {
      value.desc = descpt.text.toString();
      value.Appointment_charge = Appointment_charge.text.toString();
      value.videocall_charge = videocall_charge.text.toString();
      if (value.desc.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Description",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      }
      else if (value.Appointment_charge.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter Appointment charge",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3);
      }
      else if (value.videocall_charge.isEmpty) {
        Fluttertoast.showToast(
            msg: "Enter video call charge",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3);
      }
      else {
        create_doctor();
      }
    }
  }

  create_doctor() async {
    print("dd");
    final response = await http.post(
        Uri.parse('http://35.178.74.191:8000/account/create_doctor/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": value.email,
          "password": value.pass,
          "country_code": "+91",
          "phone": value.mn,
          "doctor": {
            "first_name": value.fn,
            "last_name": value.ln,
            "dob": value.dob,
            "gender": value.gender,
            "speciality": value.spec,
            "degree": value.degree,
            "appoinment_duration": value.duration,
            "practice_started": value.pract,
            "start_time": value.st,
            "end_time": value.et,
            "charge_per_app": value.Appointment_charge,
            "charge_per_vc":value.videocall_charge
          },
          "address": [
            {
              "house_no": value.add,
              "locality": value.loc,
            },
          ]
        }));

    var jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 201) {
      call_jwt(value.email, value.pass);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
      Fluttertoast.showToast(
          msg: " Profile created sucessefully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    } else {
      Fluttertoast.showToast(
          msg: "sry try again after some time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
  }

  call_jwt(String email,String pass) async {
    final response = await http.post
      (
      await Uri.parse('http://35.178.74.191:8000/account/api/token/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": pass
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var refresh=jsonResponse['refresh'];
      var access=jsonResponse['access'];
      await storage1.storage.write(key: "refresh", value: refresh);
      await storage1.storage.write(key: "access", value: access);
      await storage1.storage.write(key: "email", value: email);
      await storage1.storage.write(key: "pass", value: pass);
    }
    else {
      print(response.statusCode);
    }
  }
}

class value {
  static String email = "",
      pass = "",
      fn = "",
      ln = "",
      mn = "",
      loc = "",
      dob = "",
      gender = "",
      add = "",
      spec = "",
      pract = "",
      duration = "",
      st = "",
      et = "",
      degree = "",
      desc = "",
      videocall_charge="",
  Appointment_charge="";

}
