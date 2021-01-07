import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';

import '../../../dialogs/confirmation.dart';
import '../../../../models/workout_program.dart';
import 'package:training_app/ui/screens/program_details_screen/program_details_screen.dart';
import 'package:training_app/ui/screens/edit_workout_program_screen/edit_workout_program_screen.dart';
import 'package:training_app/ui/universal_components/pop_up_menu.dart';

import '../../../../providers/workout_programs.dart';

// ignore: must_be_immutable
class WorkoutProgramItem extends StatelessWidget {
  final WorkoutProgram workoutProgram;
  Offset _tapPosition;

  WorkoutProgramItem(this.workoutProgram);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToProgramDetailsScreen(context),
      onTapDown: _storePosition,
      onLongPress: () => _showPopUpMenuAndChooseOption(context),
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    workoutProgram.name,
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
                      'Exercises: ${workoutProgram.exercises.length.toString()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Sets: ${workoutProgram.calculateTotalNumberOfSets().toString()}',
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

  void _storePosition(TapDownDetails details) =>
      _tapPosition = details.globalPosition;

  Future goToProgramDetailsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(
        ProgramDetailsScreen.routeName,
        arguments: {
          'name': workoutProgram.name,
          'clientId': workoutProgram.clientId,
        },
      );

  Future goToEditProgramScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(
        EditWorkoutProgramScreen.routeName,
        arguments: workoutProgram,
      );

  Future<void> _showPopUpMenuAndChooseOption(BuildContext context) async {
    final chosenOption =
        await PopUpMenu.createPopUpMenuAndChooseOption(context, _tapPosition);

    if (chosenOption == 'delete') {
      await _deleteWorkoutProgram(context);
    } else if (chosenOption == 'edit') {
      goToEditProgramScreen(context);
    }
  }

  Future<void> _deleteWorkoutProgram(BuildContext context) async {
    if (await _confirmDeletion(context)) {
      final workoutProgramsProvider =
          Provider.of<WorkoutPrograms>(context, listen: false);

      try {
        workoutProgramsProvider.deleteProgram(
            clientId: workoutProgram.clientId,
            programName: workoutProgram.name);
        await workoutProgramsProvider.writeToFile();
        InformationDialogs.showSnackbar('Program deleted.', context);
      } catch (err) {
        workoutProgramsProvider.addProgram(workoutProgram);
        InformationDialogs.showSnackbar(
            'Couldn\'t delete program. Try again.', context);
      }
    }
  }

  Future<bool> _confirmDeletion(BuildContext context) async =>
      await Confirmation.confirmationDialog(context);
}
