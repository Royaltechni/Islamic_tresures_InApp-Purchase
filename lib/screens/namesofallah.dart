import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/models/Namesofallah.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/Namesofallah.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/widgets/CheckSubscription.dart';
import 'package:kidsapp/widgets/cheaklogin.dart';
import 'package:kidsapp/widgets/namesofallahrecord.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class Namesofallah extends StatefulWidget {
  @override
  _NamesofallahState createState() => _NamesofallahState();
}

class _NamesofallahState extends State<Namesofallah> {
  List<ObjectClass> demoData;
  bool firstrun = true;
  bool secondrun = false;
  AudioPlayer player2;
  List<int> hosnasaved = [];
  bool play;
  int page = 1;
  int total = 0;
  List<Data> names = [];
  List<Data> distinctIds = [];
  BetterPlayerController _betterPlayerController;
  ScrollController _scrollController = new ScrollController();
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    await Provider.of<Namesofallahprovider>(context, listen: false)
        .fetchnamesofallah(page);
    await Provider.of<Namesofallahprovider>(context, listen: false)
        .fetchvedio();
    if (Dbhandler.instance.hosnastatuscode == 200) {
      demoData = List.generate(99, (i) {
        return ObjectClass(
          checked: false,
        );
      });
      names.addAll(Provider.of<Namesofallahprovider>(context, listen: false)
          .namesofallah
          .data);
      distinctIds = names.toSet().toList();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            page <=
                Provider.of<Namesofallahprovider>(context, listen: false)
                    .namesofallah
                    .meta
                    .lastPage) {
          setState(() {
            secondrun = true;
          });
          await Provider.of<Namesofallahprovider>(context, listen: false)
              .fetchnamesofallah(++page);
          names.addAll(Provider.of<Namesofallahprovider>(context, listen: false)
              .namesofallah
              .data);
          distinctIds = names.toSet().toList();
          setState(() {
            secondrun = false;
          });
        }
      });
      await Provider.of<Namesofallahprovider>(context, listen: false)
          .fetchnamessaved();
      await Provider.of<Namesofallahprovider>(context, listen: false)
          .fetchvedio();
      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              fit: BoxFit.contain,
              autoPlay: false,
              autoDispose: false,
              autoDetectFullscreenDeviceOrientation: true);
      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          Provider.of<Namesofallahprovider>(context, listen: false)
              .video
              .result
              .videoUrl);
      _betterPlayerController =
          BetterPlayerController(betterPlayerConfiguration);
      _betterPlayerController.setupDataSource(dataSource);
      if (Provider.of<Lanprovider>(context, listen: false).islogin) {
        for (int i = 0;
            i <
                Provider.of<Namesofallahprovider>(context, listen: false)
                    .hosnasaved
                    .result
                    .length;
            i++) {
          hosnasaved.add(
              Provider.of<Namesofallahprovider>(context, listen: false)
                  .hosnasaved
                  .result[i]
                  .hosnaId);
          int b = hosnasaved.elementAt(i);
          demoData[b - 1].checked = true;
        }
      }
    }

    setState(() {
      firstrun = false;
    });
  }

  @override
  void initState() {
    play = false;
    player2 = AudioPlayer();
    print(total);
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    player2.dispose();
    _betterPlayerController.videoPlayerController.dispose();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    print("on will pop");
    // _betterPlayerController.pause();
    _betterPlayerController.videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          setState(() {
            play = false;
          });
          _betterPlayerController.pause();
          //   _betterPlayerController.videoPlayerController.dispose();
        },
        child: Scaffold(
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
                            Home.homeindex = 5;

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
              : Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomCenter, stops: [
                    0.05,
                    0.4,
                    0.9
                  ], colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.6),
                    Colors.blue[700]
                  ])),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 20, top: 15, left: 15, right: 15),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                constraints:
                                    BoxConstraints(maxWidth: double.infinity),
                                height: 45,
                                child: Center(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: false)
                                              .isenglish
                                          ? 'Record The 99 Names of Allah '
                                          : 'قم بتسجيل أسماء الله الحسنى',
                                      style: GoogleFonts.roboto(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
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
                                                        BorderRadius.circular(
                                                            15)),
                                                content: Cheaklogin());
                                          })
                                      : setState(() {
                                          play = !play;
                                        });
                                  play
                                      ? _betterPlayerController.play()
                                      : _betterPlayerController.pause();
                                },
                                child: play
                                    ? Icon(
                                        FontAwesomeIcons.pauseCircle,
                                        color: Colors.white,
                                        size: 40,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.playCircle,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                              ),
                              Container(
                                  width: 160, child: Namesofallahrecord()),
                            ],
                          ),
                        ),
                      ),
                      firstrun
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Dbhandler.instance.hosnastatuscode != 200
                              ? Container(
                                  height: double.infinity,
                                  child: Image.asset('assets/images/error.jpg'),
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      child: StaggeredGridView.countBuilder(
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        itemCount: distinctIds.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              //added by youssef
                                              if(Provider.of<Userprovider>(context, listen: false).user.active == false && CheackUserSubscribe.isUserSubscribe==false){
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
                                                            content:
                                                                Cheaklogin());
                                                      })
                                                  : await player2.setUrl(
                                                      (distinctIds[index]
                                                          .audio),
                                                    );
                                              await player2.play();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              height: 240,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: [
                                                        Stack(
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
                                                                child:
                                                                    FittedBox(
                                                                  child: Text(
                                                                    (1 + index)
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Checkbox(
                                                            value:
                                                                demoData[index]
                                                                    .checked,
                                                            // demoData[index].checked,
                                                            splashRadius: 2,
                                                            hoverColor: Colors
                                                                .blueAccent,
                                                            activeColor: Theme
                                                                    .of(context)
                                                                .primaryColor,
                                                            onChanged: (bool
                                                                newValue) async {
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
                                                              !Provider.of<Lanprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .islogin
                                                                  ? await showDialog(
                                                                      //  barrierDismissible: false, //
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        return AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                            content: Cheaklogin());
                                                                      })
                                                                  : setState(
                                                                      () {
                                                                      demoData[index]
                                                                              .checked =
                                                                          newValue;
                                                                    });
                                                              if (demoData[
                                                                      index]
                                                                  .checked)
                                                                await player2
                                                                    .setAsset(
                                                                        'assets/audio/mixkit-achievement-bell-600.wav');
                                                              player2.play();
                                                              Dbhandler.instance
                                                                  .namesofallahsaved(
                                                                      distinctIds[
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    distinctIds[index].titleAr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    distinctIds[index].titleEn,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    distinctIds[index]
                                                        .description,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        staggeredTileBuilder: (int index) =>
                                            new StaggeredTile.fit(1),
                                        mainAxisSpacing: 2.0,
                                        crossAxisSpacing: 2.0,
                                      ),
                                    ),
                                    play
                                        ? AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: BetterPlayer(
                                                controller:
                                                    _betterPlayerController),
                                          )
                                        : Container()
                                  ],
                                ),
                      secondrun
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                    ],
                  )),
        ),
      ),
    );
  }
}

class ObjectClass {
  bool checked;
  ObjectClass({
    this.checked,
  });
}
