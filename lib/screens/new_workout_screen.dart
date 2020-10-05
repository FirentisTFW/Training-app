import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';
import '../widgets/exercise_and_sets.dart';

class NewWorkoutScreen extends StatelessWidget {
  static const routeName = '/new-workout';

  @override
  Widget build(BuildContext context) {
    final programData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);
    final program = workoutProgramsProvider.findByProgramNameAndClientId(
      programData['programName'],
      programData['clientId'],
    );
    List<GlobalKey<ExerciseAndSetsState>> _exercisesKeys = [];
    for (int i = 0; i < program.exercises.length; i++) {
      _exercisesKeys.add(GlobalKey());
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: program.exercises.length,
                  itemBuilder: (ctx, index) {
                    return ExerciseAndSets(
                      formKey: _exercisesKeys[index],
                      exerciseName: program.exercises[index].name,
                      initialSets: program.exercises[index].sets,
                    );
                  },
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[600],
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 40,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
