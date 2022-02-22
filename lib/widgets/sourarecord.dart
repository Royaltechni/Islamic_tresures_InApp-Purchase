import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/addquraanrecoed.dart';
import 'package:kidsapp/widgets/playassets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'allrecorddialog.dart';

class AudioRecord extends StatefulWidget {
  final String path;
  final VoidCallback onStop;
  static bool dialy = false;
  final int juzid;
  final int souraid;
  const AudioRecord({this.path, this.onStop, this.juzid, this.souraid});

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

  Future<bool> _onWillPopup() async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: 50,
          //   width: double.infinity,
          child: Row(
            mainAxisAlignment: AudioRecord.dialy
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildText(),
              ),
              _buildRecordStopControl(),
              //   const SizedBox(width: ),
               Provider.of<Lanprovider>(context, listen: false).islogin?
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        //  barrierDismissible: false, //
                        context: context,
                        builder: (_) {
                          return WillPopScope(
                            onWillPop: _onWillPopup,
                            child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                content: Allrecordquraandialog(
                                  this.widget.juzid,
                                  this.widget.souraid,
                                )),
                          );
                        });
                  },
                  child: Icon(
                    Icons.play_arrow,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ):Container(),
              const SizedBox(width: 5),
              // _buildPauseResumeControl(),
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

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top:12.0),
        child: ClipOval(
          child: InkWell(
            child: SizedBox(width: 56, height: 56, child: icon),
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

class Sourarecord extends StatefulWidget {
  // static bool dialy;
  final String url;
  final int juzid;
  final int souraid;

  const Sourarecord({
    this.url,
    this.juzid,
    this.souraid,
  });

  @override
  _SourarecordState createState() => _SourarecordState();
}

class _SourarecordState extends State<Sourarecord> {
  bool showPlayer = false;
  String path;
  AudioPlayer advancedPlayer;
  bool play;
  bool loading;
  bool loading1;
  bool loading2;
  @override
  void initState() {
    showPlayer = false;
    advancedPlayer = AudioPlayer();
    play = false;
    loading = false;
    loading1 = false;
    loading2 = false;

    super.initState();
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPopup() async {
    print('ss');
    // AudioRecorder.dialy = false;
    //  Navigator.of(context).pop();
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
                                      if (Soura.isrecorded) {
                                        showDialog(
                                            //  barrierDismissible: false, //
                                            context: context,
                                            builder: (_) {
                                              return WillPopScope(
                                                  onWillPop: _onWillPopup,
                                                  child: AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      content: Addquraanrecord(
                                                          this.widget.juzid,
                                                          this.widget.souraid,
                                                          path)));
                                            });
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        await Dbhandler.instance.sourarecrod(
                                            File(path),
                                            this.widget.juzid,
                                            this.widget.souraid,
                                            'no');

                                        Soura.isrecorded = true;
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                      setState(() {
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
                              width: 50,
                              height: 40,
                                child: Icon(
                              Icons.mic,
                              size: 30,
                              color: Colors.white,
                            )),
                            onTap: () async {
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
                      juzid: this.widget.juzid,
                      souraid: this.widget.souraid,
                      //  url: this.widget.url,
                      onStop: () {
                        setState(() => showPlayer = true);
                      },
                    );
                  }
                } else {
                  return Container();
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
