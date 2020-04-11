import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:equatable/equatable.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();
}

class Refresh extends WorkoutsEvent {
  @override
  List<Object> get props => null;
}

class WorkoutSelected extends WorkoutsEvent {
  final WorkoutSummary workoutSummary;

  WorkoutSelected(this.workoutSummary);

  @override
  List<Object> get props => [workoutSummary];
}

class ActivitySelected extends WorkoutsEvent {
  final Activity activity;

  ActivitySelected(this.activity);

  @override
  List<Object> get props => [activity];
}
