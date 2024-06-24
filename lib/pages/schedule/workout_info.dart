import 'package:flutter/material.dart';
import 'package:workout_app/pages/workouts/types.dart';

class WorkoutInfo extends StatefulWidget {
  const WorkoutInfo({super.key, required this.deck, required this.textColor});

  final Deck deck;
  final Color textColor;
  @override
  State<WorkoutInfo> createState() => _WorkoutInfoState();
}

class _WorkoutInfoState extends State<WorkoutInfo> {

  List<Exercise> getExcercises() {
    return widget.deck.exercises;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getExcercises().map((exercise) {
        return Text(exercise.name, style: TextStyle(fontSize: 16.0, color: widget.textColor,));
      }).toList(),
    );
  }
}