import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:training_app/models/client.dart';

class GenderSelection extends StatelessWidget {
  final Function _updateClient;

  const GenderSelection(this._updateClient);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: Gender.Man,
      items: [
        DropdownMenuItem(
          value: Gender.Man,
          child: Row(
            children: [
              Icon(MdiIcons.humanMale),
              SizedBox(width: 10),
              Text('Man'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: Gender.Woman,
          child: Row(
            children: [
              Icon(MdiIcons.humanFemale),
              SizedBox(width: 10),
              Text('Woman'),
            ],
          ),
        ),
      ],
      onChanged: (_) {},
      onSaved: (value) => _updateClient('gender', value),
    );
  }
}
