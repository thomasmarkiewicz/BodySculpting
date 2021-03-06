import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';

final routines = [
  WorkoutModel(
    routineId: "ca265cd00526",
    program: "5x5 Barbbell Lifts",
    activity: Activity.lift,
    name: "5x5 Barbbell Lifts A",
    description: some("Squat, Bench, Deadlift"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "0537cd19644c",
          exerciseName: "Squats",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "33871bf6de60",
          exerciseName: "Bench Press",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ca1240b16dab",
          exerciseName: "Deadlifts",
          targetWeight: 45,
          sets: [SetModel(targetReps: 5, targetRest: 180)],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "8af1feb9836e",
    program: "5x5 Barbbell Lifts",
    activity: Activity.lift,
    name: "5x5 Barbbell Lifts B",
    description: some("Squat, Shoulder Press, Rows"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "0537cd19644c",
          exerciseName: "Squats",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "7eef10e8aaed",
          exerciseName: "Shoulder Press",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "056672996981",
          exerciseName: "Rows",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180),
            SetModel(targetReps: 5, targetRest: 180)
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "6010b44796e6",
    program: "3x10 Barbbell Lifts",
    activity: Activity.lift,
    name: "3x10 Barbbell Lifts A",
    description: some("Squat, Bench, Deadlift"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "0537cd19644c",
          exerciseName: "Squats",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "33871bf6de60",
          exerciseName: "Bench Press",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ca1240b16dab",
          exerciseName: "Deadlifts",
          targetWeight: 45,
          sets: [SetModel(targetReps: 10, targetRest: 180)],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "5f536c2ddbf4",
    program: "3x10 Barbbell Lifts",
    activity: Activity.lift,
    name: "3x10 Barbbell Lifts B",
    description: some("Squat, Shoulder Press, Rows"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "0537cd19644c",
          exerciseName: "Squats",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "7eef10e8aaed",
          exerciseName: "Shoulder Press",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180)
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "056672996981",
          exerciseName: "Rows",
          targetWeight: 45,
          sets: [
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180),
            SetModel(targetReps: 10, targetRest: 180)
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "e6596d74fb9a",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets A",
    description: some(
        "Day 1 of dumbbell circuits with 90 second breaks after each exercise"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "3e904e0972c4",
          exerciseName: "Dumbbell Rows (one arm)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "19b420dafb22",
          exerciseName: "Push-ups",
          targetWeight: 0,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "490d6d0ec5f0",
          exerciseName: "Dumbbell Rows (two arms)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4bfc6352fcfb",
          exerciseName: "Dumbbell Flys (flat)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "fcea91c905fa",
          exerciseName: "Dumbbell Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4cab4ad2ce41",
          exerciseName: "Dumbbell Extensions (lying)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ebe07cb7b8a4",
          exerciseName: "Dumbbell Hammer Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "3febf26fdef2",
          exerciseName: "Dumbbell Extensions (overhead)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "70f4a484fc06",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets B",
    description: some(
        "Day 2 of dumbbell circuits with 90 second breaks after each exercise"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "7d6b7ce13c84",
          exerciseName: "Dumbbell Lunges",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats (ballet)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "bb69814ba53a",
          exerciseName: "Dumbbell Shoulder Press",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ca181a7a5d84",
          exerciseName: "Dumbbell Deadlifts",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "b9191529d1cc",
          exerciseName: "Dumbbell Bent Over Lateral Raises",
          targetWeight: 5,
          sets: [
            SetModel(targetReps: 15, targetRest: 90),
            SetModel(targetReps: 15, targetRest: 90),
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "7d881e8df9df",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets C",
    description: some(
        'Day 1 of dumbbell circuits with 60 second breaks after each circuit'),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "3e904e0972c4",
          exerciseName: "Dumbbell Rows (one arm)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "19b420dafb22",
          exerciseName: "Push-ups",
          targetWeight: 0,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "490d6d0ec5f0",
          exerciseName: "Dumbbell Rows (two arms)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4bfc6352fcfb",
          exerciseName: "Dumbbell Flys (flat)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "fcea91c905fa",
          exerciseName: "Dumbbell Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4cab4ad2ce41",
          exerciseName: "Dumbbell Extensions (lying)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ebe07cb7b8a4",
          exerciseName: "Dumbbell Hammer Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "3febf26fdef2",
          exerciseName: "Dumbbell Extensions (overhead)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "b1f5109a6f8a",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets D",
    description: some(
        "Day 2 of dumbbell circuits with 60 second breaks after each circuit"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "7d6b7ce13c84",
          exerciseName: "Dumbbell Lunges",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats (ballet)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "bb69814ba53a",
          exerciseName: "Dumbbell Shoulder Press",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "ca181a7a5d84",
          exerciseName: "Dumbbell Deadlifts",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
            SetModel(targetReps: 10, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "b9191529d1cc",
          exerciseName: "Dumbbell Bent Over Lateral Raises",
          targetWeight: 5,
          sets: [
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
            SetModel(targetReps: 10, targetRest: 60),
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "5652c00c5895",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets E",
    description: some(
        "Day 1 of heavier and longer circuits with 60 second break after each circuit"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "3e904e0972c4",
          exerciseName: "Dumbbell Rows (one arm)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "19b420dafb22",
          exerciseName: "Push-ups",
          targetWeight: 0,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "490d6d0ec5f0",
          exerciseName: "Dumbbell Rows (two arms)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4bfc6352fcfb",
          exerciseName: "Dumbbell Flys (flat)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "fcea91c905fa",
          exerciseName: "Dumbbell Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "4cab4ad2ce41",
          exerciseName: "Dumbbell Extensions (lying)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "ebe07cb7b8a4",
          exerciseName: "Dumbbell Hammer Curls",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "3febf26fdef2",
          exerciseName: "Dumbbell Extensions (overhead)",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
          ],
        ),
      ],
    ],
  ),
  WorkoutModel(
    routineId: "0912ba290464",
    program: "Dumbbell Supersets",
    activity: Activity.lift,
    name: "Dumbbell Supersets F",
    description: some(
        "Day 2 of heavier and longer circuits with 60 second break after each circuit"),
    units: UnitsModel(
      weight: "lb",
      distance: "mi",
    ),
    supersets: [
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "7d6b7ce13c84",
          exerciseName: "Dumbbell Lunges",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "bb69814ba53a",
          exerciseName: "Dumbbell Shoulder Press",
          targetWeight: 10,
          sets: [
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
          ],
        ),
      ],
      [
        ExerciseSetModel(
          exerciseId: "69ff1785ec1b",
          exerciseName: "Dumbbell Squats (ballet)",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "ca181a7a5d84",
          exerciseName: "Dumbbell Deadlifts",
          targetWeight: 20,
          sets: [
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
            SetModel(targetReps: 8, targetRest: 0),
          ],
        ),
        ExerciseSetModel(
          exerciseId: "b9191529d1cc",
          exerciseName: "Dumbbell Bent Over Lateral Raises",
          targetWeight: 5,
          sets: [
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
            SetModel(targetReps: 8, targetRest: 60),
          ],
        ),
      ],
    ],
  ),
];
