import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_workout_templates_local_data_source.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_template_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class RoutineRepository implements AbstractRoutineRepository {
  final AbstractRoutineLocalDataSource localDataSource;

  RoutineRepository({@required this.localDataSource});

  @override
  Future<Either<Failure, List<Workout>>> getRoutines(
    Activity activity,
  ) async {
    try {
      final result = await localDataSource.getRoutines(activity);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
