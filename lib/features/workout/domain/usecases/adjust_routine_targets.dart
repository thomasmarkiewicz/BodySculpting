import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AdjustRoutineTargets
    implements Usecase<Workout, AdjustRoutineTargetsParams> {
  final AbstractWorkoutRepository repository;

  AdjustRoutineTargets(this.repository);

  @override
  Future<Either<Failure, Workout>> call(
    AdjustRoutineTargetsParams params,
  ) async {
    final response = await repository.getWorkoutsForActivityProgram(
      start: DateTime.now().subtract(Duration(days: 90)),
      end: DateTime.now(),
      activity: params.workout.activity,
      program: params.workout.program,
    );

    final Either<Failure, Workout> result = response.fold(
      (failure) => Left(failure),
      (workouts) {
        // sort in descending order
        workouts.sort((a, b) => b.start
            .getOrElse(() => null)
            .compareTo(a.start.getOrElse(() => null)));

        var adjustedRoutine = params.workout;
        for (var supersetIndex = 0;
            supersetIndex < params.workout.supersets.length;
            supersetIndex++) {
          for (var exerciseSetIndex = 0;
              exerciseSetIndex < params.workout.supersets[supersetIndex].length;
              exerciseSetIndex++) {
            final targetWeight = _getTargetWeight(
                workouts,
                params.workout.supersets[supersetIndex][exerciseSetIndex]
                    .exerciseId);
            adjustedRoutine = targetWeight.fold(
              () => adjustedRoutine,
              (weight) => adjustedRoutine.updateTargetWeight(
                supersetIndex: supersetIndex,
                exerciseSetIndex: exerciseSetIndex,
                weight: weight,
              ),
            );
          }
        }
        return Right(adjustedRoutine);
      },
    );

    return result;
  }

  Option<int> _getTargetWeight(List<Workout> workouts, String exerciseId) {
    for (final workout in workouts) {
      for (final superSet in workout.supersets) {
        for (final exerciseSet in superSet) {
          if (exerciseSet.exerciseId.compareTo(exerciseId) == 0) {
            return some(exerciseSet.targetWeight);
          }
        }
      }
    }
    return none();
  }
}

class AdjustRoutineTargetsParams extends Equatable {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  AdjustRoutineTargetsParams({@required this.workout});
}
