//import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';

import 'package:kidsapp/providers/quraanprovider.dart';

import 'package:kidsapp/widgets/allrecorddialog.dart';

import 'package:kidsapp/widgets/record.dart';
import 'package:kidsapp/widgets/Controlsbuttons.dart';

import 'package:kidsapp/widgets/sourarecord.dart';

import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'dialyhadith.dart';

class Soura extends StatefulWidget {
  static const String route = '/Soura';
  static String souranum;
  static String juznum;
  static String souraname;
  static bool isrecorded;
  @override
  _SouraState createState() => _SouraState();
}

class _SouraState extends State<Soura> {
  bool checkBoxValue = false;
  bool firstrun;
  List<int> audios = [];
  List<String> audioss = [];
  List<ObjectClass> demoData;
  // AudioPlayer advancedPlayer;
  AudioPlayer player2;
  //AudioPlayer player3;
  bool play;
  Color textcolor1 = Colors.black;
  Color textcolor2 = Colors.blue[600];
  //Verses played;
  bool ayaplayed;
  List<double> speed = [1, 0.5, 1.5];
  bool playlist;
  ScrollController _scrollController = new ScrollController();
  int j;
  int s = 0;
  bool finsh;
  dynamic postion;
  int k;
  bool fromplaylist;
  int juz;
  List<int> ayasaved = [];
  List<dynamic> list = [];
  String ayaaudio;
  int listleangh = 10;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // advancedPlayer = AudioPlayer();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    List<dynamic> arg =
        ModalRoute.of(context).settings.arguments as List<dynamic>;
    demoData = List.generate(300, (i) {
      return ObjectClass(
        checked: false,
        playlist: false,
      );
    });
    // await Provider.of<Quraanprovider>(context, listen: false).fetchayat(arg[0]);
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchayat(arg[0], arg.last);
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchayacheak(arg[0]);

    await Provider.of<Quraanprovider>(context, listen: false).fetchsourarecord(
        arg[1],
        Provider.of<Quraanprovider>(context, listen: false)
            .sour
            .data[arg[0] - 1]
            .number);
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchfavouritesour(
            arg[1],
            Provider.of<Quraanprovider>(context, listen: false)
                .sour
                .data[arg[0] - 1]
                .number);
    if (Provider.of<Lanprovider>(context, listen: false).islogin) {
      if (Dbhandler.instance.sourastatuscode == 200) {
        Soura.isrecorded = Provider.of<Quraanprovider>(context, listen: false)
            .sourarecord
            .isFound;

        for (int i = 0;
            i <
                Provider.of<Quraanprovider>(context, listen: false)
                    .ayacheak
                    .result
                    .length;
            i++) {
          ayasaved.add(Provider.of<Quraanprovider>(context, listen: false)
              .ayacheak
              .result[i]
              .numberOfVerse);
          int b = ayasaved.elementAt(i);
          demoData[b - 1].checked = true;
        }
      }
    }

    if (!mounted) return;
    setState(() {
      firstrun = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player2 = AudioPlayer();
    // player3 = AudioPlayer();
    finsh = false;
    playlist = false;
    firstrun = true;
    play = false;
    ayaplayed = false;
    fromplaylist = false;
    AudioRecorder.dialy = false;
    Dialyhadith.isrecorded = false;
  }

  void stop() async {
    await player2.stop();
    setState(() {
      ayaplayed = false;
    });
  }

  @override
  void dispose() {
    // player2.dispose();
    player2.dispose();
    _scrollController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    // AudioRecorder.dialy = false;
    Navigator.of(context).pop();
  }

  Future<bool> _onWillPopup() async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> arg =
        ModalRoute.of(context).settings.arguments as List<dynamic>;
    print(arg[0]);
    print(arg[1]);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: 194,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      margin: EdgeInsets.all(15),
                                      child: Text(
                                          Provider.of<Quraanprovider>(context)
                                                  .sour
                                                  .data[arg[0] - 1]
                                                  .englishName +
                                              '-' +
                                              Provider.of<Quraanprovider>(
                                                      context)
                                                  .sour
                                                  .data[arg[0] - 1]
                                                  .name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ))),
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        Provider.of<Quraanprovider>(context,
                                                    listen: false)
                                                .quranfavourite
                                                .result =
                                            !Provider.of<Quraanprovider>(
                                                    context,
                                                    listen: false)
                                                .quranfavourite
                                                .result;
                                      });
                                      Dbhandler.instance.quraanfavourite(
                                          Provider.of<Quraanprovider>(context,
                                                  listen: false)
                                              .sour
                                              .data[arg[0] - 1]
                                              .number
                                              .toString(),
                                          arg[1].toString());
                                    },
                                    child: firstrun
                                        ? Container()
                                        : Dbhandler.instance.sourastatuscode !=
                                                200
                                            ? Container(
                                                height: double.infinity,
                                                child: Image.asset(
                                                    'assets/images/error.jpg'),
                                              )
                                            : Provider.of<Lanprovider>(context,
                                                        listen: false)
                                                    .islogin
                                                ? Provider.of<Quraanprovider>(
                                                            context,
                                                            listen: false)
                                                        .quranfavourite
                                                        .result
                                                    ? Icon(
                                                        Icons.favorite,
                                                        size: 35,
                                                        color: Colors.white,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        size: 35,
                                                        color: Colors.white,
                                                      )
                                                : Container())
                              ],
                            )),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Center(
                                        child: Text(
                                      audios.isNotEmpty
                                          ? 'Verse ' +
                                              (audios[0]).toString() +
                                              ' - ' +
                                              audios.last.toString()
                                          : 'PlayList',
                                      style: GoogleFonts.roboto(fontSize: 16),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (audios.isNotEmpty) {
                                      setState(() {
                                        playlist = !playlist;
                                        ayaplayed = true;
                                        play = true;
                                        fromplaylist = true;
                                      });

                                      for (int i = audios.first - 1;
                                          i < audios.last;
                                          i++) {
                                        await Provider.of<Quraanprovider>(
                                                context,
                                                listen: false)
                                            .fetchayaaudio(
                                                arg[1], arg[0], i + 1);
                                        audioss.add(Provider.of<Quraanprovider>(
                                                context,
                                                listen: false)
                                            .ayaaudio
                                            .audio);
                                      }
                                    

                                      audioss = audioss.toSet().toList();
                                      await player2.setAudioSource(
                                        ConcatenatingAudioSource(
                                          children: [
                                            for (var i in audioss)
                                              AudioSource.uri(Uri.parse(i)),
                                          ],
                                        ),
                                        // Playback will be prepared to start from track1.mp3
                                        initialIndex: 0,
                                      );

                                      await player2.play();
                                      // audioss.clear();

                                      setState(() {
                                        playlist = false;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    playlist
                                        ? FontAwesomeIcons.pauseCircle
                                        : FontAwesomeIcons.playCircle,
                                    color: audios.isEmpty
                                        ? Colors.white
                                        : Colors.yellow,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        firstrun
                            ? Container()
                            : Dbhandler.instance.sourastatuscode != 200
                                ? Container(
                                    height: double.infinity,
                                    child:
                                        Image.asset('assets/images/error.jpg'),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Sourarecord(
                                            juzid: arg[1],
                                            souraid:
                                                Provider.of<Quraanprovider>(
                                                        context)
                                                    .sour
                                                    .data[arg[0] - 1]
                                                    .number,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                      ],
                    ),
                  ),
                  Networkprovider.cheak == false
                      ? Container(
                          //   height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text(
                                'Check your network connection',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      : firstrun
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.3),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Dbhandler.instance.sourastatuscode != 200
                              ? Container(
                                  height: double.infinity,
                                  child: Image.asset('assets/images/error.jpg'),
                                )
                              : Expanded(
                                  child: Container(
                                    padding: play
                                        ? EdgeInsets.only(bottom: 160)
                                        : EdgeInsets.only(bottom: 0),
                                    color: Colors.white,
                                    child: firstrun
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Dbhandler.instance.sourastatuscode !=
                                                200
                                            ? Container(
                                                height: double.infinity,
                                                child: Image.asset(
                                                    'assets/images/error.jpg'),
                                              )
                                            : ListView(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      'بسم الله الرحمن الرحيم',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.amiri(
                                                        textStyle: TextStyle(
                                                            letterSpacing: .5,
                                                            fontSize: 22),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Divider(
                                                    thickness: 0.5,
                                                  ),
                                                  ListView.builder(
                                                      controller:
                                                          _scrollController,
                                                      shrinkWrap: true,
                                                      itemCount: arg[3],
                                                      itemBuilder:
                                                          (context, index) {
                                                        Soura.juznum =
                                                            arg[1].toString();
                                                        Soura
                                                            .souraname = Provider
                                                                .of<Quraanprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .sour
                                                            .data[arg[0] - 1]
                                                            .name;
                                                        Soura
                                                            .souranum = Provider
                                                                .of<Quraanprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .sour
                                                            .data[arg[0] - 1]
                                                            .number
                                                            .toString();
                                                        if (arg[2] == 0) {
                                                          index += arg[2];
                                                        }
                                                        else{
                                                           index += arg[2]-1;
                                                        }

                                                        //index = arg[2];
                                                        return Center(
                                                            child:
                                                                GestureDetector(
                                                          onDoubleTap:
                                                              () async {
                                                            setState(() {
                                                              demoData[index]
                                                                  .textcolor1 = Theme
                                                                      .of(context)
                                                                  .primaryColor;
                                                              for (int j = 0;
                                                                  j < index;
                                                                  j++) {
                                                                demoData[j]
                                                                        .textcolor1 =
                                                                    Colors
                                                                        .black;
                                                              }
                                                              ayaplayed = true;
                                                              play = true;
                                                              audios.clear();
                                                            });
                                                            /*
                                                            final b = Provider.of<
                                                                            Quraanprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .sour
                                                                    .data[
                                                                        arg[0] -
                                                                            1]
                                                                    .number *
                                                                1000;
                                                            final c =
                                                                b.toString();
                                                            if (c.length == 4) {
                                                              ayaaudio = '00' +
                                                                  (b + index + 1)
                                                                      .toString();
                                                            }
                                                            if (c.length == 5) {
                                                              ayaaudio = '0' +
                                                                  (b + index + 1)
                                                                      .toString();
                                                            }
                                                            if (c.length == 6) {
                                                              ayaaudio = (b +
                                                                      index +
                                                                      1)
                                                                  .toString();
                                                            }
                                                            print(ayaaudio);
*/
                                                            await Provider.of<
                                                                        Quraanprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .fetchayaaudio(
                                                                    arg[1],
                                                                    arg[0],
                                                                    index + 1);
                                                            print(Provider.of<
                                                                        Quraanprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .ayaaudio
                                                                .audio);
                                                            try {
                                                              await player2
                                                                  .setUrl(
                                                                (Provider.of<
                                                                            Quraanprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .ayaaudio
                                                                    .audio),
                                                              );
                                                              await player2
                                                                  .play();
                                                            } catch (eroor) {
                                                              print(eroor);
                                                            }
                                                          },
                                                          onTap: () async {
                                                            setState(() {
                                                              play = false;
                                                              player2.stop();
                                                              demoData[index]
                                                                      .textcolor1 =
                                                                  Colors.black;
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: play
                                                                        ? 22
                                                                        : 1,
                                                                    left: 2,
                                                                    right: 5),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 8,
                                                                        child: Container(
                                                                            constraints: BoxConstraints(maxHeight: double.infinity, maxWidth: double.infinity),
                                                                            child: Column(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 10),
                                                                                  child: Text(
                                                                                    Provider.of<Quraanprovider>(context, listen: false).ayah.data.verses[index].text.arab,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.amiri(
                                                                                      textStyle: TextStyle(color: demoData[index].textcolor1, letterSpacing: .5, fontSize: 22),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  child: Text(
                                                                                    Provider.of<Quraanprovider>(context, listen: false).ayah.data.verses[index].text.transliteration.en,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.amiri(
                                                                                      textStyle: TextStyle(color: demoData[index].textcolor1, letterSpacing: .5, fontSize: 22),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  child: Text(
                                                                                    Provider.of<Quraanprovider>(context, listen: false).ayah.data.verses[index].translation.en,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.amiri(
                                                                                      textStyle: TextStyle(color: demoData[index].textcolor1, letterSpacing: .5, fontSize: 22),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                demoData[index].playlist = !demoData[index].playlist;
                                                                              });
                                                                              if (demoData[index].playlist) {
                                                                                audios.add((1 + index));
                                                                                audios.sort();
                                                                              } else {
                                                                                // audios.remove((1 + index));
                                                                                if (audios.first == audios.last) {
                                                                                  audios.clear();
                                                                                }

                                                                                if (1 + index == audios.last) {
                                                                                  audios.add(audios.last - 1);
                                                                                  audios.remove((1 + index));
                                                                                  audios.sort();
                                                                                }
                                                                                if (1 + index == audios.first) {
                                                                                  audios.add(audios.first + 1);
                                                                                  audios.remove((1 + index));
                                                                                  audios.sort();
                                                                                }
                                                                              }

                                                                              for (int i = audios[0]; i < audios.last - 1; i++) {
                                                                                demoData[i].playlist = true;
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: demoData[index].playlist && audios.isNotEmpty ? Colors.grey : Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
                                                                              child: Stack(
                                                                                children: [
                                                                                  Image.asset(
                                                                                    'assets/images/hexa.png',
                                                                                    width: 30,
                                                                                    height: 30,
                                                                                  ),
                                                                                  Positioned(
                                                                                    bottom: 5,
                                                                                    left: 0,
                                                                                    right: 0,
                                                                                    top: 5,
                                                                                    child: Container(
                                                                                      child: FittedBox(
                                                                                        child: Text(
                                                                                          (1 + index).toString(),
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Checkbox(
                                                                              value: demoData[index].checked,
                                                                              // demoData[index].checked,
                                                                              splashRadius: 2,
                                                                              hoverColor: Colors.blueAccent,
                                                                              activeColor: Theme.of(context).primaryColor,
                                                                              onChanged: (bool newValue) async {
                                                                                setState(() {
                                                                                  demoData[index].checked = newValue;
                                                                                });
                                                                                if (demoData[index].checked)
                                                                                  await player2.setAsset(
                                                                                    'assets/audio/mixkit-achievement-bell-600.wav',
                                                                                  );
                                                                                player2.play();

                                                                                !demoData[index].checked ? await Dbhandler.instance.ayasave(Provider.of<Quraanprovider>(context, listen: false).sour.data[arg[0] - 1].number.toString(), (index + 1).toString(), Provider.of<Quraanprovider>(context, listen: false).sour.data[arg[0] - 1].name, arg[1].toString(), 'no') : await Dbhandler.instance.ayasave(Provider.of<Quraanprovider>(context, listen: false).sour.data[arg[0] - 1].number.toString(), (index + 1).toString(), Provider.of<Quraanprovider>(context, listen: false).sour.data[arg[0] - 1].name, arg[1].toString(), 'read');
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                MyAppp(
                                                                  index: (index +
                                                                          1)
                                                                      .toString(),
                                                                ),
                                                                Divider(
                                                                  height: 1,
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                      }),
                                                ],
                                              ),
                                  ),
                                ),
                ],
              ),
              play
                  ? Positioned(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      bottom: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Text(
                                    Provider.of<Quraanprovider>(context)
                                            .sour
                                            .data[arg[0] - 1]
                                            .number
                                            .toString() +
                                        ' - ' +
                                        Provider.of<Quraanprovider>(context)
                                            .sour
                                            .data[arg[0] - 1]
                                            .englishName +
                                        ' - ' +
                                        Provider.of<Quraanprovider>(context)
                                            .sour
                                            .data[arg[0] - 1]
                                            .name,
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            StreamBuilder<Duration>(
                                stream: player2.durationStream,
                                builder: (context, snapshot) {
                                  final duration =
                                      snapshot.data ?? Duration.zero;
                                  return StreamBuilder<PositionData>(
                                    stream: Rx.combineLatest2<Duration,
                                            Duration, PositionData>(
                                        player2.positionStream,
                                        player2.bufferedPositionStream,
                                        (position, bufferedPosition) =>
                                            PositionData(
                                                position, bufferedPosition)),
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data ??
                                          PositionData(
                                              Duration.zero, Duration.zero);
                                      var position = positionData.position;
                                      if (position > duration) {
                                        position = duration;
                                      }
                                      var bufferedPosition =
                                          positionData.bufferedPosition;
                                      if (bufferedPosition > duration) {
                                        bufferedPosition = duration;
                                      }
                                      return ProgressBar(
                                          thumbRadius: 12,
                                          progressBarColor:
                                              Theme.of(context).primaryColor,
                                          thumbColor:
                                              Theme.of(context).accentColor,
                                          progress: position,
                                          buffered: bufferedPosition,
                                          total: duration,
                                          onSeek: (duration) {
                                            player2.seek(duration);
                                          });
                                    },
                                  );
                                }),
                            ControlButtons(player2),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class ObjectClass {
  bool checked;
  Color textcolor1 = Colors.black;
  bool playlist;
  ObjectClass({
    this.checked,
    this.textcolor1,
    this.playlist,
  });
}

class PositionData {
  Duration position;
  Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
