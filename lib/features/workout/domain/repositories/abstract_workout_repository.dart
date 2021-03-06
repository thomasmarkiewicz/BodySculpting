import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class AbstractWorkoutRepository {
  Future<Either<Failure, Workout>> getActiveWorkout();
  Future<Either<Failure, List<WorkoutSummary>>> getWorkoutSummaries({
    @required DateTime start,
    @required DateTime end,
  });
  Future<Either<Failure, Workout>> getWorkout({
    @required DateTime start,
    @required Activity activity,
  });
  Future<Either<Failure, Workout>> createWorkout(Workout workout);
  Future<Either<Failure, Workout>> updateWorkout(Workout workout);
  Future<Either<Failure, Workout>> deleteWorkout({
    @required DateTime start,
    @required DateTime end,
    @required Activity activity,
  });
  Future<Either<Failure, List<Workout>>> getWorkoutsForActivityProgram({
    @required DateTime start,
    @required DateTime end,
    @required Activity activity,
    @required String program,
  });
}
