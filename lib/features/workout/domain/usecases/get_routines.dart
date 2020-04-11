import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_routine_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetRoutines implements Usecase<List<Workout>, Params> {
  final AbstractRoutineRepository repository;

  GetRoutines(this.repository);

  @override
  Future<Either<Failure, List<Workout>>> call(Params params) async {
    return await repository.getRoutines(params.activity);
  }
}

class Params extends Equatable {
  final Activity activity;

  @override
  List<Object> get props => [activity];

  Params({@required this.activity});
}
