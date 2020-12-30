import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/services/validator.dart';

void main() {
  group('Validator', () {
    test('validateForEmptyString returns error message when string is empty',
        () {
      final result = Validator.validateForEmptyString('');

      expect(result, 'This field cannnot be empty.');
    });

    test('validateForNumber returns error message when value is not a number',
        () {
      final result = Validator.validateForNumber('asd');

      expect(result, 'Enter a number.');
    });
  });

  test('validateForNumber returns null when value is a number', () {
    final result = Validator.validateForNumber('122');

    expect(result, null);
  });

  test('validateBodyweight returns error message if value is empty', () {
    final result = Validator.validateBodyweight('');

    expect(result, 'Please provide valid bodyweight in kilograms.');
  });

  test('validateBodyweight returns error message if value is not a number', () {
    final result = Validator.validateBodyweight('asd');

    expect(result, 'Please enter a number.');
  });

  test('validateBodyweight returns error message if value is less than 30', () {
    final result = Validator.validateBodyweight('29');

    expect(result, 'Please provide valid bodyweight in kilograms.');
  });

  test('validateBodyweight returns error message if value is more than 300',
      () {
    final result = Validator.validateBodyweight('301');

    expect(result, 'Please provide valid bodyweight in kilograms.');
  });

  test('validateBodyweigth returns null if value is between 30 and 300', () {
    final result = Validator.validateBodyweight('70');

    expect(result, null);
  });
}
