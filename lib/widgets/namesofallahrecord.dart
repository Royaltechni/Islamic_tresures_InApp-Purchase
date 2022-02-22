import 'dart:async';
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/Controlsbuttons.dart';
import 'package:kidsapp/widgets/iconplay.dart';
import 'package:kidsapp/widgets/playassets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:rxdart/rxdart.dart';

class AudioRecord extends StatefulWidget {
  final String path;
  final VoidCallback onStop;
  static bool dialy = false;
  final String url;
  const AudioRecord({this.path, this.onStop, this.url});

  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer _timer;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    _isRecording = false;
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: AudioRecord.dialy
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              _buildRecordStopControl(),
              //   const SizedBox(width: ),
              AudioRecord.dialy ? Iconsplay(this.widget.url) : Container(),
              const SizedBox(width: 5),
              // _buildPauseResumeControl(),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecordStopControl() {
    Icon icon;
    Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: Colors.white, size: 30);
      color = Theme.of(context).primaryColor.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: Colors.white, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        child: Material(
          color: color,
          child: InkWell(
            child: SizedBox(width: 50, height: 50, child: icon),
            onTap: () async {
              _isRecording ? _stop() : _start();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return Container();
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.white),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await Record.hasPermission()) {
        await Record.start(path: widget.path);

        bool isRecording = await Record.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    await Record.stop();

    setState(() => _isRecording = false);

    widget.onStop();
  }

  void _startTimer() {
    const tick = const Duration(seconds: 1);

    _timer?.cancel();

    _timer = Timer.periodic(tick, (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

class Namesofallahrecord extends StatefulWidget {
  static bool dialy;
  final String url;

  const Namesofallahrecord({
    this.url,
  });

  @override
  _NamesofallahrecordState createState() => _NamesofallahrecordState();
}

class _NamesofallahrecordState extends State<Namesofallahrecord> {
  bool showPlayer = false;
  String path;
  AudioPlayer advancedPlayer;
  bool play;
  bool loading;
  @override
  void initState() {
    showPlayer = false;
    advancedPlayer = AudioPlayer();
    play = false;
    loading = false;
    super.initState();
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            height: 60,
            child: FutureBuilder<String>(
              future: getPath(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (showPlayer) {
                    return Row(
                      //    mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                             Provider.of<Lanprovider>(context, listen: false).islogin?
                        loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ClipOval(
                                child: Material(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.04),
                                  child: InkWell(
                                    child: SizedBox(
                                        width: 56,
                                        height: 56,
                                        child: Icon(
                                          Icons.send,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      await Dbhandler.instance
                                          .hosnarecord(File(path));

                                      setState(() {
                                        loading = false;
                                        showPlayer = false;
                                      });
                                    },
                                  ),
                                ),
                              ):Container(),
                        SizedBox(
                          width: 10,
                        ),
                        ClipOval(
                          child: InkWell(
                            child: SizedBox(
                                child: Icon(
                              Icons.mic,
                              size: 30,
                              color: Colors.white,
                            )),
                            onTap: () {
                            
                              setState(() {
                                showPlayer = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Playassets(snapshot.data),
                      ],
                    );
                  } else {
                    return AudioRecord(
                      path: snapshot.data,
                      url: this.widget.url,
                      onStop: () {
                        setState(() => showPlayer = true);
                      },
                    );
                  }
                } else {
                  return Center();
                }
              },
            )),
      ),
    );
  }

  Future<String> getPath() async {
    if (path == null) {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
    }
    return path;
  }
}
