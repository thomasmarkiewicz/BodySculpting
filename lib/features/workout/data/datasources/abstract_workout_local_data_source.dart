import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:meta/meta.dart';

abstract class AbstractWorkoutLocalDataSource {
  Future<WorkoutModel> createWorkout(WorkoutModel workout);
  Future<WorkoutModel> updateWorkout(WorkoutModel workout);
  Future<List<WorkoutSummaryModel>> getWorkoutSummaries({
    @required DateTime start,
    @required DateTime end,
  });
  Future<Workout> getWorkout({
    @required DateTime start,
    @required Activity activity,
  });
  Future<Workout> deleteWorkout({
    @required DateTime start,
    @required DateTime end,
    @required Activity activity,
  });
}
