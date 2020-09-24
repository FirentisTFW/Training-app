import 'package:flutter/foundation.dart';

enum Gender {
  Man,
  Woman,
}

class Client {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final int height;
  int bodyweight;
  // Measurements measurements;

  Client({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.gender,
    @required this.height,
    this.bodyweight,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'height': height,
      'bodyweight': bodyweight,
    };
  }

  static Client createFromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      height: map['height'],
      bodyweight: map['bodyweight'],
    );
  }
}
