import 'package:bodysculpting/utils/platform_info.dart';
import 'package:flutter/material.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  var platform = PlatformInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: platform.isAppOS()
          ? AppBar(title: const Text("Body Sculpting"))
          : null,
      body: const SingleChildScrollView(
        child: Text("TODO: implement WorkoutsScreen"),
      ),
      floatingActionButton: WorkoutsFab(),
    );
  }
}

class WorkoutsFab extends StatelessWidget {
  const WorkoutsFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('New workout'),
      icon: const Icon(Icons.add),
      foregroundColor: Colors.white,
      tooltip: 'Add a new workout',
      onPressed: () {
        print('TODO: do something when Workouts FAB gets pressed');
      },
    );
  }
}
