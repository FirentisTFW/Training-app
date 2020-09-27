import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:training_app/screens/done_workouts_screen.dart';
import 'package:training_app/screens/workout_programs_screen.dart';
import 'package:training_app/widgets/workout_program_chooser.dart';
import 'package:provider/provider.dart';

import '../providers/clients.dart';
import '../widgets/client_profile_list_item.dart';

class ClientProfileScreen extends StatelessWidget {
  static const routeName = '/client-profile';

  _buildNameContainer({
    String name,
    double paddingTop,
    double paddingBottom,
  }) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNameContainer(
                name: client.firstName, paddingTop: 14, paddingBottom: 0),
            _buildNameContainer(
                name: client.lastName, paddingTop: 14, paddingBottom: 14),
            Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Age: ' + client.calculateAge().toString(),
                    style: TextStyle(fontSize: 26),
                  ),
                  Text(
                    'Bw: ' +
                        (client.bodyweight != 0
                            ? client.bodyweight.toString() + " kg"
                            : "not specified"),
                    style: TextStyle(fontSize: 26),
                  ),
                ],
              ),
            ),
            FlatButton(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Last Workout: 19/08/2020',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            ClientProfileListItem('New Workout', Icons.accessibility_new, () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: WorkoutProgramChooser(),
                    );
                  });
            }),
            Divider(),
            ClientProfileListItem('Completed Workouts', Icons.done, () {
              Navigator.of(context).pushNamed(DoneWorkoutScreen.routeName);
            }),
            Divider(),
            ClientProfileListItem('Workout Programs', Icons.event_note, () {
              Navigator.of(context).pushNamed(
                WorkoutProgramsScreen.routeName,
                arguments: client.id,
              );
            }),
            Divider(),
            ClientProfileListItem('Progress', Icons.show_chart, () {}),
            Divider(),
            ClientProfileListItem('Statistics', Icons.insert_chart, () {}),
            Divider(),
          ],
        ),
      ),
    );
  }
}
