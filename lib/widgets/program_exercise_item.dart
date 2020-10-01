import 'package:flutter/material.dart';

class ProgramExerciseItem extends StatefulWidget {
  @override
  _ProgramExerciseItemState createState() => _ProgramExerciseItemState();
}

class _ProgramExerciseItemState extends State<ProgramExerciseItem> {
  @override
  Widget build(BuildContext context) {
    print("program-exercise-item-state");
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Name'),
                  ),
                  DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Type'),
                    value: 'ForRepetitions',
                    items: [
                      // TODO: put these options in builder function
                      DropdownMenuItem(
                        value: 'ForRepetitions',
                        child: const Text('For Repetitions'),
                      ),
                      DropdownMenuItem(
                        value: 'ForTime',
                        child: const Text('For Time'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sets'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reps Min'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reps Max'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
