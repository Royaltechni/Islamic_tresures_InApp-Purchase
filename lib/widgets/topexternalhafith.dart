import 'package:flutter/material.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:provider/provider.dart';

class Topexternalhadithcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Provider.of<Userprovider>(context, listen: false)
                .topexternal
                .hadith
                .length
                .toDouble(),
        child: ListView.builder(
            itemCount: Provider.of<Userprovider>(context, listen: false)
                .topexternal
                .hadith
                .length,
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
                              child: Image.asset('assets/images/bronze5.png')),
                        Text(
                          Provider.of<Userprovider>(context, listen: false)
                              .topexternal
                              .hadith[index]
                              .name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            Provider.of<Userprovider>(context, listen: false)
                                .topexternal
                                .hadith[index]
                                .hadith,
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
