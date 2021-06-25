import 'package:bodysculpting/db/local_datastore.dart';
import 'package:bodysculpting/screens/workouts_screen.dart';
import 'package:bodysculpting/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalDatastore().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
        home: const WorkoutsScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
        //themeMode: ThemeMode.dark, // uncomment to force override for testing
      ),
    );
  }
}
