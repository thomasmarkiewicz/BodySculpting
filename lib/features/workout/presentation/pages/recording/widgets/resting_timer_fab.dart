import 'dart:async';
import 'package:bodysculpting/core/util/format.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundpool/soundpool.dart';
import '../recording_bloc.dart';

class RestingTimerFab extends StatefulWidget {
  final Soundpool soundpool;
  const RestingTimerFab({Key key, @required Soundpool soundpool})
      : this.soundpool = soundpool,
        super(key: key);

  @override
  _RestingTimerFabState createState() => _RestingTimerFabState();
}

class _RestingTimerFabState extends State<RestingTimerFab> {
  Timer _timer;
  int _seconds;
  int _halfWay;
  Future<int> _midwaySoundId;
  Future<int> _finalSoundId;
  //bool isWeb = kIsWeb;

  void initState() {
    super.initState();
    _midwaySoundId = _loadMidwaySound();
    _finalSoundId = _loadFinalSound();
  }

  void startTimer() {
    if (_timer != null) _timer.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_seconds < 1) {
            timer.cancel();
          } else {
            _seconds = _seconds - 1;
            if (_seconds == _halfWay + 2) {
              _playMidwaySound();
            } else if (_seconds == 2) {
              _playFinalSound();
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordingBloc, RecordingState>(
      listener: (context, state) {
        if (state is Active) {
          state.workout.resting.fold(
            () => null,
            (resting) {
              final diff = resting.difference(DateTime.now());
              setState(() {
                _seconds = diff.inSeconds;
                _halfWay = _seconds ~/ 2;
              });
              startTimer();
            },
          );
        }
      },
      child: BlocBuilder<RecordingBloc, RecordingState>(
        builder: (context, state) {
          if (state is Active) {
            final showAddFab = state.workout.resting.isSome();
            return showAddFab
                ? _buildFab(context, state.workout)
                : _buildHiddenFab(context);
          } else {
            return _buildHiddenFab(context);
          }
        },
      ),
    );
  }

  Widget _buildHiddenFab(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }

  Widget _buildFab(BuildContext context, Workout workout) {
    return _seconds < 1
        ? Container(width: 0, height: 0)
        : FloatingActionButton.extended(
            label: SizedBox(
              width: 88,
              child: Text(
                "Rest ${Format.secondsAsMinutesAndSecondsString(_seconds)}",
                key: Key('resting-fab'),
              ),
            ),
            icon: Icon(Icons.cancel),
            foregroundColor: Colors.white,
            tooltip: 'Add new workout',
            onPressed: () {
              _seconds = 0;
            },
          );
  }

  Future<int> _loadMidwaySound() async {
    var bell1 = await rootBundle.load("sounds/bell1.mp3");
    return await widget.soundpool.load(bell1);
  }

  Future<int> _loadFinalSound() async {
    var bell5 = await rootBundle.load("sounds/bell5.mp3");
    return await widget.soundpool.load(bell5);
  }

  Future<void> _playMidwaySound() async {
    var _alarmSound = await _midwaySoundId;
    await widget.soundpool.play(_alarmSound);
  }

  Future<void> _playFinalSound() async {
    var _alarmSound = await _finalSoundId;
    await widget.soundpool.play(_alarmSound);
  }
}
