import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/setup/routes.dart';
import 'package:training_app/ui/setup/themes.dart';

import './providers/clients.dart';
import './providers/workout_programs.dart';
import './providers/workouts.dart';
import './providers/measurements.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider(
          create: (_) => Workouts(),
        ),
        ChangeNotifierProvider(
          create: (_) => Measurements(),
        ),
      ],
      child: MaterialApp(
        title: 'Training App',
        theme: customTheme,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
