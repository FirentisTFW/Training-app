class Workout {
  final String id;
  final String clientId;
  final DateTime date;
  final String programName;
  final List<WorkoutExercise> exercises;

  Workout({
    this.id,
    this.clientId,
    this.date,
    this.programName,
    this.exercises,
  });
}

class WorkoutExercise {
  final String name;
  final List<Set> sets;

  WorkoutExercise(
    this.name,
    this.sets,
  );
}

class Set {
  final int reps;
  final int weight;

  Set({
    this.reps,
    this.weight,
  });
}
