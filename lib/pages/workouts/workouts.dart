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
  final PageController _pageController = PageController();
  int _currPageIndex = 0;

  void addNewExercise() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewExercise(title: 'New Exercise'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currPageIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Workouts",
                  style: TextStyle(
                    fontWeight: _currPageIndex == 0 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Exercises",
                  style: TextStyle(
                    fontWeight: _currPageIndex == 1 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: const [
                    WorkoutView(),
                    ExerciseView(),
                  ],
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
