import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

enum Gender {
  Man,
  Woman,
}

@JsonSerializable()
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

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

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
