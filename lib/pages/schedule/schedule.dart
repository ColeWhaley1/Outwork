import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:workout_app/pages/schedule/types.dart';
import 'package:workout_app/pages/workouts/types.dart';

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
      body: const Column(
        children: [
          ThisWeekSchedule(),
        ],
      ),
    );
  }
}

class ThisWeekSchedule extends StatefulWidget {
  const ThisWeekSchedule({super.key});

  @override
  State<ThisWeekSchedule> createState() => _ThisWeekScheduleState();
}

class _ThisWeekScheduleState extends State<ThisWeekSchedule> {
  // TEMP, using as example. This will be populated when user adds workout for specific day
  var weekInfo = [
    DayInfo('Sunday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Monday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Tuesday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Wednesday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Thursday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Friday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
    DayInfo('Saturday', [
      Deck([ExcerciseCard('push-ups', 10), ExcerciseCard('sit-ups', 10)])
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CarouselSlider(
        options: CarouselOptions(height: 300.0),
        items: weekInfo.map((dayInfo) {
          return Builder(
            builder: (BuildContext builder) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                child: DayScheduleCard(
                  dayInfo: dayInfo,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class DayScheduleCard extends StatefulWidget {
  const DayScheduleCard({super.key, required this.dayInfo});

  final DayInfo dayInfo;

  @override
  State<DayScheduleCard> createState() => _DayScheduleCardState();
}

class _DayScheduleCardState extends State<DayScheduleCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.dayInfo.day, style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        ],
      ),
    );
  }
}
