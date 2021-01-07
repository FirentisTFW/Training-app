import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/workout_programs.dart';
import '../new_workout_program_screen/new_workout_program_screen.dart';
import '../../universal_components/no_items_added_yet_informator.dart';
import 'components/workout_program_item.dart';

class WorkoutProgramsScreen extends StatelessWidget {
  static const routeName = '/workout-programs';

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);
    final workoutPrograms = workoutProgramsProvider.findByClientId(clientId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () => goToNewWorkoutProgramScreen(context, clientId),
          )
        ],
      ),
      body: workoutPrograms.length <= 0
          ? const NoItemsAddedYetInformator('No programs added yet.')
          : ListView.builder(
              itemCount: workoutPrograms.length,
              itemBuilder: (ctx, index) =>
                  WorkoutProgramItem(workoutPrograms[index]),
            ),
    );
  }

  Future goToNewWorkoutProgramScreen(BuildContext context, String clientId) =>
      Navigator.of(context).pushNamed(
        NewWorkoutProgramScreen.routeName,
        arguments: clientId,
      );
}
