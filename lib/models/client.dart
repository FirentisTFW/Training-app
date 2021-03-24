import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

enum Gender {
  Man,
  Woman,
  Unknown,
}

@JsonSerializable()
class Client {
  final String id;
  final String firstName;
  final String lastName;
  final Gender gender;
  final DateTime birthDate;
  final int height;

  Client({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.gender,
    @required this.birthDate,
    @required this.height,
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

  Client copyWith({
    String firstName,
    String lastName,
    Gender gender,
    DateTime birthDate,
    int height,
  }) {
    return Client(
      id: this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
    );
  }
}
