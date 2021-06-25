import 'package:hive_flutter/hive_flutter.dart';

part 'preferences.g.dart';

@HiveType(typeId: 6)
enum UnitsOfMeasure {
  @HiveField(0)
  imperial,
  @HiveField(1)
  metric
}

@HiveType(typeId: 7)
enum TemperatureUnits {
  @HiveField(0)
  fahrenheit,
  @HiveField(1)
  celsius
}

@HiveType(typeId: 8)
class Preferences {
  @HiveField(0)
  final UnitsOfMeasure unitsOfMeasure;

  @HiveField(1)
  final TemperatureUnits temperatureUnits;

  Preferences({required this.unitsOfMeasure, required this.temperatureUnits});
}
