import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:training_app/providers/workouts.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/ui/screens/client_statistics_screen/components/statistics_big_fields.dart';
import 'package:training_app/ui/screens/client_statistics_screen/components/statistics_small_field.dart';

class ClientStatisticsScreen extends StatelessWidget {
  static const routeName = '/client-statistics';

  @override
  Widget build(BuildContext context) {
    final String clientId = ModalRoute.of(context).settings.arguments;
    final workoutsProvider = Provider.of<Workouts>(context);
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Container(
        child: ListView(
          children: [
            StatisticsBigField(
              title: 'Completed workouts',
              value:
                  workoutsProvider.getTotalNumberOfWorkoutsByClientId(clientId),
            ),
            StatisticsBigField(
              title: 'Workout programs',
              value: workoutProgramsProvider
                  .getTotalNumberOfWorkoutProgramsByClientId(clientId),
            ),
            StatisticsBigField(
              title: 'Workouts per week',
              value: workoutsProvider
                  .getNumberOfWorkoutsPerWeekByClientId(clientId),
            ),
            _FirstAndLastWorkoutsDates(clientId),
          ],
        ),
      ),
    );
  }
}

class _FirstAndLastWorkoutsDates extends StatelessWidget {
  final String clientId;

  const _FirstAndLastWorkoutsDates(this.clientId);

  @override
  Widget build(BuildContext context) {
    final workoutsProvider = Provider.of<Workouts>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatisticsSmallField(
          title: 'First workout',
          date: workoutsProvider.getFirstWorkoutDateByClientId(clientId) != null
              ? DateFormat.yMd().format(
                  workoutsProvider.getFirstWorkoutDateByClientId(clientId))
              : "No workouts completed yet",
        ),
        StatisticsSmallField(
          title: 'Last workout',
          date: workoutsProvider.getLastWorkoutDateByClientId(clientId) != null
              ? DateFormat.yMd().format(
                  workoutsProvider.getLastWorkoutDateByClientId(clientId))
              : "No workouts completed yet",
        ),
      ],
    );
  }
}
