import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lancer/pages/loginpage.dart';
import 'package:lancer/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lancer/components/InputField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = new TextEditingController(text: "john doe");
  TextEditingController password = new TextEditingController(text: "password");
  TextEditingController email = new TextEditingController(text: "john@doe.com");
  TextEditingController confirmpass =
      new TextEditingController(text: "password");
  TextEditingController phone = new TextEditingController(text: "9876543210");
  signUp(String email, String password, String cpassword, String phone,
      String name) async {
    if (password != cpassword) {
      print("Passwords don't match");
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "Passwords do not match",
            style: TextStyle(
              color: textWhite,
            ),
          ),
          content: Text(
            "Try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textWhite,
            ),
          ),
          backgroundColor: primaryBg,
        ),
      );
    } else {
      Map data = {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone
      };
      // var jsonData = null;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var url = Uri.parse('http://YourIP/user/signup');
      var response = await http.post(url, body: data);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              "Registration successful",
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
          prefs.setString('email', jsonData['data']['email'].toString());
          prefs.setString('name', jsonData['data']['name'].toString());
          prefs.setString('phone', jsonData['data']['phone'].toString());
          // prefs.setBool('client', jsonData['data']['client']);
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              "Registration unsuccessful",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: textWhite,
            size: 28,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Freelancer",
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
                  "Create Account",
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    color: textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Please fill in your details below",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: secondaryText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              inputFields(
                  "Full name",
                  Icon(
                    Icons.person,
                    color: textWhite,
                  ),
                  false,
                  name),
              inputFields(
                  "Phone",
                  Icon(
                    Icons.phone_android,
                    color: textWhite,
                  ),
                  false,
                  phone),
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
              inputFields(
                  "Confirm Password",
                  Icon(
                    Icons.lock,
                    color: textWhite,
                  ),
                  true,
                  confirmpass),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: TextButton(
                  onPressed: () {
                    signUp(email.text, password.text, confirmpass.text,
                        phone.text, name.text);
                  },
                  child: Text("Register"),
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
                margin: EdgeInsets.only(top: 60, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: secondaryText),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text("Login"),
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
