import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Ramdanitem extends StatelessWidget {
  String title;
  String image;
  Widget widget;

//  Ramdanitem(this.title, this.image);
  Ramdanitem(this.title, this.image, this.widget);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: this.widget,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7).add(EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01)),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Color.fromRGBO(62, 194, 236, 1),
          child: Container(
            margin: EdgeInsets.only(left: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    this.title,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Image.asset(this.image)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
