import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetWorkout implements Usecase<Workout, WorkoutParams> {
  final AbstractWorkoutRepository repository;

  GetWorkout(this.repository);

  @override
  Future<Either<Failure, Workout>> call(WorkoutParams params) async {
    return await repository.getWorkout(
      start: params.start,
      activity: params.activity,
    );
  }
}

class WorkoutParams extends Equatable {
  final DateTime start;
  final Activity activity;

  @override
  List<Object> get props => [start, activity];

  WorkoutParams({@required this.start, @required this.activity});
}
