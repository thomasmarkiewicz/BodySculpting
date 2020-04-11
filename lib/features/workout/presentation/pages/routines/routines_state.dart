part of 'routines_bloc.dart';

abstract class RoutinesState extends Equatable {
  const RoutinesState();
}

class Empty extends RoutinesState {
  @override
  List<Object> get props => [];
}

class Loading extends RoutinesState {
  @override
  List<Object> get props => [];
}

class Loaded extends RoutinesState {
  final List<Workout> workoutTemplates;

  @override
  List<Object> get props => [workoutTemplates];

  Loaded(this.workoutTemplates);
}

class Error extends RoutinesState {
  final String message;

  @override
  List<Object> get props => [message];

  Error({@required this.message});
}
