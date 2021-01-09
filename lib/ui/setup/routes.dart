import 'package:training_app/ui/screens/client_profile_screen/client_profile_screen.dart';
import 'package:training_app/ui/screens/client_statistics_screen/client_statistics_screen.dart';
import 'package:training_app/ui/screens/clients_screen/clients_screen.dart';
import 'package:training_app/ui/screens/completed_workouts_screen/completed_workouts_screen.dart';
import 'package:training_app/ui/screens/edit_workout_program_screen/edit_workout_program_screen.dart';
import 'package:training_app/ui/screens/edit_workout_screen/edit_workout_screen.dart';
import 'package:training_app/ui/screens/measurements_screen/measurements_screen.dart';
import 'package:training_app/ui/screens/new_client_screen/new_client_screen.dart';
import 'package:training_app/ui/screens/new_measurements_session_screen/new_measurement_session_screen.dart';
import 'package:training_app/ui/screens/new_workout_program_screen/new_workout_program_screen.dart';
import 'package:training_app/ui/screens/new_workout_screen/new_workout_screen.dart';
import 'package:training_app/ui/screens/program_details_screen/program_details_screen.dart';
import 'package:training_app/ui/screens/statistics_screen/statistics_screen.dart';
import 'package:training_app/ui/screens/workout_details_screen/workout_details_screen.dart';
import 'package:training_app/ui/screens/workout_programs_screen/workout_programs_screen.dart';

final routes = {
  '/': (ctx) => ClientsScreen(),
  NewClientScreen.routeName: (ctx) => NewClientScreen(),
  StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
  ClientProfileScreen.routeName: (ctx) => ClientProfileScreen(),
  WorkoutProgramsScreen.routeName: (ctx) => WorkoutProgramsScreen(),
  ProgramDetailsScreen.routeName: (ctx) => ProgramDetailsScreen(),
  CompletedWorkoutScreen.routeName: (ctx) => CompletedWorkoutScreen(),
  WorkoutDetailsScreen.routeName: (ctx) => WorkoutDetailsScreen(),
  NewWorkoutScreen.routeName: (ctx) => NewWorkoutScreen(),
  NewWorkoutProgramScreen.routeName: (ctx) => NewWorkoutProgramScreen(),
  EditWorkoutScreen.routeName: (ctx) => EditWorkoutScreen(),
  EditWorkoutProgramScreen.routeName: (ctx) => EditWorkoutProgramScreen(),
  MeasurementsScreen.routeName: (ctx) => MeasurementsScreen(),
  NewMeasurementSessionScreen.routeName: (ctx) => NewMeasurementSessionScreen(),
  ClientStatisticsScreen.routeName: (ctx) => ClientStatisticsScreen(),
};
