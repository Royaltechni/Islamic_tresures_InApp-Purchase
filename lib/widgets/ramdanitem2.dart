import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Ramdanitem2 extends StatelessWidget {
  
  String title;
  String image;
  Ramdanitem2.b(this.title, this.image);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7).add(EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).primaryColor,
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
    );
  }
}