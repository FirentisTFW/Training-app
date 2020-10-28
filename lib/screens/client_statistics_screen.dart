import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:training_app/providers/workouts.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/widgets/statistics_big_fields.dart';
import 'package:training_app/widgets/statistics_small_field.dart';

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
            StatisticsBigFieldInteger(
              title: "Completed workouts",
              value:
                  workoutsProvider.getTotalNumberOfWorkoutsByClientId(clientId),
            ),
            StatisticsBigFieldInteger(
              title: "Workout programs",
              value: workoutProgramsProvider
                  .getTotalNumberOfWorkoutProgramsByClientId(clientId),
            ),
            StatisticsBigFieldDouble(
              title: "Workouts per week",
              value: workoutsProvider
                  .getNumberOfWorkoutsPerWeekByClientId(clientId),
            ),
            _buildSmallFieldsWithWorkoutDates(
              firstWorkoutDate: workoutsProvider
                          .getFirstWorkoutDateByClientId(clientId) !=
                      null
                  ? DateFormat.yMd().format(
                      workoutsProvider.getFirstWorkoutDateByClientId(clientId))
                  : "No workouts completed yet",
              lastWorkoutDate: workoutsProvider
                          .getLastWorkoutDateByClientId(clientId) !=
                      null
                  ? DateFormat.yMd().format(
                      workoutsProvider.getLastWorkoutDateByClientId(clientId))
                  : "No workouts completed yet",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallFieldsWithWorkoutDates({
    String firstWorkoutDate,
    String lastWorkoutDate,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatisticsSmallField(
          title: "First Workout",
          date: firstWorkoutDate,
        ),
        StatisticsSmallField(
          title: "Last Workout",
          date: lastWorkoutDate,
        ),
      ],
    );
  }
}
