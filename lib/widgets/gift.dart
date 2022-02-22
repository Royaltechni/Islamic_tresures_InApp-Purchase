import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gift extends StatelessWidget {
  String image;
  String title;
  String title2;
  Color color1;
  Color color2;
  Color color3;
  Color color4;
  Color color5;
  Color color6;

  Gift(this.title, this.title2, this.image, this.color1, this.color2,
      this.color3, this.color4, this.color5, this.color6);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(this.image),
            Center(
              child: Text(
                this.title,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: this.color6,
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                this.title2,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Color.fromRGBO(153, 153, 153, 1),
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: this.color1,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  color: this.color2,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  color: this.color3,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  color: this.color4,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  color: this.color5,
                  size: 35,
                ),
              ],
            )
          ],
        ));
  }
}
