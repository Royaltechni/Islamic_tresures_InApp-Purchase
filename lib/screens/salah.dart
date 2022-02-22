import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/Athan.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/Asr.dart';
import 'package:kidsapp/screens/elfajar.dart';
import 'package:kidsapp/screens/isha.dart';
import 'package:kidsapp/screens/maghrib.dart';
import 'package:kidsapp/screens/thuhr.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/widgets/CheckSubscription.dart';
import 'package:kidsapp/widgets/cheaklogin.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Salah extends StatefulWidget {
  static const String route = '/Salah';

  @override
  _SalahState createState() => _SalahState();
}

class _SalahState extends State<Salah> {
  String salah = 'null';
  int hour;
  var hour1;
  bool firstrun;
  var duhr;
  var asr;
  var maghrib;
  var isha;
  var fajr;
  String time = 'null';
  AudioPlayer player;
  var mounth = new HijriCalendar.now().getLongMonthName().toString();
  var day = new HijriCalendar.now().getDayName().toString();
  var year = new HijriCalendar.now().hYear;
  DateTime datetime = DateTime.now();

  @override
  void initState() {
    super.initState();
    firstrun = true;

    var format = DateFormat("HH:mm");
    hour1 = format.parse("${datetime.hour}:${datetime.minute}");
  }

  getnextprayer() {
    var format = DateFormat("HH:mm");
    hour1 = format.parse("${datetime.hour}:${datetime.minute}");

    maghrib = format.parse(Provider.of<Athanprovider>(context, listen: false)
        .time
        .data
        .timings
        .maghrib);
    isha = format.parse(Provider.of<Athanprovider>(context, listen: false)
        .time
        .data
        .timings
        .isha);
    fajr = format.parse(Provider.of<Athanprovider>(context, listen: false)
        .time
        .data
        .timings
        .fajr);
    duhr = format.parse(Provider.of<Athanprovider>(context, listen: false)
        .time
        .data
        .timings
        .dhuhr);
    asr = format.parse(Provider.of<Athanprovider>(context, listen: false)
        .time
        .data
        .timings
        .asr);

    if (hour1.isAfter(isha) || hour1.isBefore(fajr)) {
      salah = Provider.of<Lanprovider>(context, listen: false).isenglish
          ? 'Fajr'
          : 'الفجر';

      time = Provider.of<Athanprovider>(context, listen: false)
          .time
          .data
          .timings
          .fajr;
    }
    if (hour1.isAfter(fajr) && hour1.isBefore(duhr)) {
      salah = Provider.of<Lanprovider>(context, listen: false).isenglish
          ? 'Thuhr'
          : 'الظهر';

      time = Provider.of<Athanprovider>(context, listen: false)
          .time
          .data
          .timings
          .dhuhr;
    }
    if (hour1.isAfter(duhr) && hour1.isBefore(asr)) {
      time = Provider.of<Athanprovider>(context, listen: false)
          .time
          .data
          .timings
          .asr;

      salah = Provider.of<Lanprovider>(context, listen: false).isenglish
          ? 'Asr'
          : 'العصر';
    }
    if (hour1.isAfter(asr) && hour1.isBefore(maghrib)) {
      salah = Provider.of<Lanprovider>(context, listen: false).isenglish
          ? 'Maghrib'
          : 'المغرب';

      time = Provider.of<Athanprovider>(context, listen: false)
          .time
          .data
          .timings
          .maghrib;
    }
    if (hour1.isAfter(maghrib) && hour1.isBefore(isha)) {
      time = Provider.of<Athanprovider>(context, listen: false)
          .time
          .data
          .timings
          .isha;

      salah = Provider.of<Lanprovider>(context, listen: false).isenglish
          ? 'isha`'
          : 'العشاء';
    }
    return salah + ' ' + time;
  }

  Future<void> _pullRefresh() async {
    //await Future.delayed(Duration(seconds: 2));

    Home.homeindex = 1;

    await Navigator.push(
      // or pushReplacement, if you need that
      context,
      FadeInRoute(
        routeName: Home.route,
        page: Home(),
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Userprovider>(context, listen: false).getUserLocation();
    Provider.of<Networkprovider>(context, listen: false).cheaknetwork();

    while (Dbhandler.instance.athancheak != 200) {
      await Provider.of<Athanprovider>(context, listen: false).fetchtimes();
    }

    getnextprayer();
    setState(() {
      firstrun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: SafeArea(
        child: Scaffold(
          //  backgroundColor: Colors.white,
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
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).accentColor)),
                          onPressed: () async {
                            _pullRefresh();
                          },
                          child: Text(
                            'Refresh',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ))
              : Container(
                  height: double.infinity,
                  child: firstrun
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Dbhandler.instance.athancheak != 200
                          ? Container(
                              height: double.infinity,
                              child: Image.asset('assets/images/error.jpg'),
                            )
                          : ListView(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 15,
                                    bottom: 2,
                                    left: MediaQuery.of(context).size.width *
                                        0.03),
                                child: Container(
                                  //  margin: EdgeInsets.only(right: 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        //  margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .isenglish
                                              ? 'Next Prayer'
                                              : 'الصلاة التالية',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    204, 14, 116, 1),
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: .5,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ': ',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color:
                                                  Color.fromRGBO(60, 60, 67, 1),
                                              letterSpacing: .5,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Text(
                                        getnextprayer(),
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(60, 60, 67, 1),
                                              letterSpacing: .5,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.03,
                                      top: 10,
                                      bottom: 2,
                                      left: MediaQuery.of(context).size.width *
                                          0.03),
                                  child: Text(
                                    '$day ,$mounth,$year',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(60, 60, 67, 1)),
                                  )),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          //added by youssef
                                          if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                            showDialog(
                                              //  barrierDismissible: false, //
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                      content: CheckSubscription());
                                                });
                                            return;
                                          }
                                          !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              : Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Elfajar(),
                                                  ),
                                                );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 176,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/fajr.jpeg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 10,
                                                  top: 2,
                                                  child: Container(
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .isenglish
                                                          ? 'Fajr'
                                                          : 'الفجر',
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: .5,
                                                            fontSize: 28),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 8,
                                                  child: Container(
                                                      child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 10,
                                                  )),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 50,
                                                  child: Text(
                                                      Provider.of<Athanprovider>(
                                                              context)
                                                          .time
                                                          .data
                                                          .timings
                                                          .fajr,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: .5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: ()async {
                                          //added by youssef
                                          if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                            showDialog(
                                              //  barrierDismissible: false, //
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                      content: CheckSubscription());
                                                });
                                            return;
                                          }
                                               !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              :
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration:
                                                  Duration(milliseconds: 400),
                                              type: PageTransitionType.fade,
                                              child: Thuhr(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 176,
                                          //  color: Color.fromARGB(239, 239, 149, 1),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Container(
                                            color: Colors.yellow.shade400,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 10,
                                                  top: 2,
                                                  child: Container(
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .isenglish
                                                          ? 'Thuhr'
                                                          : 'الظهر',
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            letterSpacing: .5,
                                                            fontSize: 28),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 7,
                                                  child: Container(
                                                      child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.yellow[200],
                                                    radius: 10,
                                                  )),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 50,
                                                  child: Text(
                                                      Provider.of<Athanprovider>(
                                                              context)
                                                          .time
                                                          .data
                                                          .timings
                                                          .dhuhr,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors
                                                                .grey[700],
                                                            letterSpacing: .5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      )),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  child: Container(
                                                      child: Image.asset(
                                                          'assets/images/Group 72.png')),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: ()async {
                                          //added by youssef
                                          if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                            showDialog(
                                              //  barrierDismissible: false, //
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                      content: CheckSubscription());
                                                });
                                            return;
                                          }
                                               !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              :
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration:
                                                  Duration(milliseconds: 400),
                                              type: PageTransitionType.fade,
                                              child: Asr(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 176,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Container(
                                            color: Colors.yellow.shade600,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 10,
                                                  top: 2,
                                                  child: Container(
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .isenglish
                                                          ? 'Asr'
                                                          : 'العصر',
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            letterSpacing: .5,
                                                            fontSize: 28),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 5,
                                                  child: Container(
                                                      child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .yellowAccent[400],
                                                    radius: 18,
                                                  )),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 50,
                                                  child: Text(
                                                      Provider.of<Athanprovider>(
                                                              context)
                                                          .time
                                                          .data
                                                          .timings
                                                          .asr,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors
                                                                .grey[700],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: .5,
                                                            fontSize: 14),
                                                      )),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  bottom: 0,
                                                  child: Container(
                                                      child: Image.asset(
                                                          'assets/images/Group 72.png')),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: ()async {
                                          //added by youssef
                                          if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                            showDialog(
                                              //  barrierDismissible: false, //
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                      content: CheckSubscription());
                                                });
                                            return;
                                          }
                                               !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              :
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration:
                                                  Duration(milliseconds: 400),
                                              type: PageTransitionType.fade,
                                              child: Maghrib(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 176,
                                          //  color: Color.fromARGB(239, 239, 149, 1),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/maghrib.jpeg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 10,
                                                  top: 2,
                                                  child: Container(
                                                    child: Text(
                                                      Provider.of<Lanprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .isenglish
                                                          ? 'Maghrib'
                                                          : 'المغرب',
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: .5,
                                                            fontSize: 28),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: Container(
                                                      child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 8,
                                                  )),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 50,
                                                  child: Text(
                                                      Provider.of<Athanprovider>(
                                                              context)
                                                          .time
                                                          .data
                                                          .timings
                                                          .maghrib,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: .5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async{
                                      //added by youssef
                                      if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                        showDialog(
                                          //  barrierDismissible: false, //
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                                  content: CheckSubscription());
                                            });
                                        return;
                                      }
                                           !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              :
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 400),
                                          type: PageTransitionType.fade,
                                          child: Isha(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      height: 176,
                                      //  color: Color.fromARGB(239, 239, 149, 1),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 3)),
                                      child: Container(
                                        color: Colors.black,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Positioned(
                                              left: 10,
                                              top: 2,
                                              child: Container(
                                                child: Text(
                                                  Provider.of<Lanprovider>(
                                                              context,
                                                              listen: false)
                                                          .isenglish
                                                      ? 'Isha’'
                                                      : 'العشاء',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: .5,
                                                        fontSize: 28),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 6,
                                              child: Container(
                                                  child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 15,
                                              )),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 50,
                                              child: Text(
                                                  Provider.of<Athanprovider>(
                                                          context)
                                                      .time
                                                      .data
                                                      .timings
                                                      .isha,
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: .5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  )),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Container(
                                                  child: Image.asset(
                                                      'assets/images/Group 72.png')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                ),
        ),
      ),
    );
  }
}
