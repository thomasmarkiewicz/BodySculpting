import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'exercise_set.dart';

// A workout is identified by its 'start' DateTime (PK)
// There can exist only one workout that starts at a specific time
class Workout extends WorkoutSummary {
  final List<List<ExerciseSet>> supersets;

  @override
  List<Object> get props => [supersets];

  Workout({
    @required String routineId,
    @required String program,
    @required String name,
    @required Activity activity,
    @required Units units,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
    @required this.supersets,
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
        );

  Workout started() {
    return Workout(
      routineId: this.routineId,
      program: this.program,
      name: this.name,
      activity: this.activity,
      units: this.units,
      description: this.description,
      start: some(DateTime.now()),
      end: this.end,
      summary: this.summary,
      supersets: supersets,
    );
  }

  Workout finished() {
    return Workout(
      routineId: this.routineId,
      program: this.program,
      name: this.name,
      activity: this.activity,
      units: this.units,
      description: this.description,
      start: this.start,
      end: some(DateTime.now()),
      summary: this.summary,
      supersets: supersets,
    );
  }

  // TODO: write a test for this
  Workout updateReps({
    @required int supersetIndex,
    @required int exerciseSetIndex,
    @required int repIndex,
  }) {
    final supersets = List<List<ExerciseSet>>();
    if (this.supersets != null) {
      this.supersets.asMap().forEach((ii, ss) {
        if (ii == supersetIndex) {
          final superset = List.of(ss
              .asMap()
              .map((i, s) => (i == exerciseSetIndex)
                  ? MapEntry(i, s.toggleRep(repIndex))
                  : MapEntry(i, s))
              .values);
          supersets.add(superset);
        } else {
          supersets.add(ss);
        }
      });
    }

    return Workout(
      routineId: this.routineId,
      program: this.program,
      name: this.name,
      activity: this.activity,
      units: this.units,
      description: this.description,
      start: this.start.orElse(() => some(DateTime.now())),
      end: this.end,
      summary: this.summary,
      supersets: supersets,
    );
  }

  // TODO: write a test for this
  Workout updateTargetWeight({
    @required int supersetIndex,
    @required int exerciseSetIndex,
    @required int weight,
  }) {
    final supersets = List<List<ExerciseSet>>();
    if (this.supersets != null) {
      this.supersets.asMap().forEach((ii, ss) {
        if (ii == supersetIndex) {
          final superset = List.of(ss
              .asMap()
              .map((i, s) => (i == exerciseSetIndex)
                  ? MapEntry(
                      i,
                      s.updateTargetWeight(
                          weight)) // TODO: refactor? this is the only line that is different then in the method above
                  : MapEntry(i, s))
              .values);
          supersets.add(superset);
        } else {
          supersets.add(ss);
        }
      });
    }

    return Workout(
      routineId: this.routineId,
      program: this.program,
      name: this.name,
      activity: this.activity,
      units: this.units,
      description: this.description,
      start: this.start.orElse(() => some(DateTime.now())),
      end: this.end,
      summary: this.summary,
      supersets: supersets,
    );
  }
}
