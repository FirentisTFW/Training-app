import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';
import '../screens/new_workout_program_screen.dart';
import '../widgets/no_items_added_yet_informator.dart';
import '../widgets/workout_program_item.dart';

class WorkoutProgramsScreen extends StatefulWidget {
  static const routeName = '/workout-programs';

  @override
  _WorkoutProgramsScreenState createState() => _WorkoutProgramsScreenState();
}

class _WorkoutProgramsScreenState extends State<WorkoutProgramsScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      Provider.of<WorkoutPrograms>(context).fetchWorkoutPrograms().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final workoutPrograms = workoutProgramsData.findByClientId(clientId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                NewWorkoutProgramScreen.routeName,
                arguments: clientId,
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : workoutPrograms.length <= 0
              ? const NoItemsAddedYetInformator('No programs added yet.')
              : ListView.builder(
                  itemCount: workoutPrograms.length,
                  itemBuilder: (ctx, index) {
                    return WorkoutProgramItem(
                      clientId: clientId,
                      name: workoutPrograms[index].name,
                      exercisesNumber: workoutPrograms[index].exercises.length,
                      setsNumber:
                          workoutPrograms[index].calculateTotalNumberOfSets(),
                    );
                  },
                ),
    );
  }
}
