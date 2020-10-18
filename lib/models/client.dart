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
  final DateTime birthDate;
  final int height;
  int bodyweight;

  Client({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.gender,
    @required this.birthDate,
    @required this.height,
    this.bodyweight,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  int calculateAge() {
    final currentDate = DateTime.now();
    if (birthDate.month < currentDate.month) {
      return currentDate.year - birthDate.year;
    } else if (birthDate.month == currentDate.month &&
        birthDate.day <= currentDate.day) {
      return currentDate.year - birthDate.year;
    }
    return currentDate.year - birthDate.year - 1;
  }
}
