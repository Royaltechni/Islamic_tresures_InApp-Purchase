import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/models/Categories.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/azkarprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/screens/duaas.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/Controlsbuttons.dart';
import 'package:kidsapp/widgets/gift.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class Duadetails extends StatefulWidget {
  static const String route = '/Duadetails';

  @override
  _DuadetailsState createState() => _DuadetailsState();
}

class _DuadetailsState extends State<Duadetails> {
  bool firstrun;
  bool loading;
  bool play;
  AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    firstrun = true;
    loading = false;
    play = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    advancedPlayer = AudioPlayer();
    await Provider.of<Networkprovider>(context).cheaknetwork();
    Data azkar = ModalRoute.of(context).settings.arguments as Data;
    await Provider.of<Azkarprovider>(context, listen: false)
        .fetchazkarbyid(azkar.id);
    setState(() {
      firstrun = false;
    });
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    print("on will pop");
    advancedPlayer.stop();
    advancedPlayer = AudioPlayer();
    Navigator.pop(context);
  }

 String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
  
  @override
  Widget build(BuildContext context) {
    Data azkar = ModalRoute.of(context).settings.arguments as Data;
    return SafeArea(
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
            : firstrun
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 10, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 35,
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              azkar.title,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).accentColor)),
                          height:   getDeviceType() == 'phone' ? 190:300,
                          child: CachedNetworkImage(
                            imageUrl: Provider.of<Azkarprovider>(context)
                                .categoriess
                                .data
                                .image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                            child: ListView.builder(
                                itemCount: azkar.azkars.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(20),
                                          child: Text(
                                            Provider.of<Azkarprovider>(context)
                                                .categoriess
                                                .data
                                                .azkars[index]
                                                .desciptionAr,
                                            textDirection: TextDirection.rtl,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  letterSpacing: .5,
                                                  fontSize:  getDeviceType() == 'phone' ? 16:26),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 20,
                                              right: 20,
                                              left: 20),
                                          child: Text(
                                            Provider.of<Azkarprovider>(context)
                                                .categoriess
                                                .data
                                                .azkars[index]
                                                .desciptionEn,
                                            textDirection: TextDirection.ltr,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  letterSpacing: .5,
                                                  fontSize: getDeviceType() == 'phone' ?16:26),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              bottom: 20,
                                              right: 20,
                                              left: 20),
                                          child: Text(
                                            Provider.of<Azkarprovider>(context)
                                                .categoriess
                                                .data
                                                .azkars[index]
                                                .desciptionFr,
                                            textDirection: TextDirection.ltr,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  letterSpacing: .5,
                                                  fontSize:  getDeviceType() == 'phone' ? 16:26),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await advancedPlayer.setUrl(
                                    Provider.of<Azkarprovider>(context,
                                            listen: false)
                                        .categoriess
                                        .data
                                        .azkars[0]
                                        .audio);
                                advancedPlayer.play();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var children2 = <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            StreamBuilder<Duration>(
                                                stream: advancedPlayer
                                                    .durationStream,
                                                builder: (context, snapshot) {
                                                  final duration =
                                                      snapshot.data ??
                                                          Duration.zero;
                                                  return StreamBuilder<
                                                      PositionData>(
                                                    stream: Rx.combineLatest2<
                                                            Duration,
                                                            Duration,
                                                            PositionData>(
                                                        advancedPlayer
                                                            .positionStream,
                                                        advancedPlayer
                                                            .bufferedPositionStream,
                                                        (position,
                                                                bufferedPosition) =>
                                                            PositionData(
                                                                position,
                                                                bufferedPosition)),
                                                    builder:
                                                        (context, snapshot) {
                                                      final positionData =
                                                          snapshot.data ??
                                                              PositionData(
                                                                  Duration.zero,
                                                                  Duration
                                                                      .zero);
                                                      var position =
                                                          positionData.position;

                                                      var bufferedPosition =
                                                          positionData
                                                              .bufferedPosition;
                                                      if (bufferedPosition >
                                                          duration) {
                                                        bufferedPosition =
                                                            duration;
                                                      }
                                                      return ProgressBar(
                                                          thumbRadius: 12,
                                                          progressBarColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          thumbColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          progress: position,
                                                          buffered:
                                                              bufferedPosition,
                                                          total: duration,
                                                          onSeek: (duration) {
                                                            advancedPlayer
                                                                .seek(duration);
                                                          });
                                                    },
                                                  );
                                                }),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ControlButtons(advancedPlayer),
                                          ],
                                        )
                                      ];
                                      return WillPopScope(
                                        onWillPop: _onWillPop,
                                        child: AlertDialog(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          content: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: children2,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: play
                                      ? Icon(
                                          Icons.pause_outlined,
                                          color: Colors.white,
                                          size: 45,
                                        )
                                      : Icon(
                                          Icons.play_arrow_sharp,
                                          color: Colors.white,
                                          size: 45,
                                        )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          height: getDeviceType() == 'phone' ? 40:50,
                          margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.3)
                              .add(EdgeInsets.only(bottom: 30, top: 10)),
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
                                              Theme.of(context).accentColor)),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await Dbhandler.instance
                                        .azkarread('read', azkar.id.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                      if (Dbhandler.instance.azkarreadd == 200)
                                    await advancedPlayer.setAsset(
                                      'assets/audio/mixkit-achievement-bell-600.wav',
                                    );
                                    advancedPlayer.play();
                                    if (Dbhandler.instance.azkarreadd == 200)
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
                                                onPressed: () async {
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
                                    else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
