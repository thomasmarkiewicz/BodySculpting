import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'exercise_set_model.dart';

// TODO: refactor to extend WorkoutSummaryModel instead to remove code duplication?
class WorkoutModel extends Workout {
  WorkoutModel({
    @required String routineId,
    @required String program,
    @required String name,
    @required Activity activity,
    @required UnitsModel units,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
    Option<DateTime> resting,
    @required List<List<ExerciseSetModel>> supersets,
  }) : super(
          routineId: routineId,
          program: program,
          name: name,
          activity: activity,
          units: units,
          description: description,
          start: start,
          end: end,
          summary: summary,
          supersets: supersets,
          resting: resting,
        );

  factory WorkoutModel.from(Workout workout) {
    final supersetList = List<List<ExerciseSetModel>>();

    if (workout.supersets != null) {
      workout.supersets.forEach((ss) {
        final exerciseSetModelList = List<ExerciseSetModel>.from(
            ss.map((es) => ExerciseSetModel.from(es)));
        supersetList.add(exerciseSetModelList);
      });
    }

    return WorkoutModel(
      routineId: workout.routineId,
      program: workout.program,
      name: workout.name,
      activity: workout.activity,
      units: UnitsModel.from(workout.units),
      description: workout.description,
      start: workout.start,
      end: workout.end,
      summary: workout.summary,
      supersets: supersetList,
      resting: workout.resting,
    );
  }

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    final supersets = json['supersets'] as List;
    final supersetList = List<List<ExerciseSetModel>>();

    if (supersets != null) {
      supersets.forEach((ss) {
        final exerciseSetModelList = List<ExerciseSetModel>.from(
            ss.map((es) => ExerciseSetModel.fromJson(es)));
        supersetList.add(exerciseSetModelList);
      });
    }

    return WorkoutModel(
      routineId: json['routine_id'],
      program: json['program'],
      name: json['name'],
      activity: Activity.values
          .firstWhere((e) => e.toString() == 'Activity.' + json['activity']),
      units: UnitsModel.fromJson(json['units']),
      description:
          json.containsKey('description') ? some(json['description']) : none(),
      start: json.containsKey('start')
          ? some(DateTime.parse(json['start']))
          : none(),
      end: json.containsKey('end') ? some(DateTime.parse(json['end'])) : none(),
      summary: json.containsKey('summary') ? some(json['summary']) : none(),
      supersets: supersetList,
      resting: json.containsKey('resting')
          ? some(DateTime.parse(json['resting']))
          : none(),
    );
  }

  Map<String, dynamic> toJson() {
    final supersets = List<List<Map>>();
    if (this.supersets != null) {
      this.supersets.forEach((ss) {
        final superset =
            List.of(ss.map((s) => (s as ExerciseSetModel).toJson()));
        supersets.add(superset);
      });
    }

    final map = {
      'routine_id': routineId,
      'program': program,
      'name': name,
      'activity': describeEnum(activity),
      'units': (units as UnitsModel).toJson(),
      'description': description.getOrElse(() => ''),
      'supersets': supersets,
    };

    start.fold(
      () => {},
      (s) => map.addAll({'start': s.toIso8601String()}),
    );

    end.fold(
      () => {},
      (e) => map.addAll({'end': e.toIso8601String()}),
    );

    summary.fold(
      () => {},
      (s) => map.addAll({'summary': s}),
    );

    resting.fold(
      () => {},
      (r) => map.addAll({'resting': r.toIso8601String()}),
    );

    return map;
  }
}
