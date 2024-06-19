import 'package:flutter/material.dart';
import 'package:workout_app/pages/schedule/schedule.dart';
import 'package:workout_app/pages/workouts/workouts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutWork',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 55, 127, 190)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [
    Schedule(title: 'Upcoming Workouts'),
    WorkoutPage(title: 'Workout Decks'),
  ];

  int _currPageIndex = 0;

  void _onSelectedPage(int index) {
    setState(() {
      _currPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currPageIndex,
        onTap: _onSelectedPage,
        items: const [
          BottomNavigationBarItem(
            label: 'Schedule',
            icon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: 'Workouts',
            icon: Icon(Icons.fitness_center),
          ),
        ],
      ),
    );
  }
}
