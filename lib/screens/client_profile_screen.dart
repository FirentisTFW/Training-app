import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/client_profile_list_item.dart';

class ClientProfileScreen extends StatelessWidget {
  static const routeName = '/client-profile';

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 26),
                  child: Icon(
                    MdiIcons.humanMale,
                    size: 36,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  // padding: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Jan Kowalski',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              // color: Colors.black,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Age: 32',
                    style: TextStyle(fontSize: 26),
                  ),
                  Text(
                    'Bw: 83kg',
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
            ClientProfileListItem(
                'New Workout', Icons.accessibility_new, () {}),
            Divider(),
            ClientProfileListItem('Completed Workouts', Icons.done, () {}),
            Divider(),
            ClientProfileListItem('Workout Programs', Icons.event_note, () {}),
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
