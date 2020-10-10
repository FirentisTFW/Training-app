import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/screens/workout_details_screen.dart';

import '../models/workout.dart';

class WorkoutItem extends StatefulWidget {
  final Workout workout;

  WorkoutItem(
    this.workout,
  );

  @override
  _WorkoutItemState createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  Offset _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showPopUpMenu() async {
    print(await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapPosition.dx,
        _tapPosition.dy,
        _tapPosition.dx + 1,
        _tapPosition.dy + 1,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              Text("Delete"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              Text("Edit"),
            ],
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          WorkoutDetailsScreen.routeName,
          arguments: widget.workout,
        );
      },
      onTapDown: _storePosition,
      onLongPress: _showPopUpMenu,
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat.yMd().format(widget.workout.date),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.workout.programName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
