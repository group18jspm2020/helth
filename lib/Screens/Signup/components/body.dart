import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:doctor/Screens/Login/login_screen.dart';
import 'package:doctor/Screens/Signup/components/background.dart';
import 'package:doctor/Screens/Signup/components/or_divider.dart';
import 'package:doctor/Screens/Signup/components/social_icon.dart';
import 'package:doctor/components/already_have_an_account_acheck.dart';
import 'package:doctor/components/rounded_button.dart';
import 'package:doctor/components/rounded_input_field.dart';
import 'package:doctor/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../form.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class token{
  static String refresh,access;
}

class Body extends StatelessWidget {
String email="",pass="";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email=value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                pass=value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
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
                  await call_jwt(email,pass);
                  if(!check.value){

                    Fluttertoast.showToast(
                        msg: "Account is preset",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3
                    );
                  }
                  else {
                    value.email=email;
                    value.pass=pass;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return form();
                        },
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  call_jwt(String email,String pass) async {
  final response = await http.post
    (
    await Uri.parse('http://35.178.74.191:8000/account/isEmailAvailable/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email
    }),
  );

  if (response.statusCode == 200) {
    check.value=true;
  } else {
    print(response.statusCode);
    check.value= false;
  }
  print(check.value);
}


}

class check{
  static bool value=false;
}
