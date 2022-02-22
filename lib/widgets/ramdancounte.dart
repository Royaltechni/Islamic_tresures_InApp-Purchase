import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:provider/provider.dart';

class Ramdancount extends StatelessWidget {
  var ramdany;
  @override
  Widget build(BuildContext context) {
    var mon = HijriCalendar.now().hMonth;
    var day = HijriCalendar.now().hDay;
    var year = HijriCalendar.now().hYear;
    if (HijriCalendar.now().isBefore(year + 1, 09, 01)) {
      if (HijriCalendar.now().hMonth < 09) {
        ramdany = year;
      } else {
        ramdany = year + 1;
      }
    }
    var a = DateTime.utc(year, mon, day);
    var b = DateTime.utc(ramdany, 08, 30);
    var c = b.difference(a).inDays;
    print(c);
    
    int estimateTs = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 1, 0, 0, 0)
        .millisecondsSinceEpoch;
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          DateFormat format = DateFormat("mm:ss");
          int now = DateTime.now().millisecondsSinceEpoch;
          Duration remaining = Duration(milliseconds: estimateTs - now);
          var dateString =
              '${remaining.inHours}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
          List<String> splitValues = dateString.split(":");
          return Container(
              color: Colors.white.withOpacity(0.3),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      child: Image.asset('assets/images/boy.jpg')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(c.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'Days'
                                      : 'يوم',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                  dateString.split(':').first.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'Hour'
                                      : 'ساعة',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(splitValues[1].toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'Minutes'
                                      : 'دقيقة',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(splitValues[2].toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'Seconds'
                                      : 'ثانية',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ));
        });
  }
}
