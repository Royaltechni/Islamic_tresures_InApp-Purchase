import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/widgets/gift.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import 'package:page_indicator/page_indicator.dart';

class Azkar extends StatefulWidget {
  static const String route = 'azkar';
  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;
  PageController c;
  bool loading;

  @override
  void initState() {
    super.initState();
    c = new PageController();
    loading = false;
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments as String;
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PageIndicatorContainer(
            length: 3,
            indicatorColor: Colors.grey[300],
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.07),
            indicatorSelectorColor: Theme.of(context).primaryColor,
            shape: IndicatorShape.roundRectangleShape(
                size: Size(30, 5), cornerSize: Size.square(20)),
            child: PageView(
              controller: c,
              children: [
                Center(
                  child: Container(
                    color: Colors.grey[100],
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).primaryColor,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    'Thikr after prayer',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'سبحان الله',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'Subhana Allah',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (counter1 < 33) {
                                    counter1++;
                                  }
                                });
                                if (counter1 == 33) {
                                  c.nextPage(
                                      duration: new Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
                                }
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  '$counter1',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (counter1 < 33) {
                                          counter1++;
                                        }
                                      });
                                      if (counter1 == 33) {
                                        c.nextPage(
                                            duration:
                                                new Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Icon(
                                        FontAwesomeIcons.handPointer,
                                        size: 30,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.grey[100],
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).primaryColor,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Center(
                                  child: Text(
                                    'Thikr after prayer ',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              ' الحمد لله',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'Alhamdulillah',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (counter2 < 33) {
                                    counter2++;
                                  }
                                });
                                if (counter2 == 33) {
                                  c.nextPage(
                                      duration: new Duration(milliseconds: 400),
                                      curve: Curves.easeIn);
                                }
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  '$counter2',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (counter2 < 33) {
                                          counter2++;
                                        }
                                      });
                                      if (counter2 == 33) {
                                        c.nextPage(
                                            duration:
                                                new Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Icon(
                                        FontAwesomeIcons.handPointer,
                                        size: 30,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.grey[100],
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).primaryColor,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Center(
                                  child: Text(
                                    'Thikr after prayer',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              ' الله اكبر',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'Allahu Akbar',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  if (counter3 < 33) {
                                    counter3++;
                                  }
                                });
                                if (counter3 == 33) {}
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  '$counter3',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        if (counter3 < 33) {
                                          counter3++;
                                        }
                                      });
                                      if (counter3 == 33) {}
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Icon(
                                        FontAwesomeIcons.handPointer,
                                        size: 30,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Container(
                              height: 40,
                              width: 140,
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
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .accentColor)),
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        await Dbhandler.instance
                                            .azkaraftersalah('read', id);
                                        setState(() {
                                          loading = false;
                                        });
                                        final audioplayer = AudioPlayer();
                                        await audioplayer.setAsset(
                                            'assets/audio/mixkit-achievement-bell-600.wav');
                                        audioplayer.play();
                                        Dialogs.materialDialog(
                                            customView: Container(
                                              child: Gift(
                                                'Masha’ Allah',
                                                'ماشاء الله',
                                                'assets/images/Group 804.png',
                                                Colors.white,
                                                Colors.white,
                                                Color.fromRGBO(255, 72, 115, 1),
                                                Colors.white,
                                                Colors.white,
                                                Color.fromRGBO(255, 72, 115, 1),
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
                                                width: 100,
                                                child: IconsButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  text: 'Done',
                                                  color: Color.fromRGBO(
                                                      255, 72, 115, 1),
                                                  textStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ]);
                                      },
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              width: 140,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Theme.of(context).accentColor)),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
