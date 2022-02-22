import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/Namesofallah.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/screens/azkar.dart';
import 'package:kidsapp/screens/login.dart';
import 'package:kidsapp/widgets/error.dart';
import 'package:kidsapp/widgets/gift.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

import 'cheaklogin.dart';

// ignore: must_be_immutable
class Salahev extends StatefulWidget {
  Color color;
  Color color1;
  Color color2;
  String text;
  String time;
  String id;
  Color color3;

  Salahev(this.text, this.time, this.color, this.color1, this.color2,
      this.color3, this.id);

  @override
  _SalahevState createState() => _SalahevState();
}

class _SalahevState extends State<Salahev> {
  bool a = false;
  bool s = false;
  bool d = false;
  bool circle1 = false;
  bool circle2 = false;
  bool done = false;
  bool loading;
  String sa;
  GlobalKey<ScaffoldState> scaffold;
  DateTime datetime = DateTime.now();
  AudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    loading = false;
    audioPlayer = AudioPlayer();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<Namesofallahprovider>(context, listen: false)
        .fetchvedio();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Networkprovider.cheak == false
              ? Container(
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'Check your network connection',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : Container(
                  height: double.infinity,
                  child: ListView(
                    //   shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          color: this.widget.color,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                //    mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 35,
                                      color: this.widget.color3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: this.widget.color,
                        height: 271,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.1,
                              right: 25,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      this.widget.text,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: this.widget.color2,
                                            letterSpacing: .5,
                                            fontSize: 28),
                                      ),
                                    ),
                                  ),
                                  Text(this.widget.time,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: this.widget.color1,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5,
                                            fontSize: 20),
                                      )),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -1,
                              left: 10,
                              child: Container(
                                  child: Image.asset(
                                      'assets/images/Group 77.png')),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment:
                            Provider.of<Lanprovider>(context, listen: false)
                                    .isenglish
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.02)
                              .add(EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.03)),
                          child: Text(
                              Provider.of<Lanprovider>(context, listen: false)
                                      .isenglish
                                  ? 'When did you pray?'
                                  : 'متى صليت ؟',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontSize: 20),
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                var format = DateFormat("HH:mm");
                                var ds = format.parse(this.widget.time);
                                var hour1 = format.parse(
                                    "${datetime.hour}:${datetime.minute}");
                                var str = ds.difference(hour1).toString();
                                List<String> parts = str.split(':');

                                if (ds.isAfter(hour1)) {
                                  Dialogs.materialDialog(
                                      customView: Container(
                                          child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            parts[0] +
                                                ':' +
                                                parts[1] +
                                                ' remaining for the prayer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      )),
                                      titleStyle: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 25),
                                      color: Colors.white,
                                      //    animation: 'assets/cong_example.json',
                                      context: context,
                                      actions: [
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1),
                                          child: IconsButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            text: 'Done',
                                            color:
                                                Color.fromRGBO(34, 196, 228, 1),
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ]);
                                } else {
                                  await Dbhandler.instance
                                      .salahevluate(this.widget.id, 'no', '0');
                                  if (Dbhandler.instance.cheaksalah == 200) {
                                    Dialogs.materialDialog(
                                        customView: Container(
                                          child: Gift(
                                            'Pray On Time',
                                            ' حافظ على الصلاة فى وقتها',
                                            'assets/images/Group 815.png',
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                            Color.fromRGBO(34, 196, 228, 1),
                                          ),
                                        ),
                                        titleStyle: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 25),
                                        color: Colors.white,
                                        //    animation: 'assets/cong_example.json',
                                        context: context,
                                        actions: [
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.1),
                                            child: IconsButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              text: 'Done',
                                              color: Color.fromRGBO(
                                                  34, 196, 228, 1),
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ]);
                                  } else {
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .islogin
                                        ? Dialogs.materialDialog(
                                            customView:
                                                Container(child: Eroorr()),
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
                                                          MediaQuery.of(context)
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
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    text: 'Done',
                                                    color: Color.fromRGBO(
                                                        255, 72, 115, 1),
                                                    textStyle: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ])
                                        : await showDialog(
                                            //  barrierDismissible: false, //
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  content: Cheaklogin());
                                            });
                                  }
                                }
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Mask Group 1.png'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: false)
                                              .isenglish
                                          ? 'I didn’t pray'
                                          : 'لم اصلى',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: (a)
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).accentColor,
                                            letterSpacing: .5,
                                            fontSize: 20),
                                      ))
                                ],
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                Dialogs.materialDialog(
                                    customView: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05),
                                            child: Text(
                                              Provider.of<Lanprovider>(context,
                                                          listen: false)
                                                      .isenglish
                                                  ? 'How did you pray?'
                                                  : 'كيف صليت ؟',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: GestureDetector(
                                                  onTap: () async {
                                                    var format =
                                                        DateFormat("HH:mm");
                                                    var ds = format.parse(
                                                        this.widget.time);
                                                    var hour1 = format.parse(
                                                        "${datetime.hour}:${datetime.minute}");
                                                    var str = ds
                                                        .difference(hour1)
                                                        .toString();
                                                    List<String> parts =
                                                        str.split(':');
                                                    if (ds.isAfter(hour1)) {
                                                      Dialogs.materialDialog(
                                                          customView: Container(
                                                              child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: Text(
                                                                parts[0] +
                                                                    ':' +
                                                                    parts[1] +
                                                                    ' remaining for the prayer',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          )),
                                                          titleStyle: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 25),
                                                          color: Colors.white,
                                                          //    animation: 'assets/cong_example.json',
                                                          context: context,
                                                          actions: [
                                                            Container(
                                                              height: 40,
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1),
                                                              child:
                                                                  IconsButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                text: 'Done',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        34,
                                                                        196,
                                                                        228,
                                                                        1),
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ]);
                                                    } else {
                                                      await Dbhandler.instance
                                                          .salahevluate(
                                                              this.widget.id,
                                                              'late group',
                                                              '0');
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200)
                                                        await audioPlayer.setAsset(
                                                            'assets/audio/mixkit-achievement-bell-600.wav');
                                                      audioPlayer.play();
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200) {
                                                        Dialogs.materialDialog(
                                                            customView:
                                                                Container(
                                                              child: Gift(
                                                                'Pray On Time',
                                                                'حافظ على الصلاة فى وقتها',
                                                                'assets/images/Group 804.png',
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Colors.grey,
                                                                Colors.grey,
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                              ),
                                                            ),
                                                            titleStyle: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontSize: 25),
                                                            color: Colors.white,
                                                            //    animation: 'assets/cong_example.json',
                                                            context: context,
                                                            actions: [
                                                              Container(
                                                                height: 40,
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.1),
                                                                child:
                                                                    IconsButton(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Azkar
                                                                            .route,
                                                                        arguments: this
                                                                            .widget
                                                                            .id);
                                                                  },
                                                                  text: 'Done',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          34,
                                                                          196,
                                                                          228,
                                                                          1),
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ]);
                                                      } else {
                                                        if (ds
                                                            .isBefore(hour1)) {
                                                          Provider.of<Lanprovider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .islogin
                                                              ? Dialogs
                                                                  .materialDialog(
                                                                      customView: Container(
                                                                          child:
                                                                              Eroorr()),
                                                                      titleStyle: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .accentColor,
                                                                          fontSize:
                                                                              25),
                                                                      color: Colors
                                                                          .white,
                                                                      //    animation: 'assets/cong_example.json',
                                                                      context:
                                                                          context,
                                                                      actions: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                MediaQuery.of(context).size.width * 0.1),
                                                                        child:
                                                                            IconsButton(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          text:
                                                                              'Done',
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              72,
                                                                              115,
                                                                              1),
                                                                          textStyle:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ])
                                                              : await showDialog(
                                                                  //  barrierDismissible: false, //
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15)),
                                                                        content:
                                                                            Cheaklogin());
                                                                  });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(2),
                                                    child: CircleAvatar(
                                                      radius: 60,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      child: Image.asset(
                                                          'assets/images/Group 705.png'),
                                                    ),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: GestureDetector(
                                                  onTap: () async {
                                                    var format =
                                                        DateFormat("HH:mm");
                                                    var ds = format.parse(
                                                        this.widget.time);
                                                    var hour1 = format.parse(
                                                        "${datetime.hour}:${datetime.minute}");
                                                    var str = ds
                                                        .difference(hour1)
                                                        .toString();
                                                    List<String> parts =
                                                        str.split(':');

                                                    if (ds.isAfter(hour1)) {
                                                      Dialogs.materialDialog(
                                                          customView: Container(
                                                              child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: Text(
                                                                parts[0] +
                                                                    ':' +
                                                                    parts[1] +
                                                                    ' remaining for the prayer',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          )),
                                                          titleStyle: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 25),
                                                          color: Colors.white,
                                                          //    animation: 'assets/cong_example.json',
                                                          context: context,
                                                          actions: [
                                                            Container(
                                                              height: 40,
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1),
                                                              child:
                                                                  IconsButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                text: 'Done',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        34,
                                                                        196,
                                                                        228,
                                                                        1),
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ]);
                                                    } else {
                                                      await Dbhandler.instance
                                                          .salahevluate(
                                                              this.widget.id,
                                                              'late single',
                                                              '0');
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200)
                                                        await audioPlayer.setAsset(
                                                            'assets/audio/mixkit-achievement-bell-600.wav');
                                                      audioPlayer.play();
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200) {
                                                        Dialogs.materialDialog(
                                                            customView:
                                                                Container(
                                                              child: Gift(
                                                                'Pray On Time',
                                                                'حافظ على الصلاة فى وقتها',
                                                                'assets/images/Group 804.png',
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Colors.grey,
                                                                Colors.grey,
                                                                Colors.grey,
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                              ),
                                                            ),
                                                            titleStyle: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontSize: 25),
                                                            color: Colors.white,
                                                            //    animation: 'assets/cong_example.json',
                                                            context: context,
                                                            actions: [
                                                              Container(
                                                                height: 40,
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.1),
                                                                child:
                                                                    IconsButton(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Azkar
                                                                            .route,
                                                                        arguments: this
                                                                            .widget
                                                                            .id);
                                                                  },
                                                                  text: 'Done',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          72,
                                                                          115,
                                                                          1),
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ]);
                                                      } else {
                                                        if (ds
                                                            .isBefore(hour1)) {
                                                          Provider.of<Lanprovider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .islogin
                                                              ? Dialogs
                                                                  .materialDialog(
                                                                      customView: Container(
                                                                          child:
                                                                              Eroorr()),
                                                                      titleStyle: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .accentColor,
                                                                          fontSize:
                                                                              25),
                                                                      color: Colors
                                                                          .white,
                                                                      //    animation: 'assets/cong_example.json',
                                                                      context:
                                                                          context,
                                                                      actions: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                MediaQuery.of(context).size.width * 0.1),
                                                                        child:
                                                                            IconsButton(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          text:
                                                                              'Done',
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              72,
                                                                              115,
                                                                              1),
                                                                          textStyle:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ])
                                                              : await showDialog(
                                                                  //  barrierDismissible: false, //
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15)),
                                                                        content:
                                                                            Cheaklogin());
                                                                  });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      radius: 60,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      child: Image.asset(
                                                          'assets/images/Group 709.png'),
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    titleStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 25),
                                    color: Colors.white,
                                    //    animation: 'assets/cong_example.json',
                                    context: context,
                                    actions: [
                                      Container(
                                        height: 40,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: IconsButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: 'cancel',
                                          color: Theme.of(context).accentColor,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ]);
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Group 2386.png'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: false)
                                              .isenglish
                                          ? 'Late'
                                          : 'متأخراً',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: (s)
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).accentColor,
                                            letterSpacing: .5,
                                            fontSize: 20),
                                      ))
                                ],
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                Dialogs.materialDialog(
                                    customView: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05),
                                            child: Text(
                                              Provider.of<Lanprovider>(context,
                                                          listen: false)
                                                      .isenglish
                                                  ? 'How did you pray?'
                                                  : 'كيف صليت ؟',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: GestureDetector(
                                                  onTap: () async {
                                                    var format =
                                                        DateFormat("HH:mm");
                                                    var ds = format.parse(
                                                        this.widget.time);
                                                    var hour1 = format.parse(
                                                        "${datetime.hour}:${datetime.minute}");
                                                    var str = ds
                                                        .difference(hour1)
                                                        .toString();
                                                    List<String> parts =
                                                        str.split(':');
                                                    if (ds.isAfter(hour1)) {
                                                      Dialogs.materialDialog(
                                                          customView: Container(
                                                              child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: Text(
                                                                parts[0] +
                                                                    ':' +
                                                                    parts[1] +
                                                                    ' remaining for the prayer',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          )),
                                                          titleStyle: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 25),
                                                          color: Colors.white,
                                                          //    animation: 'assets/cong_example.json',
                                                          context: context,
                                                          actions: [
                                                            Container(
                                                              height: 40,
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1),
                                                              child:
                                                                  IconsButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                text: 'Done',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        34,
                                                                        196,
                                                                        228,
                                                                        1),
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ]);
                                                    } else {
                                                      await Dbhandler.instance
                                                          .salahevluate(
                                                              this.widget.id,
                                                              'ontime group',
                                                              '0');
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200)
                                                        await audioPlayer.setAsset(
                                                            'assets/audio/mixkit-achievement-bell-600.wav');
                                                      audioPlayer.play();
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200) {
                                                        Dialogs.materialDialog(
                                                            customView:
                                                                Container(
                                                              child: Gift(
                                                                'Masha’ Allah',
                                                                'ماشاء الله',
                                                                'assets/images/Group 795.png',
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Colors.grey,
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                              ),
                                                            ),
                                                            titleStyle: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontSize: 25),
                                                            color: Colors.white,
                                                            //    animation: 'assets/cong_example.json',
                                                            context: context,
                                                            actions: [
                                                              Container(
                                                                height: 40,
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.1),
                                                                child:
                                                                    IconsButton(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Azkar
                                                                            .route,
                                                                        arguments: this
                                                                            .widget
                                                                            .id);
                                                                  },
                                                                  text: 'Done',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          72,
                                                                          115,
                                                                          1),
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ]);
                                                      } else {
                                                        if (ds
                                                            .isBefore(hour1)) {
                                                          Provider.of<Lanprovider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .islogin
                                                              ? Dialogs
                                                                  .materialDialog(
                                                                      customView: Container(
                                                                          child:
                                                                              Eroorr()),
                                                                      titleStyle: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .accentColor,
                                                                          fontSize:
                                                                              25),
                                                                      color: Colors
                                                                          .white,
                                                                      //    animation: 'assets/cong_example.json',
                                                                      context:
                                                                          context,
                                                                      actions: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                MediaQuery.of(context).size.width * 0.1),
                                                                        child:
                                                                            IconsButton(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          text:
                                                                              'Done',
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              72,
                                                                              115,
                                                                              1),
                                                                          textStyle:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ])
                                                              : await showDialog(
                                                                  //  barrierDismissible: false, //
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15)),
                                                                        content:
                                                                            Cheaklogin());
                                                                  });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(2),
                                                    child: CircleAvatar(
                                                      radius: 60,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      child: Image.asset(
                                                          'assets/images/Group 705.png'),
                                                    ),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: GestureDetector(
                                                  onTap: () async {
                                                    var format =
                                                        DateFormat("HH:mm");
                                                    var ds = format.parse(
                                                        this.widget.time);
                                                    var hour1 = format.parse(
                                                        "${datetime.hour}:${datetime.minute}");
                                                    var str = ds
                                                        .difference(hour1)
                                                        .toString();
                                                    List<String> parts =
                                                        str.split(':');
                                                    if (ds.isAfter(hour1)) {
                                                      Dialogs.materialDialog(
                                                          customView: Container(
                                                              child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: Text(
                                                                parts[0] +
                                                                    ':' +
                                                                    parts[1] +
                                                                    ' remaining for the prayer',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          )),
                                                          titleStyle: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              fontSize: 25),
                                                          color: Colors.white,
                                                          //    animation: 'assets/cong_example.json',
                                                          context: context,
                                                          actions: [
                                                            Container(
                                                              height: 40,
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1),
                                                              child:
                                                                  IconsButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                text: 'Done',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        34,
                                                                        196,
                                                                        228,
                                                                        1),
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ]);
                                                    } else {
                                                      await Dbhandler.instance
                                                          .salahevluate(
                                                              this.widget.id,
                                                              'ontime single',
                                                              '0');
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200)
                                                        await audioPlayer.setAsset(
                                                            'assets/audio/mixkit-achievement-bell-600.wav');
                                                      audioPlayer.play();
                                                      if (Dbhandler.instance
                                                              .cheaksalah ==
                                                          200) {
                                                        Dialogs.materialDialog(
                                                            customView:
                                                                Container(
                                                              child: Gift(
                                                                'Masha’ Allah',
                                                                'ماشاء الله',
                                                                'assets/images/Group 795.png',
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                                Colors.grey,
                                                                Colors.grey,
                                                                Color.fromRGBO(
                                                                    255,
                                                                    72,
                                                                    115,
                                                                    1),
                                                              ),
                                                            ),
                                                            titleStyle: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontSize: 25),
                                                            color: Colors.white,
                                                            //    animation: 'assets/cong_example.json',
                                                            context: context,
                                                            actions: [
                                                              Container(
                                                                height: 40,
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.1),
                                                                child:
                                                                    IconsButton(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Azkar
                                                                            .route,
                                                                        arguments: this
                                                                            .widget
                                                                            .id);
                                                                  },
                                                                  text: 'Done',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          72,
                                                                          115,
                                                                          1),
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ]);
                                                      } else {
                                                        if (ds
                                                            .isBefore(hour1)) {
                                                          Provider.of<Lanprovider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .islogin
                                                              ? Dialogs
                                                                  .materialDialog(
                                                                      customView: Container(
                                                                          child:
                                                                              Eroorr()),
                                                                      titleStyle: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .accentColor,
                                                                          fontSize:
                                                                              25),
                                                                      color: Colors
                                                                          .white,
                                                                      //    animation: 'assets/cong_example.json',
                                                                      context:
                                                                          context,
                                                                      actions: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                MediaQuery.of(context).size.width * 0.1),
                                                                        child:
                                                                            IconsButton(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          text:
                                                                              'Done',
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              72,
                                                                              115,
                                                                              1),
                                                                          textStyle:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ])
                                                              : await showDialog(
                                                                  //  barrierDismissible: false, //
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15)),
                                                                        content:
                                                                            Cheaklogin());
                                                                  });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      radius: 60,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      child: Image.asset(
                                                          'assets/images/Group 709.png'),
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    titleStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 25),
                                    color: Colors.white,
                                    //    animation: 'assets/cong_example.json',
                                    context: context,
                                    actions: [
                                      Container(
                                        height: 40,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: IconsButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: 'cancel',
                                          color: Theme.of(context).accentColor,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ]);
                              },
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Mask Group 3.png'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: false)
                                              .isenglish
                                          ? 'On Time'
                                          : 'فى وقتها',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: (d)
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).accentColor,
                                            letterSpacing: .5,
                                            fontSize: 20),
                                      ))
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                )),
    );
  }
}
