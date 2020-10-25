import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/confirmation.dart';
import '../models/workout_program.dart';
import 'package:training_app/screens/program_exercises_screen.dart';
import 'package:training_app/screens/edit_workout_program_screen.dart';
import 'package:training_app/widgets/pop_up_menu.dart';

import '../providers/workout_programs.dart';

class WorkoutProgramItem extends StatefulWidget {
  final WorkoutProgram workoutProgram;

  WorkoutProgramItem({
    @required this.workoutProgram,
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
      _editProgram();
    }
  }

  Future<void> _deleteWorkoutProgram() async {
    if (!await _confirmDeletion()) {
      return;
    }

    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.deleteProgram(
        clientId: widget.workoutProgram.clientId,
        programName: widget.workoutProgram.name);
    await workoutProgramsProvider.writeToFile();
    Confirmation.displayMessage('Program deleted.', context);
  }

  Future<bool> _confirmDeletion() async {
    return await Confirmation.confirmationDialog(context);
  }

  void _editProgram() {
    Navigator.of(context).pushNamed(
      EditWorkoutProgramScreen.routeName,
      arguments: widget.workoutProgram,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProgramExercisesScreen.routeName,
          arguments: {
            'name': widget.workoutProgram.name,
            'clientId': widget.workoutProgram.clientId,
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
                    widget.workoutProgram.name,
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
                      'Exercises: ${widget.workoutProgram.exercises.length.toString()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Sets: ${widget.workoutProgram.calculateTotalNumberOfSets().toString()}',
                      style: const TextStyle(fontSize: 18),
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
