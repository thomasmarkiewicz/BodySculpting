import 'dart:convert';
import 'dart:io';
import 'package:bodysculpting/features/workout/data/datasources/abstract_json_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'stock_routines.dart' as stockRoutines;
import 'stock_exercises.dart' as stockExercises;

const String LOCAL_DOCUMENT_FILE_NAME = "bodysculpting.json";
const String LOCAL_WORKOUTS_DIRECTORY = "workouts";

class JsonLocalDataSource implements AbstractJsonLocalDataSource {
  Future<String> get _localPath async {
    //final directory = await getApplicationDocumentsDirectory();
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$LOCAL_DOCUMENT_FILE_NAME');
  }

  Future<String> get _localWorkoutsPath async {
    final path = await _localPath;
    return '$path/$LOCAL_WORKOUTS_DIRECTORY';
  }

  DocumentModel get _defaultDocumentModel => DocumentModel(
        version: "0.0.1",
        syncCounter: 0,
        exercises: stockExercises.exercises,
        routines: stockRoutines.routines,
      );

  Future<File> writeDocument(DocumentModel documentModel) async {
    final file = await _localFile;
    final encoder = JsonEncoder.withIndent("    ");
    return file.writeAsString(encoder.convert(documentModel));
  }

  Future<DocumentModel> readDocument() async {
    final file = await _localFile;
    try {
      String contents = await file.readAsString();
      return Future.value(DocumentModel.fromJson(jsonDecode(contents)));
    } on FileSystemException {
      writeDocument(_defaultDocumentModel);
      return Future.value(_defaultDocumentModel);
    }
  }

  @override
  Future<WorkoutModel> readWorkout(
      {DateTime start, Option<DateTime> end}) async {
    final file = await end.fold(
      () => _activeWorkoutFile(),
      (_) => _finishedWorkoutFile(start),
    );

    String contents = await file.readAsString();
    final workout = Future.value(WorkoutModel.fromJson(jsonDecode(contents)));
    return workout;
  }

  @override
  Future<WorkoutModel> writeWorkout(WorkoutModel workout) async {
    final file = await workout.end.fold(
      () => _activeWorkoutFile(),
      (_) => _finishedWorkoutFile(
        workout.start.getOrElse(() => throw FileSystemException()),
      ),
    );
    final encoder = JsonEncoder.withIndent("    ");
    await file.create(recursive: true);
    await file.writeAsString(encoder.convert(workout));

    // if we wrote a finished workout, delete active workout if it has the same start
    if (workout.isFinished()) {
      final activeFile = await _activeWorkoutFile();
      if (await activeFile.exists()) {
        String contents = await activeFile.readAsString();
        final activeWorkout = WorkoutModel.fromJson(jsonDecode(contents));
        if (activeWorkout.start == workout.start) {
          activeFile.delete();
        }
      }
    }

    return workout;
  }

  @override
  Future<WorkoutModel> deleteWorkout({DateTime start, DateTime end}) async {
    final finishedFile = await _finishedWorkoutFile(start);
    if (await finishedFile.exists()) {
      String contents = await finishedFile.readAsString();
      final workout = Future.value(WorkoutModel.fromJson(jsonDecode(contents)));
      await finishedFile.delete();
      return workout;
    } else {
      throw FileSystemException(); // workout to be deleted doesn't exit
    }
  }

  @override
  Future<bool> workoutExists({DateTime start}) async {
    final activeFile = await _activeWorkoutFile();
    final finishedFile = await _finishedWorkoutFile(start);
    return (await activeFile.exists()) || await finishedFile.exists();
  }

  Future<File> _finishedWorkoutFile(DateTime start) async {
    final year = start.year;
    final dateTime = DateFormat('yyyyMMdd-kkmmss').format(start);
    final workoutsDir = await _localWorkoutsPath;
    final workoutFile = File('$workoutsDir/$year/${dateTime}_workout.json');
    return workoutFile;
  }

  Future<File> _activeWorkoutFile() async {
    final workoutsDir = await _localWorkoutsPath;
    final workoutFile = File('$workoutsDir/active_workout.json');
    return workoutFile;
  }

  @override
  Future<List<WorkoutSummaryModel>> readWorkoutSummaries(
      {DateTime start, DateTime end}) async {
    // TODO: implement readWorkoutSummaries
    /*
    get active workout summary

    get list of all years betwee start:end dates and for each
      get a list of all file names in the year subfolders
      filter out those outside of start:end range
      read in each remaining file into a WorkoutSummaryModel appending to the growing list

    return the list of workout summaries
    */

    final workoutsDir = await _localWorkoutsPath;

    var summaries = List<WorkoutSummaryModel>();

    final activeWorkoutFile = await _activeWorkoutFile();
    if (await activeWorkoutFile.exists()) {
      String contents = await activeWorkoutFile.readAsString();
      final summary = WorkoutSummaryModel.fromJson(jsonDecode(contents));
      summaries.add(summary);
    }

    final count = end.year - start.year + 1;
    var years = new List<int>.generate(
      count,
      (i) => start.year + i,
    );

    for (final year in years) {
      final dir = Directory('$workoutsDir/$year');
      if (await dir.exists()) {
        var files = dir.listSync();
        for (final entity in files) {
          //files.forEach((entity) async {
          if (entity is File) {
            String contents = await entity.readAsString();
            final summary = WorkoutSummaryModel.fromJson(jsonDecode(contents));
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
}
