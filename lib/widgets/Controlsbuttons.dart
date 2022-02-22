import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtons extends StatefulWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  _ControlButtonsState createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  int s = 0;
  List<double> speed = [1, 0.5, 1.5];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<LoopMode>(
          stream: widget.player.loopModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? LoopMode.off;
            const icons = [
              Icon(
                Icons.repeat,
                color: Colors.black,
                size: 40,
              ),
              Icon(Icons.repeat,
                  color: Color.fromRGBO(184, 95, 143, 1), size: 40),
            ];
            const cycleModes = [
              LoopMode.off,
              LoopMode.all,
            ];
            final index = cycleModes.indexOf(loopMode);
            return IconButton(
              icon: icons[index],
              onPressed: () {
                widget.player.setLoopMode(cycleModes[
                    (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
              },
            );
          },
        ),
        SizedBox(
          width: 5,
        ),
        StreamBuilder<SequenceState>(
          stream: widget.player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(
              Icons.skip_previous,
              size: 40,
            ),
            onPressed:
                widget.player.hasPrevious ? widget.player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: widget.player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (playing != true) {
              return GestureDetector(
                onTap: () async {
                  widget.player.play();
                },
                child: Icon(
                  FontAwesomeIcons.playCircle,
                  color: Colors.black,
                  size: 45,
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return GestureDetector(
                onTap: () async {
                  widget.player.pause();
                },
                child: Icon(
                  FontAwesomeIcons.pauseCircle,
                  color: Colors.black,
                  size: 45,
                ),
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 35.0,
                onPressed: () => widget.player.seek(Duration.zero,)
                   // index: widget.player.effectiveIndices.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState>(
          stream: widget.player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(
              Icons.skip_next,
              size: 40,
            ),
            onPressed: widget.player.hasNext ? widget.player.seekToNext : null,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
            onTap: () async {
              setState(() {
                s < 2 ? ++s : s = 0;
              });
              await widget.player.setSpeed(speed[s]);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.transparent,
                child: Text(
                  speed[s].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )),
      ],
    );
  }
}
