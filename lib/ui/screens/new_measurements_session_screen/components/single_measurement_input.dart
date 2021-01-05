import 'package:flutter/material.dart';
import 'package:training_app/services/validator.dart';

class SingleMeasurementInput extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final Function onSaved;

  const SingleMeasurementInput(
      {Key key, this.labelText, this.focusNode, this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => Validator.validateForDoubleNumberOrEmpty(value),
      onEditingComplete: focusNode.nextFocus,
      onSaved: (value) => onSaved(value, labelText),
    );
  }
}
