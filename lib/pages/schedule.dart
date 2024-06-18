import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key, required this.title});

  final String title;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Text('placeholder'),
    );
  }
}