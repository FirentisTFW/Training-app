import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';

class NewWorkoutScreen extends StatefulWidget {
  static const routeName = '/new-workout';

  @override
  _NewWorkoutScreenState createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  Widget _buildInputField(int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          number.toString() + '. set',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          width: 80,
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'reps',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        Container(
          width: 80,
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'weight',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final program =
        workoutProgramsData.findByProgramNameAndClientId('PULL', '0');
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
                    return Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              program.exercises[index].name,
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          for (int i = 1;
                              i <= program.exercises[index].sets;
                              i++) ...{
                            _buildInputField(i),
                          },
                          SizedBox(height: 20),
                          FlatButton(
                            child: Text(
                              'Add Another Set',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
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
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
