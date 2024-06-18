import 'package:flutter/material.dart';
import 'package:workout_app/pages/schedule.dart';
import 'package:workout_app/pages/workouts.dart';

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
            seedColor: const Color.fromARGB(255, 190, 55, 55)),
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
    Schedule(title: 'This Week'),
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
            label: 'Home',
            icon: Icon(Icons.home),
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
