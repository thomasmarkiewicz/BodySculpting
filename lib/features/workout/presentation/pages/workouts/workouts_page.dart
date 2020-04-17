import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_page.dart';
import 'package:bodysculpting/features/workout/presentation/pages/routines/routines_page.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workouts/widgets/add_workout_fab.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workouts/widgets/workout_summary_tile.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workouts/workouts_bloc.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workouts/workouts_event.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workouts/workouts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<WorkoutsBloc>();
        bloc.add(Refresh());
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Body Sculpting', key: Key('app-bar-title')),
        ),
        body: SingleChildScrollView(
          child: _buildBody(),
        ),
        floatingActionButton: AddWorkoutFloatingActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<WorkoutsBloc, WorkoutsState>(
      listener: (context, state) {
        if (state is Final) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecordingPage(routine: state.workout),
            ),
          ).then((_) {
            BlocProvider.of<WorkoutsBloc>(context).add(
              Refresh(),
            );
          });
        } else if (state is Adding) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutinesPage(activity: state.activity),
            ),
          ).then((_) {
            BlocProvider.of<WorkoutsBloc>(context).add(
              Refresh(),
            );
          });
        }
      },
      child: BlocBuilder<WorkoutsBloc, WorkoutsState>(
        builder: (context, state) {
          if (state is Initial) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: state.workoutSummaries,
            );
          } else if (state is Ready) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: state.workoutSummaries,
            );
          } else if (state is Final) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: List<WorkoutSummary>(),
            );
          } else {
            return Column();
          }
        },
      ),
    );
  }

  Widget _buildWorkoutSummaryList({
    @required BuildContext context,
    List<WorkoutSummary> summaries,
  }) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: summaries.length,
            itemBuilder: (BuildContext context, int index) {
              return WorkoutSummaryTile(
                workoutSummary: summaries[index],
                onTap: () {
                  BlocProvider.of<WorkoutsBloc>(context).add(
                    WorkoutSelected(summaries[index]),
                  );
                },
              );
            },
          ),
          Visibility(
            visible: summaries.length == 0,
            child: ListTile(
              //leading: FlutterLogo(size: 72.0),
              title: Text(
                "It's lonely here, please add some workouts!!!",
                key: Key('empty-message'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
