import 'package:flutter/material.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:provider/provider.dart';

class Topclasssalahcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int len;
    if (Provider.of<Userprovider>(context, listen: false)
            .topclassstudents
            .salah[0]
            .totalGrade ==
        0) {
      len = 0;
    }
   else if (Provider.of<Userprovider>(context, listen: false)
            .topclassstudents
            .salah[1]
            .totalGrade ==
        0) {
      len = 1;
    }
  else  if (Provider.of<Userprovider>(context, listen: false)
            .topclassstudents
            .salah[2]
            .totalGrade ==
        0) {
      len = 2;
    }
   else  if (Provider.of<Userprovider>(context, listen: false)
            .topclassstudents
            .salah[3]
            .totalGrade ==
        0) {
      len = 3;
    }
     else {
      len = 4;
    }
    List<Color> colors = [
      Colors.blue,
      Colors.amber,
      Colors.amber[800],
      Colors.grey,
      Colors.black
    ];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 60 *
           len
                .toDouble(),
        child: ListView.builder(
            itemCount: len,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        if (index == 0)
                          Container(
                              height: 40,
                              //  width: 35,
                              child: Image.asset('assets/images/gold1.png')),
                        if (index == 1)
                          Container(
                              height: 40,
                              child: Image.asset('assets/images/gold2.png')),
                        if (index == 2)
                          Container(
                              height: 40,
                              child: Image.asset('assets/images/silver3.png')),
                        if (index == 3)
                          Container(
                              height: 40,
                              child: Image.asset('assets/images/silver4.png')),
                        if (index == 4)
                          Container(
                              height: 40,
                              child: Image.asset(
                                'assets/images/bronze5.png',
                                fit: BoxFit.contain,
                              )),
                        Text(
                          Provider.of<Userprovider>(context, listen: false)
                              .topclassstudents
                              .salah[index]
                              .name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            Provider.of<Userprovider>(context, listen: false)
                                .topclassstudents
                                .salah[index]
                                .totalGrade
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
