import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';

abstract class AbstractRoutineLocalDataSource {
  Future<List<WorkoutModel>> getRoutines(Activity activity);
}
