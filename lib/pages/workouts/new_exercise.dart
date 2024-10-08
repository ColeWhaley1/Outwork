import 'package:flutter/material.dart';
import 'package:workout_app/widgets/form_incrementer.dart';
import 'package:workout_app/widgets/form_time_input.dart';
import 'package:workout_app/widgets/image_or_video_picker.dart';

class NewExercise extends StatelessWidget {
  const NewExercise({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Exercise'),
        ),
        body: const NewExerciseForm());
  }
}

class NewExerciseForm extends StatefulWidget {
  const NewExerciseForm({super.key});

  @override
  State<NewExerciseForm> createState() => _NewExerciseFormState();
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // incrementers
  int _setCount = 0;
  int _repCount = 0;
  int _weight = 0;

  // time input
  int _durationMinutes = 0;
  int _durationSeconds = 0;
  int _restMinutes = 0;
  int _restSeconds = 0;

  // image and video picker
  List<String> _links = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'You must title your exercise';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Description',
                          ),
                          minLines: 5,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 20),
                        FormIncrementer(
                          label: 'Set Count',
                          onChanged: (value) {
                            setState(() {
                              _setCount = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        FormIncrementer(
                          label: 'Rep Count',
                          onChanged: (value) {
                            setState(() {
                              _repCount = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        FormIncrementer(
                          label: 'Weight (lbs.)',
                          onChanged: (value) {
                            setState(() {
                              _weight = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        FormTimeInput(
                          label: 'Duration',
                          onMinutesChanged: (minutes) {
                            setState(() {
                              _durationMinutes = minutes;
                            });
                          },
                          onSecondsChanged: (seconds) {
                            setState(() {
                              _durationSeconds = seconds;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        FormTimeInput(
                          label: 'Rest Between Sets',
                          onMinutesChanged: (minutes) {
                            setState(() {
                              _restMinutes = minutes;
                            });
                          },
                          onSecondsChanged: (seconds) {
                            setState(() {
                              _restSeconds = seconds;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageOrVideoPicker(
                                  onChanged: (links) {
                                    setState(() {
                                      _links = links;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print('title: ${_titleController.text}');
                    print('title: ${_descriptionController.text}');
                    print('sets: $_setCount');
                    print('reps: $_repCount');
                    print('weight: $_weight');
                    print('duration: $_durationMinutes mins and $_durationSeconds secs');
                    print('rest: $_restMinutes mins and $_restSeconds secs');
                    print('links: $_links');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 111, 183),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  child: const Text("Create"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
