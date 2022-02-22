import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Eroorr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 40),
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'You have completed this already',
                textAlign:TextAlign .center ,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    
                      color: Color.fromRGBO(153, 153, 153, 1),
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
