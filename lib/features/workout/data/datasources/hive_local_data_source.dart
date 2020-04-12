import 'dart:convert';
import 'package:hive/hive.dart';
import 'stock_routines.dart' as stockRoutines;
import 'stock_exercises.dart' as stockExercises;

class HiveLocalDataSource {
  // TODO: bump this version when anything in stock_* data files changed from previous release
  //       and add migration to update models
  static const int LATEST_HIVE_VERSION = 1;

  static Future<void> init() async {
    final box = await Hive.openBox('hive');
    if (box.isEmpty) {
      await createExercises();
      await createRoutines();
      box.put('version', LATEST_HIVE_VERSION);
    } else {
      final int currentVersion = box.get('version');
      switch (currentVersion) {
        case 1: // do nothing for now - but can run migrations in the future
          break;
      }
    }
  }

  static Future<void> createExercises() async {
    final lazyBox = await Hive.openLazyBox('exercises');
    if (lazyBox.isNotEmpty) return;

    final encoder = JsonEncoder.withIndent("   ");
    for (final exercise in stockExercises.exercises) {
      await lazyBox.put(exercise.id, encoder.convert(exercise));
    }

    await lazyBox.close();
  }

  static Future<void> createRoutines() async {
    final lazyBox = await Hive.openLazyBox('routines');
    if (lazyBox.isNotEmpty) return;

    final encoder = JsonEncoder.withIndent("   ");

    for (final routine in stockRoutines.routines) {
      await lazyBox.put(routine.routineId, encoder.convert(routine));
    }

    await lazyBox.close();
  }
}
