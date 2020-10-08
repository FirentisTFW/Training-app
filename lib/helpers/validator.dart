class Validator {
  static String validateForEmptyString(String value) {
    if (value.isEmpty) {
      return 'This field cannnot be empty.';
    }
    return null;
  }

  static String validateForEmptyAndNumber(String value) {
    if (validateForEmptyString(value) != null) {
      return 'This field cannnot be empty.';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a number.';
    }
    return null;
  }

  static String validateForNumber(String value) {
    if (value.isEmpty) {
      return null;
    }
    if (int.tryParse(value) == null) {
      return 'Enter a number.';
    }
    return null;
  }

  static String validateHeight(String value) {
    if (validateForEmptyString(value) != null) {
      return 'Please provide height.';
    }
    var height = int.tryParse(value);
    if (height == null) {
      return 'Please enter a number.';
    }
    if (height < 100 || height > 250) {
      return 'Please provide valid height in centimeters.';
    }
    return null;
  }

  static String validateBodyweight(String value) {
    if (validateForEmptyString(value) != null) {
      return 'Please provide valid bodyweight in kilograms.';
    }
    var bodyweight = int.tryParse(value);
    if (bodyweight == null) {
      return 'Please enter a number.';
    }
    if (bodyweight < 30 || bodyweight > 300) {
      return 'Please provide valid bodyweight in kilograms.';
    }
    return null;
  }
}
