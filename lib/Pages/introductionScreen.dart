

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sticky_notes_app/Pages/HomePage.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomePage(),
      title: new Text('It is better\nwrite your notes',
        style:  GoogleFonts.bungee(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w900,

        ),
      ),
      image:  Image.asset('images/logo.png'),
      backgroundColor: Colors.orange,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,

    );
  }
}