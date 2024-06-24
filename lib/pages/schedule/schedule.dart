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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: WeekCarousel(
            height: orientation == Orientation.portrait ? 300.0 : 200.0),
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
        'Sunday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Monday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Tuesday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Wednesday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Thursday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Friday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
    DayInfo(
        'Saturday', Deck([Exercise('push-ups', 10), Exercise('sit-ups', 10)])),
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
                color: Theme.of(context).colorScheme.inverseSurface,
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
          height: 20.0,
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
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            child: WorkoutInfo(
              deck: widget.dayInfo.deck,
              textColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                    backgroundColor: const Color.fromARGB(60, 255, 255, 255),
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
        )
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
