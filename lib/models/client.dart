import 'package:flutter/foundation.dart';

enum Gender {
  Man,
  Woman,
}

class Client {
  // final String id;
  final String firstName;
  final String lastName;
  // final Gender gender;
  // final int height;
  // int bodyweight;
  // Measurements measurements;

  Client({
    // @required this.id,
    @required this.firstName,
    @required this.lastName,
    // @required this.gender,
    // @required this.height,
  });
}
