import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/screens/program_exercises_screen.dart';

import './providers/clients.dart';
import './providers/workout_programs.dart';
import './screens/add_client_screen.dart';
import './screens/client_profile_screen.dart';
import './screens/clients_screen.dart';
import './screens/statistics_screen.dart';
import './screens/workout_programs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Clients(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutPrograms(),
        ),
      ],
      child: MaterialApp(
        title: 'Training App',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey[800],
          accentColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ClientsScreen(),
          StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
          AddClientScreen.routeName: (ctx) => AddClientScreen(),
          ClientProfileScreen.routeName: (ctx) => ClientProfileScreen(),
          WorkoutProgramsScreen.routeName: (ctx) => WorkoutProgramsScreen(),
          ProgramExercisesScreen.routeName: (ctx) => ProgramExercisesScreen(),
        },
      ),
    );
  }
}
