import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/providers/workouts.dart';
import 'package:training_app/ui/screens/completed_workouts_screen/completed_workouts_screen.dart';
import 'package:training_app/ui/screens/client_statistics_screen/client_statistics_screen.dart';
import 'package:training_app/screens/workout_programs_screen.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';
import 'package:training_app/widgets/workout_program_chooser.dart';
import 'package:provider/provider.dart';

import '../../../providers/clients.dart';
import 'components/client_profile_list_item.dart';
import '../../../screens/measurements_screen.dart';

class ClientProfileScreen extends StatefulWidget {
  static const routeName = '/client-profile';

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  var _isLoading = true;
  DateTime _lastWorkoutDate;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoading) {
      final clientId = ModalRoute.of(context).settings.arguments;
      await Provider.of<Workouts>(context, listen: false).fetchWorkouts();
      _lastWorkoutDate = Provider.of<Workouts>(context, listen: false)
          .getLastWorkoutDateByClientId(clientId);

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final clientsProvider = Provider.of<Clients>(context);
    final client = clientsProvider.getClientById(clientId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? LoadingSpinner()
          : ListView(
              children: [
                _NameContainer(
                    name: client.firstName, paddingTop: 14, paddingBottom: 0),
                _NameContainer(
                    name: client.lastName, paddingTop: 14, paddingBottom: 14),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Age: ' + client.calculateAge().toString(),
                        style: TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    _lastWorkoutDate != null
                        ? 'Last Workout: ${DateFormat.yMd().format(_lastWorkoutDate)}'
                        : 'No workouts completed yet',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                ClientProfileListItem(
                    title: 'New Workout',
                    icon: Icons.fitness_center,
                    tapHandler: () =>
                        openWorkoutProgramChooser(context, clientId)),
                ClientProfileListItem(
                    title: 'Completed Workouts',
                    icon: Icons.done,
                    tapHandler: () => goToDoneWorkoutScreen(context, clientId)),
                ClientProfileListItem(
                    title: 'Workout Programs',
                    icon: Icons.event_note,
                    tapHandler: () =>
                        goToWorkoutProgramsScreen(context, clientId)),
                ClientProfileListItem(
                    title: 'Measurements',
                    icon: Icons.subject,
                    tapHandler: () =>
                        goToMeasurementsScreen(context, clientId)),
                ClientProfileListItem(
                    title: 'Progress',
                    icon: Icons.show_chart,
                    tapHandler: () {}),
                ClientProfileListItem(
                    title: 'Statistics',
                    icon: Icons.insert_chart,
                    tapHandler: () =>
                        goToClientStatisticsScreen(context, clientId)),
              ],
            ),
    );
  }

  Future openWorkoutProgramChooser(
      BuildContext context, String clientId) async {
    await showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: WorkoutProgramChooser(clientId),
          );
        });
  }

  Future goToDoneWorkoutScreen(BuildContext context, String clientId) =>
      Navigator.of(context).pushNamed(
        CompletedWorkoutScreen.routeName,
        arguments: clientId,
      );

  Future goToWorkoutProgramsScreen(BuildContext context, String clientId) =>
      Navigator.of(context).pushNamed(
        WorkoutProgramsScreen.routeName,
        arguments: clientId,
      );

  Future goToMeasurementsScreen(BuildContext context, String clientId) =>
      Navigator.of(context).pushNamed(
        MeasurementsScreen.routeName,
        arguments: clientId,
      );

  Future goToClientStatisticsScreen(BuildContext context, String clientId) =>
      Navigator.of(context).pushNamed(
        ClientStatisticsScreen.routeName,
        arguments: clientId,
      );
}

class _NameContainer extends StatelessWidget {
  final String name;
  final double paddingTop;
  final double paddingBottom;

  const _NameContainer({this.name, this.paddingTop, this.paddingBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
