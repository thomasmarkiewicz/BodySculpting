import 'dart:convert';
import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'abstract_workout_local_data_source.dart';

// I need a strategy for the boxes
/*

active workout is store in "active" box with key "workout"

workouts are stored in various boxes based on year and activity
year so that their size is capped 
activity because those will likely end up as different models

so the name of the box is build from the workout info:

`workout_${year}_${activity}`

*/

class HiveWorkoutLocalDataSource implements AbstractWorkoutLocalDataSource {
  get activity => null;

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
    final activityPart = activity.toString();

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
    if (jsonActiveWorkout != null) {
      final workout = WorkoutModel.fromJson(jsonDecode(jsonActiveWorkout));
      if (workout.start == some(start) && workout.activity == activity) {
        return workout;
      }
    }

    // check in other box
    final dateTimeKey = DateFormat('yyyyMMdd-kkmmss').format(start);
    final yearPart = DateFormat('yyyy').format(start);
    final activityPart = activity.toString();
    final workoutLazyBox =
        await Hive.openLazyBox<String>('workout_${yearPart}_$activityPart');

    final jsonWorkout = await workoutLazyBox.get(dateTimeKey);
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
        final activityPart = activity.toString();
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
      }
    }

    return summaries;
  }

  @override
  Future<WorkoutModel> updateWorkout(WorkoutModel workout) async {
    final encoder = JsonEncoder.withIndent("   ");

    // TODO: at some point I need to delete from the 'active' box
    //       when updating an active workout to finished???

    // check in active
    final activeBox = await Hive.openBox<String>('active');
    final jsonActiveWorkout = activeBox.get('workout');
    if (jsonActiveWorkout != null) {
      final existingWorkout =
          WorkoutModel.fromJson(jsonDecode(jsonActiveWorkout));
      if (existingWorkout.start == workout.start &&
          existingWorkout.activity == workout.activity) {
        await activeBox.put('workout', encoder.convert(workout));
        await activeBox.close();
        return workout;
      }
    }

    // check in other box
    final startDateTime = workout.start.getOrElse(() => throw CacheException());
    final dateTimeKey = DateFormat('yyyyMMdd-kkmmss').format(startDateTime);
    final yearPart = DateFormat('yyyy').format(startDateTime);
    final activityPart = activity.toString();
    final workoutLazyBox =
        await Hive.openLazyBox<String>('workout_${yearPart}_$activityPart');

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
    throw CacheException();
  }
}
