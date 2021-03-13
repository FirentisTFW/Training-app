import 'package:flutter/material.dart';
import 'package:training_app/services/validator.dart';

class SingleMeasurementInput extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final String suffix;
  final Function onSaved;

  const SingleMeasurementInput(
      {Key key, this.labelText, this.focusNode, this.onSaved, this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        suffixText: suffix,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      validator: (value) => Validator.validateForDoubleNumberOrEmpty(value),
      onEditingComplete: focusNode.nextFocus,
      onSaved: (value) => onSaved(value, labelText),
    );
  }
}
