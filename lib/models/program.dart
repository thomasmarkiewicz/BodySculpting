// run the following in terminal to generate adapters:
//     flutter packages pub run build_runner build

import 'package:bodysculpting/models/link.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'program.g.dart';

@HiveType(typeId: 2)
enum ProgramLevel {
  @HiveField(0)
  novice,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
}

@HiveType(typeId: 1)
class Program {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int daysPerWeek;

  @HiveField(4)
  final List<ProgramLevel> levels;

  @HiveField(5)
  final List<Link> links;

  @HiveField(6)
  final List<String> routines;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.daysPerWeek,
    required this.levels,
    required this.links,
    required this.routines,
  });
}
