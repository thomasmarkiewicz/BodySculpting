import 'dart:async';
import 'package:bodysculpting/core/util/format.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../recording_bloc.dart';

class RestingTimerFab extends StatefulWidget {
  const RestingTimerFab({Key key}) : super(key: key);

  @override
  _RestingTimerFabState createState() => _RestingTimerFabState();
}

class _RestingTimerFabState extends State<RestingTimerFab> {
  Timer _timer;
  int _seconds;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_seconds < 1) {
            timer.cancel();
          } else {
            _seconds = _seconds - 1;
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
    return _seconds == 0
        ? Container(width: 0, height: 0)
        : FloatingActionButton.extended(
            label: SizedBox(
              width: 44,
              child: Text(
                Format.secondsAsMinutesAndSecondsString(_seconds),
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
}
