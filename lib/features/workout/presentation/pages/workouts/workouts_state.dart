import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:equatable/equatable.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();
}

// initial state
class Initial extends WorkoutsState {
  final List<WorkoutSummary> workoutSummaries = List<WorkoutSummary>();

  @override
  List<Object> get props => [workoutSummaries];
}

class Ready extends WorkoutsState {
  final List<WorkoutSummary> workoutSummaries;

  @override
  List<Object> get props => [];

  const Ready(this.workoutSummaries);
}

class Final extends WorkoutsState {
  final Workout workout;

  Final(this.workout);

  @override
  List<Object> get props => [workout];
}

class Adding extends WorkoutsState {
  final Activity activity;

  Adding(this.activity);

  @override
  List<Object> get props => [activity];
}
