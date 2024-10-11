import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:workout_app/pages/schedule/types.dart';
import 'package:workout_app/pages/schedule/workout_info.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: const Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(child: ThisWeekSchedule()),
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
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: WeekCarousel(
                height: orientation == Orientation.portrait ? 300.0 : 200.0),
          ),
        ],
      );
    });
  }
}

class WeekCarousel extends StatefulWidget {
  const WeekCarousel({super.key, required this.height});

  final double height;

  @override
  State<WeekCarousel> createState() => _WeekCarouselState();
}

class _WeekCarouselState extends State<WeekCarousel> {
  // TEMP, using as example. This will be populated when user adds workout for specific day
  var weekInfo = [
    DayInfo(
      'Sunday',
      Deck(
        [
          Exercise('push-ups', 10),
          Exercise('sit-ups', 10),
        ],
      ),
      30,
    ),
    DayInfo(
      'Monday',
      Deck(
        [
          Exercise('pull-ups', 10),
          Exercise('barbell curls', 10),
        ],
      ),
      45,
    ),
    DayInfo(
      'Tuesday',
      Deck(
        [
          Exercise('Push-ups', 10),
          Exercise('Sit-ups', 10),
        ],
      ),
      30,
    ),
    DayInfo(
      'Wednesday',
      Deck(
        [
          Exercise('push-ups', 10),
          Exercise('sit-ups', 10),
        ],
      ),
      60,
    ),
    DayInfo(
      'Thursday',
      Deck(
        [
          Exercise('push-ups', 10),
          Exercise('sit-ups', 10),
        ],
      ),
      30,
    ),
    DayInfo(
      'Friday',
      Deck([
        Exercise('push-ups', 10),
        Exercise('sit-ups', 10),
      ]),
      30,
    ),
    DayInfo(
      'Saturday',
      Deck([
        Exercise('push-ups', 10),
        Exercise('sit-ups', 10),
      ]),
      30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: widget.height,
      ),
      items: weekInfo.map((dayInfo) {
        return Builder(
          builder: (BuildContext builder) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DayScheduleCard(
                dayInfo: dayInfo,
              ),
            );
          },
        );
      }).toList(),
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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 26.0,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dayInfo.day,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            child: WorkoutInfo(
              deck: widget.dayInfo.deck,
              textColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    Text(
                      widget.dayInfo.totalTime.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedDayScheduleCard(
                          dayInfo: widget.dayInfo,
                        ),
                      ),
                    );
                    return;
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.open_in_full,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandedDayScheduleCard extends StatefulWidget {
  const ExpandedDayScheduleCard({super.key, required this.dayInfo});

  final DayInfo dayInfo;
  @override
  State<ExpandedDayScheduleCard> createState() =>
      _ExpandedDayScheduleCardState();
}

class _ExpandedDayScheduleCardState extends State<ExpandedDayScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dayInfo.day),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: WorkoutInfo(
          deck: widget.dayInfo.deck,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
