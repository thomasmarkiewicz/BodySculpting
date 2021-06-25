import 'package:hive_flutter/hive_flutter.dart';

part 'link.g.dart';

@HiveType(typeId: 0)
class Link {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  Link({required this.name, required this.url});
}
