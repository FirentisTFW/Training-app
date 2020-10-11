import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:training_app/screens/edit_workout_screen.dart';
import 'package:training_app/screens/workout_details_screen.dart';
import 'package:training_app/widgets/pop_up_menu.dart';

import '../models/workout.dart';
import '../providers/workouts.dart';

class WorkoutItem extends StatefulWidget {
  final Workout workout;

  WorkoutItem(
    this.workout,
  );

  @override
  _WorkoutItemState createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  Offset _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showPopUpMenuAndChooseOption() async {
    final chosenOption = await PopUpMenu.createPopUpMenuAndChooseOption(
      context,
      _tapPosition,
    );
    if (chosenOption == 'delete') {
      await _deleteWorkout();
    } else if (chosenOption == 'edit') {
      // TODO: edit workout
      _editWorkout();
    }
  }

  Future<void> _deleteWorkout() async {
    final workoutsProvider = Provider.of<Workouts>(context, listen: false);
    workoutsProvider.deleteWorkout(widget.workout.id);
    await workoutsProvider.writeToFile();
    _displayMessage('Workout deleted.');
  }

  void _editWorkout() {
    Navigator.of(context).pushNamed(
      EditWorkoutScreen.routeName,
      arguments: widget.workout,
    );
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
          WorkoutDetailsScreen.routeName,
          arguments: widget.workout,
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
                    DateFormat.yMd().format(widget.workout.date),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.workout.programName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
