import 'package:flutter/material.dart';
import 'package:workout_app/pages/workouts/new_exercise.dart';
import 'package:workout_app/pages/workouts/views/exercise_view.dart';
import 'package:workout_app/pages/workouts/views/workout_view.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void addNewExercise() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewExercise(title: 'New Exercise'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Spacer(
                flex: 2,
              ),
              Text("Workouts"),
              Spacer(flex: 1),
              Text("Exercises"),
              Spacer(
                flex: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: PageView( 
                    children: const [
                      WorkoutView(),
                      ExerciseView(),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: addNewExercise,
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
