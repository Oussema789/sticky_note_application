import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double barHeight = 50.0;

  MyAppBar({ Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 100.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title,
                  style:  GoogleFonts.bungee(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,

                  ),

                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight + 100));
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}