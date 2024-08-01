import 'package:flutter/material.dart';
import 'package:workout_app/widgets/form_incrementer.dart';

class NewWorkout extends StatelessWidget {
  const NewWorkout({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Workout'),
        ),
        body: const NewWorkoutForm());
  }
}

class NewWorkoutForm extends StatefulWidget {
  const NewWorkoutForm({super.key});

  @override
  State<NewWorkoutForm> createState() => _NewWorkoutFormState();
}

class _NewWorkoutFormState extends State<NewWorkoutForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  return 'You must title your workout';
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
          ],
        ),
      ),
    );
  }
}

