import 'package:flutter/material.dart';
import 'package:workout_app/pages/workouts/new_workout.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  void addNewWorkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewWorkout(
          title: 'New Workout'
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: addNewWorkout, 
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15)
                    ),
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
