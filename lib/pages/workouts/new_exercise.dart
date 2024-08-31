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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Description',
                        ),
                        minLines: 5,
                        maxLines: 10,
                      ),
                      const SizedBox(height: 20),
                      const FormIncrementer(label: 'Set Count'),
                      const SizedBox(height: 20),
                      const FormIncrementer(label: 'Rep Count'),
                      const SizedBox(height: 20),
                      const FormIncrementer(label: 'Duration'),
                      const SizedBox(height: 20),
                      const FormIncrementer(label: 'Weight (lbs.)'),
                      const SizedBox(height: 20),
                      const FormTimeInput(label: 'Rest Between Sets'),
                      const SizedBox(height: 20),
                      const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageOrVideoPicker(),
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
                  print('DATA');
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
    );
  }
}
