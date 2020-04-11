import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:hive/hive.dart';
import 'abstract_routine_local_data_source.dart';

class HiveRoutineLocalDataSource implements AbstractRoutineLocalDataSource {
  /// returns all routines for a given activity
  Future<List<WorkoutModel>> getRoutines(Activity activity) async {
    final box = await Hive.openBox('routines');

    for (final routine in box.values) {
      print(routine);
    }
  }
}
