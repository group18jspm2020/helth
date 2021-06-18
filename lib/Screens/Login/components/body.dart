import 'package:doctor/dashboard.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Screens/Login/components/background.dart';
import 'package:doctor/Screens/Signup/signup_screen.dart';
import 'package:doctor/components/already_have_an_account_acheck.dart';
import 'package:doctor/components/rounded_button.dart';
import 'package:doctor/components/rounded_input_field.dart';
import 'package:doctor/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../storage.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var email, pass;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                pass = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: ()
              async {
                if(!EmailValidator.validate(email)){
                  Fluttertoast.showToast(
                      msg: "Enter valid Email",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3
                  );
                }
                else if(pass.isEmpty){
                  Fluttertoast.showToast(
                      msg: "Enter valid Password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3
                  );
                }
                else {
                  await call_jwt(email, pass);
                  if (check.value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Dashboard();
                        },
                      ),
                    );
                  }
                  else {
                    final snackBar = SnackBar(
                      content: Text('Invalid Email or Password!'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
      check.refresh=jsonResponse['refresh'];
      check.access=jsonResponse['access'];
      await storage1.storage.write(key: "refresh", value: check.refresh);
      await storage1.storage.write(key: "access", value: check.access);
      await storage1.storage.write(key: "email", value: email);
      await storage1.storage.write(key: "pass", value: pass);
      check.value=true;
    }
    else {
      print(response.statusCode);
      check.value= false;
    }
  }
}

class check{
  static bool value=false;
  static var refresh,access;
}