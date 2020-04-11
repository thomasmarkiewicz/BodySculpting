import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_page.dart';
import 'package:bodysculpting/features/workout/presentation/pages/routines/routines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bodysculpting/injection_container.dart';

class RoutinesPage extends StatelessWidget {
  final Activity activity;
  const RoutinesPage({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RoutinesBloc>();
        bloc.add(FetchRoutines(activity));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select a routine'),
        ),
        body: _buildRoutineList(),
      ),
    );
  }

  Widget _buildRoutineList() {
    return BlocBuilder<RoutinesBloc, RoutinesState>(
      builder: (context, state) {
        if (state is Loaded) {
          return RoutineList(routines: state.workoutTemplates);
        } else {
          return Column();
        }
      },
    );
  }
}

class RoutineList extends StatelessWidget {
  final List<Workout> routines;
  RoutineList({Key key, this.routines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: routines.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(routines[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordingPage(routine: routines[index]),
              ),
            ).then((_) {
              Navigator.pop(context);
            });
          },
        );
      },
    ));
  }
}
