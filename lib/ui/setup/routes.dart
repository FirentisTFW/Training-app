import 'package:training_app/screens/client_profile_screen.dart';
import 'package:training_app/screens/client_statistics_screen.dart';
import 'package:training_app/screens/clients_screen.dart';
import 'package:training_app/screens/done_workouts_screen.dart';
import 'package:training_app/screens/edit_workout_program_screen.dart';
import 'package:training_app/screens/edit_workout_screen.dart';
import 'package:training_app/screens/measurements_screen.dart';
import 'package:training_app/screens/new_client_screen.dart';
import 'package:training_app/screens/new_measurement_screen.dart';
import 'package:training_app/screens/new_workout_program_screen.dart';
import 'package:training_app/screens/new_workout_screen.dart';
import 'package:training_app/screens/program_exercises_screen.dart';
import 'package:training_app/screens/statistics_screen.dart';
import 'package:training_app/screens/workout_details_screen.dart';
import 'package:training_app/screens/workout_programs_screen.dart';

final routes = {
  '/': (ctx) => ClientsScreen(),
  NewClientScreen.routeName: (ctx) => NewClientScreen(),
  StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
  ClientProfileScreen.routeName: (ctx) => ClientProfileScreen(),
  WorkoutProgramsScreen.routeName: (ctx) => WorkoutProgramsScreen(),
  ProgramExercisesScreen.routeName: (ctx) => ProgramExercisesScreen(),
  DoneWorkoutScreen.routeName: (ctx) => DoneWorkoutScreen(),
  WorkoutDetailsScreen.routeName: (ctx) => WorkoutDetailsScreen(),
  NewWorkoutScreen.routeName: (ctx) => NewWorkoutScreen(),
  NewWorkoutProgramScreen.routeName: (ctx) => NewWorkoutProgramScreen(),
  EditWorkoutScreen.routeName: (ctx) => EditWorkoutScreen(),
  EditWorkoutProgramScreen.routeName: (ctx) => EditWorkoutProgramScreen(),
  MeasurementsScreen.routeName: (ctx) => MeasurementsScreen(),
  NewMeasurementScreen.routeName: (ctx) => NewMeasurementScreen(),
  ClientStatisticsScreen.routeName: (ctx) => ClientStatisticsScreen(),
};
