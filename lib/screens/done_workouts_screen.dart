import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workouts.dart';
import '../widgets/workout_item.dart';
import '../widgets/no_items_added_yet_informator.dart';

class DoneWorkoutScreen extends StatefulWidget {
  static const routeName = '/done-workouts';

  @override
  _DoneWorkoutScreenState createState() => _DoneWorkoutScreenState();
}

class _DoneWorkoutScreenState extends State<DoneWorkoutScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      Provider.of<Workouts>(context).fetchWorkouts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final workoutsData = Provider.of<Workouts>(context);
    final workouts = workoutsData.findByClientId(clientId);
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
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : workouts.length == 0
              ? NoItemsAddedYetInformator('No workouts completed yet.')
              : ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (ctx, index) {
                    return WorkoutItem(
                      workouts[index],
                    );
                  },
                ),
    );
  }
}
