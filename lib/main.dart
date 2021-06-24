import 'package:bodysculpting/screens/workouts_screen.dart';
import 'package:bodysculpting/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey.shade800,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.light,
    disabledColor: Colors.grey.shade300,
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey.shade700,
    buttonColor: Colors.grey.shade500,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Body Sculpting',
        home: WorkoutsScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
        //themeMode: ThemeMode.dark, // uncomment to force override for testing
      ),
    );
  }
}
