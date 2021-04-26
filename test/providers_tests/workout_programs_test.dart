import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/models/exercise.dart';
import 'package:training_app/models/workout_program.dart';
import 'package:training_app/providers/workout_programs.dart';

class WorkoutProgramsSpy extends WorkoutPrograms {
  final WorkoutProgramsMock programsMock;

  WorkoutProgramsSpy(this.programsMock);

  @override
  Future<String> readDataFromFile() async => programsMock.readDataFromFile();
}

class WorkoutProgramsMock extends Mock {
  Future<String> readDataFromFile();
}

void main() {
  WorkoutProgramsSpy workoutPrograms;
  WorkoutProgramsMock programsMock;

  setUp(() {
    programsMock = WorkoutProgramsMock();
    workoutPrograms = WorkoutProgramsSpy(programsMock);
  });

  group('WorkoutProgramsTest -', () {
    group('fetchWorkoutPrograms -', () {
      test(
          'When returns a String, values are assigned to _workoutPrograms variable',
          () async {
        when(programsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
            '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

        await workoutPrograms.fetchWorkoutPrograms();

        expect(workoutPrograms.workoutPrograms.length, 2);
        expect(workoutPrograms.workoutPrograms, _expectedFetchedPrograms);
      });
      test('When throws an Exception, _workoutPrograms variable is empty',
          () async {
        when(programsMock.readDataFromFile())
            .thenThrow(Exception('An exception occured'));

        try {
          await workoutPrograms.fetchWorkoutPrograms();
        } catch (_) {}

        expect(workoutPrograms.workoutPrograms, []);
      });
    });
    test('findByClientId() works properly', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      final clientPrograms = workoutPrograms.findByClientId('1');

      expect(clientPrograms.length, 2);
      expect(clientPrograms[0], _expectedFetchedPrograms[0]);
      expect(clientPrograms[1], _expectedFetchedPrograms[0]);
    });
    group('When workout programs had been fetched successfully -', () {
      setUp(() async {
        when(programsMock.readDataFromFile()).thenAnswer((_) async =>
            '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
            '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

        await workoutPrograms.fetchWorkoutPrograms();
      });

      test('findByProgramNameAndClientId() works properly', () async {
        final program =
            workoutPrograms.findByProgramNameAndClientId('PULL', '1');

        expect(program, _expectedFetchedPrograms[0]);
      });

      test('findByProgramNameAndClientId() works properly', () async {
        final program =
            workoutPrograms.findByProgramNameAndClientId('PULL', '1');

        expect(program, _expectedFetchedPrograms[0]);
      });
      test('addProgram() works properly', () async {
        workoutPrograms.addProgram(_programToAdd);

        expect(workoutPrograms.workoutPrograms.length, 3);
        expect(workoutPrograms.workoutPrograms[2], _programToAdd);
      });
      test('updateProgram() works properly', () async {
        workoutPrograms.updateProgram("1", "PULL", _updatedExercises);

        expect(workoutPrograms.workoutPrograms[0],
            _expectedFetchedPrograms[0].copyWith(exercises: _updatedExercises));
      });
      test('deleteProgram', () async {
        workoutPrograms.deleteProgram(clientId: "1", programName: "PULL");

        expect(workoutPrograms.workoutPrograms.length, 1);
        expect(workoutPrograms.workoutPrograms[0], _expectedFetchedPrograms[1]);
      });
    });
  });
}

final _expectedFetchedPrograms = [
  WorkoutProgram(
    clientId: '1',
    name: 'PULL',
    exercises: [
      Exercise(
        id: 'E1',
        name: 'Pull ups',
        exerciseType: ExerciseType.ForRepetitions,
        sets: 4,
        repsMin: 8,
        repsMax: 12,
      ),
      Exercise(
        id: 'E2',
        name: 'Australian Pull ups',
        exerciseType: ExerciseType.ForRepetitions,
        sets: 4,
        repsMin: 8,
        repsMax: 12,
      ),
    ],
  ),
  WorkoutProgram(
    clientId: '2',
    name: 'PUSH',
    exercises: [
      Exercise(
        id: 'E1',
        name: 'Push ups',
        exerciseType: ExerciseType.ForRepetitions,
        sets: 4,
        repsMin: 8,
        repsMax: 12,
      ),
      Exercise(
        id: 'E2',
        name: 'Dips',
        exerciseType: ExerciseType.ForRepetitions,
        sets: 4,
        repsMin: 8,
        repsMax: 12,
      ),
    ],
  ),
];

final _programToAdd = WorkoutProgram(
  clientId: '1',
  name: 'PUSH',
  exercises: [
    Exercise(
      id: 'E1',
      name: 'Push ups',
      exerciseType: ExerciseType.ForRepetitions,
      sets: 4,
      repsMin: 8,
      repsMax: 12,
    ),
    Exercise(
      id: 'E2',
      name: 'Dips',
      exerciseType: ExerciseType.ForRepetitions,
      sets: 4,
      repsMin: 8,
      repsMax: 12,
    ),
  ],
);

final _updatedExercises = [
  Exercise(
    id: 'E10',
    name: 'Push ups',
    exerciseType: ExerciseType.ForRepetitions,
    sets: 4,
    repsMin: 8,
    repsMax: 12,
  ),
  Exercise(
    id: 'E20',
    name: 'Dips',
    exerciseType: ExerciseType.ForRepetitions,
    sets: 4,
    repsMin: 8,
    repsMax: 12,
  ),
];
