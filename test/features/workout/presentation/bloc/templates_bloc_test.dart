import 'package:bloc_test/bloc_test.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_routines.dart';
import 'package:bodysculpting/features/workout/presentation/pages/templates/templates_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetWorkoutTemplates extends Mock implements GetRoutines {}

void main() {
  TemplatesBloc bloc;
  MockGetWorkoutTemplates mockGetWorkoutTemplates;

  setUp(() {
    mockGetWorkoutTemplates = MockGetWorkoutTemplates();
    bloc = TemplatesBloc(getWorkoutTemplates: mockGetWorkoutTemplates);
  });

  test('initial state should be Empty', () {
    expect(bloc.initialState, Empty());
  });

  group('GetWorkouts', () {
    final testActivity = Activity.lift;
    final testTemplates = [
      Workout(
          activity: Activity.lift,
          name: "Barbbell Lifts 5x5 A",
          description: some("Squat, Bench, Deadlift"),
          units: UnitsModel(weight: "lb", distance: "km"),
          supersets: [
            [
              ExerciseSet(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    Set(targetReps: 5, targetRest: 180),
                  ])
            ],
          ]),
      Workout(
          activity: Activity.lift,
          name: "Barbbell Lifts 5x5 B",
          description: some("Squat, Shoulder Press, Rows"),
          units: UnitsModel(weight: "lb", distance: "km"),
          supersets: [
            [
              ExerciseSet(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    Set(targetReps: 5, targetRest: 180),
                  ])
            ],
          ]),
    ];

    blocTest(
      'should call concrete usecase to get the workout templates',
      build: () async {
        when(mockGetWorkoutTemplates(any))
            .thenAnswer((_) async => Right(testTemplates));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTemplates(testActivity)),
      verify: (bloc) {
        verify(mockGetWorkoutTemplates(Params(activity: testActivity)));
        return;
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when data is retrieved successfully',
      build: () async {
        when(mockGetWorkoutTemplates(any))
            .thenAnswer((_) async => Right(testTemplates));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTemplates(testActivity)),
      expect: [
        Loading(),
        Loaded(testTemplates),
      ],
    );

    blocTest(
      'should emit [Loading, Error] when data is retrieved successfully',
      build: () async {
        when(mockGetWorkoutTemplates(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTemplates(testActivity)),
      expect: [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ],
    );
  });
}
