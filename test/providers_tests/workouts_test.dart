import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/models/exercise.dart';
import 'package:training_app/models/workout.dart';
import 'package:training_app/providers/workouts.dart';

class WorkoutsSpy extends Workouts {
  final WorkoutsMock workoutsMock;

  WorkoutsSpy(this.workoutsMock);

  @override
  Future<String> readDataFromFile() async => workoutsMock.readDataFromFile();
}

class WorkoutsMock extends Mock {
  Future<String> readDataFromFile();
}

void main() {
  WorkoutsSpy workouts;
  WorkoutsMock workoutsMock;

  setUp(() {
    workoutsMock = WorkoutsMock();
    workouts = WorkoutsSpy(workoutsMock);
  });

  group('WorkoutsTest -', () {
    group('fetchWorkouts -', () {
      test('When returns a String, values are assigned to _workouts variable',
          () async {
        when(workoutsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"W1","clientId":"1","date":"2021-01-02T00:00:00.000","programName":"PULL","exercises":[{"name":"Pull Ups","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Australian Pull Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]},'
            '{"id":"W2","clientId":"2","date":"2021-01-05T00:00:00.000","programName":"PUSH","exercises":[{"name":"Dips","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Push Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]}]');

        await workouts.fetchWorkouts();

        expect(workouts.workouts.length, 2);
        expect(workouts.workouts, _expetedFetchedWorkouts);
      });
      test('When throws an Exception, _workouts variable is empty', () async {
        when(workoutsMock.readDataFromFile())
            .thenThrow(Exception('An exception occured'));

        try {
          await workouts.fetchWorkouts();
        } catch (_) {}

        expect(workouts.workouts, []);
      });
    });

    group('When workouts had been fetched successfully -', () {
      setUp(() async {
        when(workoutsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"W1","clientId":"1","date":"2021-01-02T00:00:00.000","programName":"PULL","exercises":[{"name":"Pull Ups","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Australian Pull Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]},'
            '{"id":"W2","clientId":"2","date":"2021-01-05T00:00:00.000","programName":"PUSH","exercises":[{"name":"Dips","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Push Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]}]');

        await workouts.fetchWorkouts();
      });
      test('findByClientId() works properly', () async {
        when(workoutsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"id":"W1","clientId":"1","date":"2021-01-02T00:00:00.000","programName":"PULL","exercises":[{"name":"Pull Ups","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Australian Pull Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]},'
            '{"id":"W2","clientId":"1","date":"2021-01-05T00:00:00.000","programName":"PUSH","exercises":[{"name":"Dips","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Push Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]},'
            '{"id":"W2","clientId":"2","date":"2021-01-05T00:00:00.000","programName":"PUSH","exercises":[{"name":"Dips","sets":[{"reps":10,"weight":0,"exerciseType":"ForRepetitions"},{"reps":10,"weight":0,"exerciseType":"ForRepetitions"}]},{"name":"Push Ups","sets":[{"reps":15,"weight":0,"exerciseType":"ForRepetitions"},{"reps":15,"weight":0,"exerciseType":"ForRepetitions"}]}]}]');

        await workouts.fetchWorkouts();
        final clientWorkouts = workouts.findByClientId('1');

        expect(clientWorkouts.length, 2);
        expect(clientWorkouts, _expectedClientWorkouts);
      });

      test('findById() works properly', () async {
        expect(workouts.findById('W1'), _expetedFetchedWorkouts[0]);
      });

      test('updateWorkout() works properly', () async {
        workouts.updateWorkout('W1', [
          WorkoutExercise(name: 'Pull Ups', sets: [
            Set(
              exerciseType: ExerciseType.ForRepetitions,
              reps: 10,
              weight: 0,
            ),
            Set(
              exerciseType: ExerciseType.ForRepetitions,
              reps: 10,
              weight: 0,
            ),
          ])
        ]);

        expect(workouts.findById('W1'), _expectedUpdatedWorkout);
      });
      test('deleteWorkout() works properly', () async {
        workouts.deleteWorkout('W1');

        expect(workouts.workouts.length, 1);
        expect(workouts.workouts, [_expetedFetchedWorkouts[1]]);
      });
    });
  });
}

final _expetedFetchedWorkouts = [
  Workout(
    id: 'W1',
    clientId: '1',
    date: DateTime(2021, 01, 02),
    programName: 'PULL',
    exercises: [
      WorkoutExercise(name: 'Pull Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
      ]),
      WorkoutExercise(name: 'Australian Pull Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
      ]),
    ],
  ),
  Workout(
    id: 'W2',
    clientId: '2',
    date: DateTime(2021, 01, 05),
    programName: 'PUSH',
    exercises: [
      WorkoutExercise(name: 'Dips', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
      ]),
      WorkoutExercise(name: 'Push Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
      ]),
    ],
  ),
];

final _expectedClientWorkouts = [
  Workout(
    id: 'W1',
    clientId: '1',
    date: DateTime(2021, 01, 02),
    programName: 'PULL',
    exercises: [
      WorkoutExercise(name: 'Pull Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
      ]),
      WorkoutExercise(name: 'Australian Pull Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
      ]),
    ],
  ),
  Workout(
    id: 'W2',
    clientId: '1',
    date: DateTime(2021, 01, 05),
    programName: 'PUSH',
    exercises: [
      WorkoutExercise(name: 'Dips', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 10,
          weight: 0,
        ),
      ]),
      WorkoutExercise(name: 'Push Ups', sets: [
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
        Set(
          exerciseType: ExerciseType.ForRepetitions,
          reps: 15,
          weight: 0,
        ),
      ]),
    ],
  ),
];

final _expectedUpdatedWorkout = Workout(
  id: 'W1',
  clientId: '1',
  date: DateTime(2021, 01, 02),
  programName: 'PULL',
  exercises: [
    WorkoutExercise(name: 'Pull Ups', sets: [
      Set(
        exerciseType: ExerciseType.ForRepetitions,
        reps: 10,
        weight: 0,
      ),
      Set(
        exerciseType: ExerciseType.ForRepetitions,
        reps: 10,
        weight: 0,
      ),
    ]),
  ],
);
