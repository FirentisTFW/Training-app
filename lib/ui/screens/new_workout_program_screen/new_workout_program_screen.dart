import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/services/program_creator.dart';
import 'package:training_app/ui/screens/new_workout_program_screen/components/name_program.dart';

import '../../universal_components/program_exercises_list.dart';

class NewWorkoutProgramScreen extends StatefulWidget {
  static const routeName = '/new-workout-program';

  @override
  _NewWorkoutProgramScreenState createState() =>
      _NewWorkoutProgramScreenState();
}

class _NewWorkoutProgramScreenState extends State<NewWorkoutProgramScreen> {
  final GlobalKey<ProgramExercisesListState> _exercisesListKey = GlobalKey();
  ProgramCreator _programCreator;
  var _isNameGiven = false;
  String _clientId;

  @override
  void initState() {
    super.initState();

    _programCreator =
        ProgramCreator(Provider.of<WorkoutPrograms>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    _clientId = clientId;

    return Scaffold(
      appBar: AppBar(
        title: !_isNameGiven
            ? const Text('Name a program')
            : const Text('Add exercises'),
      ),
      body: !_isNameGiven
          ? NameProgram(clientId, nameProgram)
          : ProgramExercisesList(
              key: _exercisesListKey,
              programCreator: _programCreator,
            ),
      floatingActionButton: !_isNameGiven
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
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  backgroundColor: Colors.grey[600],
                  onPressed: _addAnotherExercise,
                ),
              ),
            ),
    );
  }

  void nameProgram(String name) {
    _programCreator.initialiseProgram(clientId: _clientId, name: name);

    setState(() => _isNameGiven = true);
  }

  void _addAnotherExercise() =>
      _exercisesListKey.currentState.addAnotherExercise();
}
