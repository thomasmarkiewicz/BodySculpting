import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractRoutineRepository {
  Future<Either<Failure, List<Workout>>> getRoutines(Activity activity);
}
