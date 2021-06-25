import 'package:hive_flutter/hive_flutter.dart';

part 'profile.g.dart';

@HiveType(typeId: 4)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
  @HiveField(2)
  other,
}

@HiveType(typeId: 5)
class Profile {
  @HiveField(0)
  final String? first;

  @HiveField(1)
  final String? last;

  @HiveField(2)
  final String? city;

  @HiveField(3)
  final String? state;

  @HiveField(4)
  final String? bio;

  // athlete info used to calculate calories, power, and more

  @HiveField(5)
  final DateTime? birthdate;

  @HiveField(6)
  final Gender? gender;

  @HiveField(7)
  final double? weight;

  // performance potential
  // used to set hear rate zone, running pace zone, lift weights, etc

  @HiveField(8)
  final int? maxHeartRate;

  @HiveField(9)
  final int? functionalThresholdPower; // in watts

  Profile({
    this.first,
    this.last,
    this.city,
    this.state,
    this.bio,
    this.birthdate,
    this.gender,
    this.weight,
    this.maxHeartRate,
    this.functionalThresholdPower,
  });
}
