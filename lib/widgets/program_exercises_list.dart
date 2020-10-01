import 'package:flutter/material.dart';

import '../widgets/program_exercise_item.dart';

class ProgramExercisesList extends StatefulWidget {
  @override
  _ProgramExercisesListState createState() => _ProgramExercisesListState();
}

class _ProgramExercisesListState extends State<ProgramExercisesList> {
  int numberOfExercises = 1;

  @override
  Widget build(BuildContext context) {
    print("program-exercises-list");

    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: numberOfExercises,
              itemBuilder: (context, index) => ProgramExerciseItem(),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: FlatButton(
              padding: EdgeInsets.all(16),
              child: Text(
                'Add Another Exercise',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  numberOfExercises++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
