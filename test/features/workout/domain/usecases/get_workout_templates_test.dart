import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_routine_repository.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_routines.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutTemplateRepository extends Mock
    implements AbstractRoutineRepository {}

void main() {
  MockWorkoutTemplateRepository mockRepository;
  GetRoutines getWorkoutTemplates;

  setUp(() {
    mockRepository = MockWorkoutTemplateRepository();
    getWorkoutTemplates = GetRoutines(mockRepository);
  });

  final tActivity = Activity.lift;
  final tWorkoutTemplates = [
    Workout(
      routineId: "1",
      name: 'Barbbell Lifts 3x10 A',
      activity: Activity.lift,
      description: some('Squat, bench, deadlift'),
      units: Units(weight: 'lb', distance: 'mi'),
      supersets: null,
    ),
  ];

  test('gets workout templates from the repository', () async {
    // setup
    when(mockRepository.getRoutines(any))
        .thenAnswer((_) async => Right(tWorkoutTemplates));

    // test
    final result = await getWorkoutTemplates(Params(activity: tActivity));

    // check
    expect(result, Right(tWorkoutTemplates));
    verify(mockRepository.getRoutines(tActivity));
    verifyNoMoreInteractions(mockRepository);
  });
}
