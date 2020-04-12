// flutter drive --target=test_driver/app.dart

import 'package:flutter_driver/driver_extension.dart';
import 'package:bodysculpting/main.dart' as app;

void main() async {
  enableFlutterDriverExtension();
  await app.main();
}
