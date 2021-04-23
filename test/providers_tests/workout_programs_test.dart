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

  final programsList = [
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

  setUp(() {
    programsMock = WorkoutProgramsMock();
    workoutPrograms = WorkoutProgramsSpy(programsMock);
  });

  group('WorkoutProgramsTest -', () {
    test('fetchWorkoutPrograms() fetches data correctly', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();

      expect(workoutPrograms.workoutPrograms.length, 2);
      expect(workoutPrograms.workoutPrograms, programsList);
    });
    test('findByClientId() works properly', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      final clientPrograms = workoutPrograms.findByClientId('1');

      expect(clientPrograms.length, 2);
      expect(clientPrograms[0], programsList[0]);
      expect(clientPrograms[1], programsList[0]);
    });
    test('findByProgramNameAndClientId() works properly', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      final program = workoutPrograms.findByProgramNameAndClientId('PULL', '1');

      expect(program, programsList[0]);
    });
    test('findByProgramNameAndClientId() works properly', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      final program = workoutPrograms.findByProgramNameAndClientId('PULL', '1');

      expect(program, programsList[0]);
    });
    test('addProgram() works properly', () async {
      final programToAdd = WorkoutProgram(
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

      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      workoutPrograms.addProgram(programToAdd);

      expect(workoutPrograms.workoutPrograms.length, 3);
      expect(workoutPrograms.workoutPrograms[2], programToAdd);
    });
    test('updateProgram() works properly', () async {
      final newExercises = [
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

      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      workoutPrograms.updateProgram("1", "PULL", newExercises);

      expect(workoutPrograms.workoutPrograms[0],
          programsList[0].copyWith(exercises: newExercises));
    });
    test('deleteProgram', () async {
      when(programsMock.readDataFromFile()).thenAnswer((_) async =>
          '[{"clientId":"1","name":"PULL","exercises":[{"id":"E1","name":"Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Australian Pull ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]},'
          '{"clientId":"2","name":"PUSH","exercises":[{"id":"E1","name":"Push ups","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12},{"id":"E2","name":"Dips","exerciseType":"ForRepetitions","sets":4,"repsMin":8,"repsMax":12}]}]');

      await workoutPrograms.fetchWorkoutPrograms();
      workoutPrograms.deleteProgram(clientId: "1", programName: "PULL");

      expect(workoutPrograms.workoutPrograms.length, 1);
      expect(workoutPrograms.workoutPrograms[0], programsList[1]);
    });
  });
}
