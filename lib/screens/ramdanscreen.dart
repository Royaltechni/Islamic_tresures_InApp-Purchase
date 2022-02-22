import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:kidsapp/models/Athan.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/Athan.dart';
import 'package:kidsapp/providers/deedprovider.dart';
import 'package:kidsapp/providers/duaaprovider.dart';
import 'package:kidsapp/providers/hadithprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';

import 'package:kidsapp/screens/dua.dart';
import 'package:kidsapp/screens/hadethramdan.dart';
import 'package:kidsapp/screens/sera.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/widgets/Dialycheaklist2.dart';
import 'package:kidsapp/widgets/gift.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:kidsapp/widgets/ramdancounte.dart';
import 'package:kidsapp/widgets/ramdanitem.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class Ramdan extends StatefulWidget {
  static const String route = '/ramdan';
  static var day = new HijriCalendar.now().hDay;
  @override
  _RamdanState createState() => _RamdanState();
}

class _RamdanState extends State<Ramdan> {
  int surracounter = 0;
  int vercecounter = 0;
  int goz2counter = 0;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  bool value6 = false;
  bool value7 = false;
  bool value8 = false;
  bool select1 = false;
  bool select2 = false;
  bool select3 = false;
  bool select4 = false;
  bool firstrun;
  int hour;
  int minute;
  int hour1;
  int min;
  int hours;
  bool loading;
  int year;
  int mon;
  int day;
  int ramdany;

  Color color = Color.fromRGBO(62, 194, 236, 1);
  DateTime datetime = DateTime.now();
  @override
  void initState() {
    super.initState();
    firstrun = true;
    loading = false;
    Provider.of<Lanprovider>(context, listen: false).getLan();
    Provider.of<Lanprovider>(context, listen: false).getLan2();
    Provider.of<Lanprovider>(context, listen: false).getLan3();
    Provider.of<Lanprovider>(context, listen: false).getLan4();
    Provider.of<Lanprovider>(context, listen: false).getLan5();
    Provider.of<Lanprovider>(context, listen: false).getLan6();
    Provider.of<Lanprovider>(context, listen: false).getLan7();
    Provider.of<Lanprovider>(context, listen: false).getLan8();
    Provider.of<Lanprovider>(context, listen: false).getcounter1();
    Provider.of<Lanprovider>(context, listen: false).getcounter2();
    Provider.of<Lanprovider>(context, listen: false).getcounter3();
    Provider.of<Athanprovider>(context, listen: false).getLan();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Provider.of<Hadithprovider>(context, listen: false).fetchallhadith();
    await Provider.of<Duaaprovider>(context, listen: false).fetchallduaas();
    await Provider.of<Deedprovider>(context, listen: false).fetchalldeed();
     await Provider.of<Lanprovider>(context, listen: false).savedate();
    await Provider.of<Lanprovider>(context, listen: false).getdate();
    if (DateTime.now().day.toString() !=
        Provider.of<Lanprovider>(context, listen: false).time) {
      Provider.of<Lanprovider>(context, listen: false).cleardata();

      Provider.of<Lanprovider>(context, listen: false).savedate();
    }
    if (Dbhandler.instance.ramadanstatuscode == 200) {
      hour = int.parse(Athanprovider.maghribtime.split(':').first);
      minute = int.parse(Athanprovider.maghribtime.split(':').last);
      var format = DateFormat("HH:mm");
      var one = format.parse("$hour:$minute");
      var two = format.parse("${datetime.hour}:${datetime.minute}");
      if (two.isBefore(one)) {
        var five = one.difference(two);
        print(five.toString().length);
        min = (five.toString().length == 14)
            ? int.parse(five.toString().substring(2, 4))
            : int.parse(five.toString().substring(3, 5));
        hours = int.parse(five.toString().split(':').first);
      } else {
        var four = two.difference(one);
        min = 60 - int.parse(four.toString().substring(2, 4));
        hours = 23 - int.parse(four.toString().split(':').first);
      }
    }

    if (!mounted) return;
    setState(() {
      firstrun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mounth = new HijriCalendar.now().getLongMonthName().toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Networkprovider.cheak == false
            ? Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Check your network connection',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).accentColor)),
                        onPressed: () async {
                          Home.homeindex = 6;

                          await Navigator.push(
                            // or pushReplacement, if you need that
                            context,
                            FadeInRoute(
                              routeName: Home.route,
                              page: Home(),
                            ),
                          );
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                ))
            : mounth != 'Ramadan'
                ? Ramdancount()
                : firstrun
                    ? Center(child: CircularProgressIndicator())
                    : Dbhandler.instance.ramadanstatuscode != 200
                        ? Container(
                            height: double.infinity,
                            child: Image.asset('assets/images/error.jpg'),
                          )
                        : ListView(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                      top: 7,
                                      right: MediaQuery.of(context).size.width *
                                          0.01,
                                      bottom: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            Ramdan.day.toString() +
                                                ' ' +
                                                mounth,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      167, 85, 163, 1),
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          // Image.asset('assets/images/Group 240.png')
                                        ],
                                      ),
                                      Card(
                                        color: Color.fromRGBO(62, 194, 236, 1),
                                        child: Container(
                                          height: 50,
                                          //  width: ,
                                          child: Center(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                'Remaining time to breakfast',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: .5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.032),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.09),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      hours.toString() +
                                          'hour' +
                                          ':' +
                                          min.toString() +
                                          'minute',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(167, 85, 163, 1),
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Ramdanitem('Hadith Of The Day',
                                  'assets/images/Group400.png', Hadeth()),
                              Ramdanitem('Story Of The Day',
                                  'assets/images/quran.png', Sera()),
                              Ramdanitem('Dua’ Of The Day',
                                  'assets/images/duaa.png', Dua()),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.015),
                                    child: Text(
                                      ' How much you have fasted today',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(167, 85, 163, 1),
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                      ),
                                    ),
                                  ),
                                  Image.asset('assets/images/bal.png'),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(select1
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : color)),
                                          onPressed: () {
                                            setState(() {
                                              select1 = true;
                                              select2 = false;
                                              select3 = false;
                                              select4 = false;
                                            });
                                            Dbhandler.instance
                                                .ramdanstatus('no');
                                          },
                                          child: Text(
                                            'Didn’t fast',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(select2
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : color)),
                                          onPressed: () {
                                            setState(() {
                                              select1 = false;
                                              select2 = true;
                                              select3 = false;
                                              select4 = false;
                                            });
                                            Dbhandler.instance
                                                .ramdanstatus('thuhr');
                                          },
                                          child: Text(
                                            'Until Thuhr',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(select3
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : color)),
                                          onPressed: () {
                                            setState(() {
                                              select1 = false;
                                              select2 = false;
                                              select3 = true;
                                              select4 = false;
                                            });
                                            Dbhandler.instance
                                                .ramdanstatus('asr');
                                          },
                                          child: Text(
                                            'Until Asr',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(select4
                                                          ? Theme.of(context)
                                                              .accentColor
                                                          : color)),
                                          onPressed: () async {
                                            setState(() {
                                              select1 = false;
                                              select2 = false;
                                              select3 = false;
                                              select4 = true;
                                            });
                                            await Dbhandler.instance
                                                .ramdanstatus('maghrib');
                                          },
                                          child: Text(
                                            'Until Maghrib',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.015),
                                    child: Text(
                                      'Qur`an Tracker',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(167, 85, 163, 1),
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Image.asset('assets/images/moshaf.png'),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromRGBO(62, 194, 236, 1),
                                              )),
                                          onPressed: () {},
                                          child: Text(
                                            'Ayat',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromRGBO(62, 194, 236, 1),
                                              )),
                                          onPressed: () {},
                                          child: Text(
                                            'Suwar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromRGBO(62, 194, 236, 1),
                                              )),
                                          onPressed: () {},
                                          child: Text(
                                            'Ajza’`',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .accentColor,
                                                child: GestureDetector(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        if (vercecounter > 0)
                                                          vercecounter--;
                                                      });
                                                      Provider.of<Lanprovider>(
                                                              context,
                                                              listen: false)
                                                          .changecounter1(
                                                              vercecounter);
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            62, 194, 236, 1),
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                              context,
                                                              listen: true)
                                                          .counter1
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                //   minRadius: MediaQuery.of(context).size.width*0.05,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .accentColor,
                                                child: InkWell(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      vercecounter++;
                                                    });
                                                    Provider.of<Lanprovider>(
                                                            context,
                                                            listen: false)
                                                        .changecounter1(
                                                            vercecounter);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .accentColor,
                                                child: InkWell(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        if (surracounter > 0)
                                                          surracounter--;
                                                      });
                                                      Provider.of<Lanprovider>(
                                                              context,
                                                              listen: false)
                                                          .changecounter2(
                                                              surracounter);
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            62, 194, 236, 1),
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                              context,
                                                              listen: true)
                                                          .counter2
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .accentColor,
                                                //   minRadius: MediaQuery.of(context).size.width*0.05,

                                                child: InkWell(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      surracounter++;
                                                    });
                                                    Provider.of<Lanprovider>(
                                                            context,
                                                            listen: false)
                                                        .changecounter2(
                                                            surracounter);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        /*
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                          */
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .accentColor,
                                                  child: InkWell(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                      onTap: () async {
                                                        setState(() {
                                                          if (goz2counter > 0)
                                                            goz2counter--;
                                                        });
                                                        Provider.of<Lanprovider>(
                                                                context,
                                                                listen: false)
                                                            .changecounter3(
                                                                goz2counter);
                                                      }),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2),
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromRGBO(62,
                                                                194, 236, 1),
                                                        child: Text(
                                                          Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: true)
                                                              .counter3
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  )),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                child: Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .accentColor,
                                                      //   minRadius: MediaQuery.of(context).size.width*0.05,

                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            goz2counter++;
                                                          });
                                                          Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .changecounter3(
                                                                  goz2counter);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                                //  row
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    child: Text(
                                      'Daily cheak list',
                                      //  maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(167, 85, 163, 1),
                                            letterSpacing: .5,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Dialycheaklist(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.3)
                                    .add(EdgeInsets.symmetric(vertical: 10)),
                                child: loading
                                    ? Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            )),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Theme.of(context)
                                                        .accentColor)),
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });

                                          await Dbhandler.instance
                                              .quraantracker(
                                                  vercecounter.toString(),
                                                  surracounter.toString(),
                                                  goz2counter.toString());
                                          setState(() {
                                            loading = false;
                                          });
                                          if (Dbhandler.instance.counter ==
                                              200) {
                                            Dialogs.materialDialog(
                                                customView: Container(
                                                  child: Gift(
                                                    'Keep Moving Forward',
                                                    'دائمًا إلى الأمام',
                                                    'assets/images/Group 795.png',
                                                    Colors.white,
                                                    Color.fromRGBO(
                                                        255, 72, 115, 1),
                                                    Color.fromRGBO(
                                                        255, 72, 115, 1),
                                                    Color.fromRGBO(
                                                        255, 72, 115, 1),
                                                    Colors.white,
                                                    Color.fromRGBO(
                                                        255, 72, 115, 1),
                                                  ),
                                                ),
                                                titleStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontSize: 25),
                                                color: Colors.white,
                                                //    animation: 'assets/cong_example.json',
                                                context: context,
                                                actions: [
                                                  Container(
                                                    height: 40,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1),
                                                    child: IconsButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        await Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                Home.route);
                                                      },
                                                      text: 'Done',
                                                      color: Color.fromRGBO(
                                                          255, 72, 115, 1),
                                                      textStyle: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ]);
                                          } else {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )),
                              ),
                            ],
                          ),
      ),
    );
  }
}
