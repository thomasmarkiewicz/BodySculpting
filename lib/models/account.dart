import 'package:hive_flutter/hive_flutter.dart';

part 'account.g.dart';

@HiveType(typeId: 3)
enum SubscriptionLevel {
  @HiveField(0)
  free,
}

@HiveType(typeId: 4)
class Account {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final SubscriptionLevel subscription;

  @HiveField(2)
  final bool isActive;

  Account({
    required this.email,
    required this.subscription,
    required this.isActive,
  });
}
