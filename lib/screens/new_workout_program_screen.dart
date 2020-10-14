import 'package:flutter/material.dart';
import 'package:training_app/widgets/name_program.dart';

import '../widgets/program_exercises_list.dart';

class NewWorkoutProgramScreen extends StatefulWidget {
  static const routeName = '/new-workout-program';

  @override
  _NewWorkoutProgramScreenState createState() =>
      _NewWorkoutProgramScreenState();
}

class _NewWorkoutProgramScreenState extends State<NewWorkoutProgramScreen> {
  final GlobalKey<ProgramExercisesListState> _exercisesListKey = GlobalKey();
  var wasNameGiven = false;

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    print("new-workout-program-screen");
    return Scaffold(
      appBar: AppBar(
        title: !wasNameGiven
            ? const Text('Name a program')
            : const Text('Add exercises'),
      ),
      body: !wasNameGiven
          ? NameProgram(clientId, nameWasGiven)
          : ProgramExercisesList(
              key: _exercisesListKey,
            ),
      floatingActionButton: !wasNameGiven
          ? null
          : Container(
              child: Align(
                alignment: Alignment(1.05, 0.85),
                child: FloatingActionButton.extended(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    'New exercise',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  backgroundColor: Colors.grey[600],
                  onPressed: () =>
                      _exercisesListKey.currentState.addAnotherExercise(),
                ),
              ),
            ),
    );
  }

  void nameWasGiven() {
    setState(() {
      wasNameGiven = true;
    });
  }
}
