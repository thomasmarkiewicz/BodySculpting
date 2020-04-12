import 'dart:convert';
import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'abstract_workout_local_data_source.dart';

/*

STRATEGY FOR BOX NAMING

- an active workout is aways stored in the "active" box under the "workout" key

- workouts are stored in various boxes based on year and activity

the `year` is there so that opening a 10 year old box will not be a huge memory cost
the `activity` is there because different activities will likely use different models

for example:

`workout_${year}_${activity}`

*/

class HiveWorkoutLocalDataSource implements AbstractWorkoutLocalDataSource {
  @override
  Future<WorkoutModel> createWorkout(WorkoutModel workout) async {
    // only an active workout can be created
    if (workout == null || !workout.isActive()) throw CacheException();

    final activeBox = await Hive.openBox<String>('active');
    final jsonActiveWorkout = activeBox.get('workout');

    if (jsonActiveWorkout != null) {
      // Can't create a new workout when there already one in progress.
      // User should finish and possibly delete it before create a new one.
      activeBox.close();
      throw CacheException();
    }

    final encoder = JsonEncoder.withIndent("   ");
    await activeBox.put('workout', encoder.convert(workout));
    await activeBox.close();
    return workout;
  }

  @override
  Future<Workout> deleteWorkout({
    DateTime start,
    DateTime end,
    Activity activity,
  }) async {
    final dateTimeKey = DateFormat('yyyyMMdd-kkmmss').format(start);
    final yearPart = DateFormat('yyyy').format(start);
    final activityPart = describeEnum(activity);

    final workoutLazyBox =
        await Hive.openLazyBox<String>('workout_${yearPart}_$activityPart');

    final jsonWorkout = await workoutLazyBox.get(dateTimeKey);
    await workoutLazyBox.delete(dateTimeKey);
    await workoutLazyBox.close();

    if (jsonWorkout != null) {
      final workout = WorkoutModel.fromJson(jsonDecode(jsonWorkout));
      return workout;
    }

    throw CacheException();
  }

  @override
  Future<Workout> getWorkout({DateTime start, Activity activity}) async {
    // check in active
    final activeBox = await Hive.openBox<String>('active');
    final jsonActiveWorkout = activeBox.get('workout');
    activeBox.close();
    if (jsonActiveWorkout != null) {
      final workout = WorkoutModel.fromJson(jsonDecode(jsonActiveWorkout));
      if (workout.start == some(start) && workout.activity == activity) {
        return workout;
      }
    }

    // check in other box
    final dateTimeKey = DateFormat('yyyyMMdd-kkmmss').format(start);
    final yearPart = DateFormat('yyyy').format(start);
    final activityPart = describeEnum(activity);
    final workoutLazyBox =
        await Hive.openLazyBox<String>('workout_${yearPart}_$activityPart');
    final jsonWorkout = await workoutLazyBox.get(dateTimeKey);

    workoutLazyBox.close();
    if (jsonWorkout != null) {
      final workout = WorkoutModel.fromJson(jsonDecode(jsonWorkout));
      if (workout.start == some(start) && workout.activity == activity) {
        return workout;
      }
    }

    // didn't find one
    throw CacheException();
  }

  @override
  Future<List<WorkoutSummaryModel>> getWorkoutSummaries({
    DateTime start,
    DateTime end,
  }) async {
    var summaries = List<WorkoutSummaryModel>();

    // active
    final activeBox = await Hive.openBox<String>('active');
    final jsonActiveWorkout = activeBox.get('workout');
    activeBox.close();

    if (jsonActiveWorkout != null) {
      final summary =
          WorkoutSummaryModel.fromJson(jsonDecode(jsonActiveWorkout));
      summaries.add(summary);
    }

    // rest in the date range
    final count = end.year - start.year + 1;
    final years = new List<int>.generate(
      count,
      (i) => start.year + i,
    );

    final activities = ['lift', 'swim', 'bike', 'run', 'other'];

    for (final year in years) {
      for (final activity in activities) {
        final activityPart = activity;
        final workoutLazyBox =
            await Hive.openLazyBox<String>('workout_${year}_$activityPart');
        for (final key in workoutLazyBox.keys) {
          final jsonWorkout = await workoutLazyBox.get(key);
          if (jsonWorkout != null) {
            final summary =
                WorkoutSummaryModel.fromJson(jsonDecode(jsonWorkout));
            if (summary.start.isSome() &&
                summary.end.isSome() &&
                summary.start
                        .getOrElse(() => DateTime.now())
                        .compareTo(start) >=
                    1 &&
                summary.end.getOrElse(() => DateTime.now()).compareTo(end) <=
                    0) {
              summaries.add(summary);
            }
          }
        }
        workoutLazyBox.close();
      }
    }

    return summaries;
  }

  @override
  Future<WorkoutModel> updateWorkout(WorkoutModel workout) async {
    final startDateTime = workout.start.getOrElse(() => throw CacheException());
    final dateTimeKey = DateFormat('yyyyMMdd-kkmmss').format(startDateTime);
    final yearPart = DateFormat('yyyy').format(startDateTime);
    final activityPart = describeEnum(workout.activity);
    final finishedWorkoutBoxName = 'workout_${yearPart}_$activityPart';
    final encoder = JsonEncoder.withIndent("   ");

    // check in active
    final activeBox = await Hive.openBox<String>('active');
    final jsonActiveWorkout = activeBox.get('workout');
    if (jsonActiveWorkout != null) {
      final existingWorkout =
          WorkoutModel.fromJson(jsonDecode(jsonActiveWorkout));
      if (existingWorkout.start == workout.start &&
          existingWorkout.activity == workout.activity) {
        if (workout.isActive()) {
          await activeBox.put('workout', encoder.convert(workout));
          await activeBox.close();
          return workout;
        } else {
          final workoutLazyBox =
              await Hive.openLazyBox<String>(finishedWorkoutBoxName);
          await workoutLazyBox.put(dateTimeKey, encoder.convert(workout));
          await activeBox.delete('workout');
          await workoutLazyBox.close();
          await activeBox.close();
          return workout;
        }
      }
    }
    activeBox.close();

    // check in other box
    final workoutLazyBox =
        await Hive.openLazyBox<String>(finishedWorkoutBoxName);

    final jsonWorkout = await workoutLazyBox.get(dateTimeKey);
    if (jsonWorkout != null) {
      final existingWorkout = WorkoutModel.fromJson(jsonDecode(jsonWorkout));
      if (existingWorkout.start == workout.start &&
          existingWorkout.activity == workout.activity) {
        await workoutLazyBox.put(dateTimeKey, encoder.convert(workout));
        await workoutLazyBox.close();
        return workout;
      }
    }

    // didn't find one
    workoutLazyBox.close();
    throw CacheException();
  }
}
