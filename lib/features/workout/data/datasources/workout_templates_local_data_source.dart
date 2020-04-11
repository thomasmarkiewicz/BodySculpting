import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';

import 'abstract_json_local_data_source.dart';
import 'abstract_workout_templates_local_data_source.dart';

class RoutineLocalDataSource implements AbstractRoutineLocalDataSource {
  final AbstractJsonLocalDataSource jsonLocalDataSource;

  RoutineLocalDataSource(this.jsonLocalDataSource);

  Future<List<WorkoutModel>> getRoutines(Activity activity) async {
    final document = await jsonLocalDataSource.readDocument();
    final routines =
        document.routines.where((r) => r.activity == activity).toList();
    return routines;
  }
}
