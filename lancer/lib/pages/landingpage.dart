import 'package:flutter/material.dart';
import 'package:lancer/pages/clientregisterpage.dart';
import 'package:lancer/pages/registerpage.dart';
import 'package:lancer/pages/loginpage.dart';

import 'package:lancer/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
            children: [
              Container(
                // color: Colors.white,
                width: 200,
                height: 200,
                child: SvgPicture.asset('assets/landing.svg'),
              ),
              Text(
                "Lancer",
                style: GoogleFonts.yellowtail(fontSize: 50, color: textWhite),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Lancer is is a simple app that helps you find a job in the " +
                      "fastest way possible.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: textWhite,
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(top: 40),
              //   child: Text(
              //     "What describes you the best?",
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.roboto(
              //       fontSize: 20,
              //       color: textWhite,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text("I'm a Freelancer"),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        primary: primaryBg,
                        backgroundColor: textColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientRegister()),
                        );
                      },
                      child: Text("I'm a Client"),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        primary: primaryBg,
                        backgroundColor: textColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
