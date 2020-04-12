import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_routines.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'routines_event.dart';
part 'routines_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_ACTIVITY_FAILURE_MESSAGE =
    'Invalid Activity - must be a one of: lift, swim, bike, run, other';

class RoutinesBloc extends Bloc<RoutinesEvent, RoutinesState> {
  final GetRoutines getRoutines;

  RoutinesBloc({@required GetRoutines getRoutines})
      : assert(getRoutines != null),
        this.getRoutines = getRoutines;

  @override
  RoutinesState get initialState => Empty();

  @override
  Stream<RoutinesState> mapEventToState(
    RoutinesEvent event,
  ) async* {
    if (event is FetchRoutines) {
      yield* _getWorkoutTemplates(event);
    }
  }

  Stream<RoutinesState> _getWorkoutTemplates(FetchRoutines event) async* {
    yield Loading();
    final result = await getRoutines(Params(activity: event.activity));
    yield result.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (routines) {
        routines.sort((a, b) => a.name.compareTo(b.name));
        return Loaded(routines);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
