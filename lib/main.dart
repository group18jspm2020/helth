import 'package:doctor/Screens/Login/components/body.dart';
import 'package:doctor/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool m=true;
  Future<bool> dbFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: check(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          return Container(); // your widget while loading
        }
        if(!snapshot.hasData){
          return Container(); //your widget when error happens
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: (m) ? WelcomeScreen():Dashboard(),
        ); //place your widget here
      },
    );
  }

   Future<bool> check() async {
    Map<String, String> allValues = await storage1.storage.readAll();
    m=allValues.isEmpty;
    if(!m) {
      Fluttertoast.showToast(
          msg: await storage1.storage.read(key: "email"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3);
    }
    return m;
   }
}
