import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'exercise_model.dart';

class DocumentModel extends Equatable {
  final String version;
  final int syncCounter;
  final List<ExerciseModel> exercises;
  final List<WorkoutModel> routines;

  @override
  List<Object> get props => [version, syncCounter, exercises, routines];

  DocumentModel({
    @required this.version,
    @required this.syncCounter,
    @required this.exercises,
    @required this.routines,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    final exercises = json['exercises'] as List;
    List<ExerciseModel> exercisesList = exercises != null
        ? exercises.map((s) => ExerciseModel.fromJson(s)).toList()
        : List<ExerciseModel>();

    final routines = json['routines'] as List;
    List<WorkoutModel> routineList = routines != null
        ? routines.map((s) => WorkoutModel.fromJson(s)).toList()
        : List<ExerciseModel>();

    return DocumentModel(
      version: json['version'],
      syncCounter: json['sync_counter'],
      exercises: exercisesList,
      routines: routineList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> exercises = this.exercises != null
        ? this.exercises.map((exercise) => exercise.toJson()).toList()
        : null;

    List<Map> routines = this.routines != null
        ? this.routines.map((routine) => routine.toJson()).toList()
        : null;

    return {
      'version': version,
      'sync_counter': syncCounter,
      'exercises': exercises,
      'routines': routines
    };
  }
}
