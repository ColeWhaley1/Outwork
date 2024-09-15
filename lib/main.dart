import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/firebase_options.dart';
import 'package:workout_app/pages/schedule/schedule.dart';
import 'package:workout_app/pages/workouts/workouts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PaintingBinding.instance.imageCache.maximumSize = 4000; // default is 1000
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 * 1024 * 1024; // default is 100 MB

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
            seedColor: const Color.fromARGB(255, 55, 127, 190)),
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
    const Schedule(title: 'Upcoming'),
    const WorkoutPage(title: 'Workouts and Exercises'),
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
