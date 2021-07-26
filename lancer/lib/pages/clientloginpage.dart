import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lancer/pages/clientregisterpage.dart';
import 'package:lancer/pages/landingpage.dart';
import 'package:lancer/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancer/components/InputField.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({Key? key}) : super(key: key);

  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {
  TextEditingController email = new TextEditingController(text: "john@doe.com");
  TextEditingController password = new TextEditingController(text: "pass");

  signIn(String email, String password) async {
    Map data = {"email": email, "password": password};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('http://YourIP/user/login');
    var response = await http.post(url, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "Login Successful",
            style: TextStyle(
              color: textWhite,
            ),
          ),
          content: Text(
            "Continue to dashboard",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textWhite,
            ),
          ),
          backgroundColor: primaryBg,
        ),
      );

      setState(() {
        print("CLIENTTTTTTT" + jsonData.clientId);
        prefs.setString('email', jsonData['data']['email'].toString());
        prefs.setString('name', jsonData['data']['name'].toString());
        prefs.setString('phone', jsonData['data']['phone'].toString());
        prefs.setBool('client', jsonData['data']['client']);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "Login unsuccessful",
            style: TextStyle(
              color: textWhite,
            ),
          ),
          content: Text(
            jsonData['error'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textWhite,
            ),
          ),
          backgroundColor: primaryBg,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: 50),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Icon(Icons.home_filled, color: textWhite, size: 30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Landing()),
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                margin: EdgeInsets.only(bottom: 50),
                child: SvgPicture.asset('assets/company.svg'),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Client",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Login",
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    color: textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Please sign in to continue",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputFields(
                  "Email",
                  Icon(
                    Icons.mail_outline,
                    color: textWhite,
                  ),
                  false,
                  email),
              inputFields(
                  "Password",
                  Icon(
                    Icons.lock,
                    color: textWhite,
                  ),
                  true,
                  password),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: TextButton(
                  onPressed: () {
                    signIn(email.text, password.text);
                  },
                  child: Text("ClientLogin"),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    primary: primaryBg,
                    backgroundColor: textColor,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?"),
                  style: TextButton.styleFrom(
                    primary: textColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: secondaryText),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientRegister()),
                          );
                        },
                        child: Text("Sign Up"),
                        style: TextButton.styleFrom(
                          primary: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
