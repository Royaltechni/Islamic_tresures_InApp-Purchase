import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'Controlsbuttons.dart';

class Iconsplay extends StatefulWidget {
  final String url;
  Iconsplay(this.url);
  @override
  _IconsplayState createState() => _IconsplayState();
}

class _IconsplayState extends State<Iconsplay> {
  AudioPlayer advancedPlayer;
  @override
  void dispose() {
    advancedPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    advancedPlayer = AudioPlayer();
    // TODO: implement initState
    super.initState();
  }

  Future<bool> _onWillPop() async {
    print("on will pop");
    advancedPlayer.stop();
    advancedPlayer = AudioPlayer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: SizedBox(
            width: 50,
            height: 50,
            child:  Icon(
                    Icons.play_arrow,
                    size: 40.0,
                    color: Colors.green,
                  ),
          ),
          onTap: () async {
           await advancedPlayer.setUrl(this.widget.url);
            advancedPlayer.play();

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  var children2 = <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<Duration>(
                            stream: advancedPlayer.durationStream,
                            builder: (context, snapshot) {
                              final duration = snapshot.data ?? Duration.zero;
                              return StreamBuilder<PositionData>(
                                stream: Rx.combineLatest2<Duration, Duration,
                                        PositionData>(
                                    advancedPlayer.positionStream,
                                    advancedPlayer.bufferedPositionStream,
                                    (position, bufferedPosition) =>
                                        PositionData(
                                            position, bufferedPosition)),
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data ??
                                      PositionData(
                                          Duration.zero, Duration.zero);
                                  var position = positionData.position;
                                  

                                  var bufferedPosition =
                                      positionData.bufferedPosition;
                                  if (bufferedPosition > duration) {
                                    bufferedPosition = duration;
                                  }
                                  return ProgressBar(
                                      thumbRadius: 12,
                                      progressBarColor:
                                          Theme.of(context).primaryColor,
                                      thumbColor: Theme.of(context).accentColor,
                                      progress: position,
                                      buffered: bufferedPosition,
                                      total: duration,
                                      onSeek: (duration) {
                                        advancedPlayer.seek(duration);
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
                          borderRadius: BorderRadius.circular(16)),
                      content: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: children2,
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
