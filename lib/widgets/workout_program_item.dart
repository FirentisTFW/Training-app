import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:training_app/screens/program_exercises_screen.dart';
import 'package:training_app/widgets/pop_up_menu.dart';

import '../providers/workout_programs.dart';

class WorkoutProgramItem extends StatefulWidget {
  final String clientId;
  final String name;
  final int exercisesNumber;
  final int setsNumber;

  WorkoutProgramItem({
    this.clientId,
    this.name,
    this.exercisesNumber,
    this.setsNumber,
  });

  @override
  _WorkoutProgramItemState createState() => _WorkoutProgramItemState();
}

class _WorkoutProgramItemState extends State<WorkoutProgramItem> {
  Offset _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showPopUpMenuAndChooseOption() async {
    final chosenOption =
        await PopUpMenu.createPopUpMenuAndChooseOption(context, _tapPosition);
    if (chosenOption == 'delete') {
      await _deleteWorkoutProgram();
    } else if (chosenOption == 'edit') {
      // edit
    }
  }

  Future<void> _deleteWorkoutProgram() async {
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.deleteProgram(
        clientId: widget.clientId, programName: widget.name);
    await workoutProgramsProvider.writeToFile();
    _displayMessage('Program deleted.');
  }

  void _displayMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProgramExercisesScreen.routeName,
          arguments: {
            'name': widget.name,
            'clientId': widget.clientId,
          },
        );
      },
      onTapDown: _storePosition,
      onLongPress: _showPopUpMenuAndChooseOption,
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Exercises: ${widget.exercisesNumber.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Sets: ${widget.setsNumber.toString()}',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
