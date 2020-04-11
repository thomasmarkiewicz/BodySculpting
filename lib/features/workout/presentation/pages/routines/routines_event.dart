part of 'routines_bloc.dart';

abstract class RoutinesEvent extends Equatable {
  const RoutinesEvent();
}

class FetchRoutines extends RoutinesEvent {
  final Activity activity;

  @override
  List<Object> get props => [activity];

  FetchRoutines(this.activity);
}
