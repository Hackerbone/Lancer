import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lancer/pages/clientregisterpage.dart';
import 'package:lancer/pages/registerpage.dart';
import 'package:lancer/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map _currentUser = {};
  // Future getInitData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     currentUser = json.decode(prefs.getString('user').toString());
  //     print(currentUser);
  //     print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
  //   });
  // }
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUser = {
        "email": prefs.getString('email').toString(),
        "name": prefs.getString('name').toString(),
        "phone": prefs.getString('phone').toString(),
        "client": prefs.getString('client'),
      };
      print(_currentUser);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }
  // @override
  // void initState() async {
  //   super.initState();
  //   getInitData();

  // var url = Uri.parse('http://YourIP/user/login');
  // var response = await http.get(url);
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  // var jsonData = json.decode(response.body);
  // }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
