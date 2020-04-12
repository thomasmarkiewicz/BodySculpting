import 'package:flutter/material.dart';
import 'features/workout/presentation/pages/workouts/workouts_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey.shade800,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.light,
    disabledColor: Colors.grey.shade300,
    //canvasColor: Colors.indigo.shade50,
    // cardColor:
    // disabledColor:
    // buttonColor: Colors.blueAccent,
    // ToggleButtonsThemeData toggleButtonsTheme
    // hintColor:
    // errorColor:
    // FloatingActionButtonThemeData
    // bottomSheetTheme
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    //primaryColor: Colors.grey.shade800,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey.shade700,
    buttonColor: Colors.grey.shade500,
    //buttonColor: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Sculpting',
      theme: lightTheme,
      darkTheme: darkTheme,
      //themeMode: ThemeMode.dark,
      home: WorkoutsPage(),
    );
  }
}
