import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/program_exercise_item.dart';
import '../providers/workout_programs.dart';

class ProgramExercisesList extends StatefulWidget {
  final key;

  ProgramExercisesList({
    @required this.key,
  });

  @override
  ProgramExercisesListState createState() => ProgramExercisesListState();
}

class ProgramExercisesListState extends State<ProgramExercisesList> {
  int _numberOfExercises = 1;
  List<GlobalKey<ProgramExerciseItemState>> _exercisesKeys = [
    GlobalKey(),
  ];

  @override
  Widget build(BuildContext context) {
    print("program-exercises-list");
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._exercisesKeys
                      .map((singleKey) => ProgramExerciseItem(
                            key: singleKey,
                          ))
                      .toList()
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: FlatButton(
              padding: EdgeInsets.all(12),
              child: Text(
                'Save Program',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => _saveProgram(),
            ),
          ),
        ],
      ),
    );
  }

  void addAnotherExercise() {
    setState(() {
      _numberOfExercises++;
      _exercisesKeys.add(GlobalKey());
    });
  }

  Future<void> _saveProgram() async {
    _exercisesKeys.forEach((element) {
      element.currentState.saveForm();
    });
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.saveNewProgram();
    await workoutProgramsProvider.writeToFile();
    Navigator.of(context).pop();
  }
}
