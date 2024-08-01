import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewWorkout extends StatelessWidget {
  const NewWorkout({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Workout'),
        ),
        body: NewWorkoutForm());
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

class FormIncrementer extends StatefulWidget {
  const FormIncrementer({super.key, required this.label});

  final String label;

  @override
  State<FormIncrementer> createState() => _FormIncrementer();
}

class _FormIncrementer extends State<FormIncrementer> {

  late TextEditingController _controller;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
    _controller.addListener(updateCountWhenEnteredManually);
  }

  @override
  void dispose() {
    _controller.removeListener(updateCountWhenEnteredManually);
    _controller.dispose();
    super.dispose();
  }

  void decrement() {
    setState(() {
      if(count > 0){
        count--;
        _controller.text = count.toString();
      }
    });
  }

  void updateCountWhenEnteredManually() {
    final input = _controller.text;
    if(input.isNotEmpty){
      setState(() {
        count = int.tryParse(input) ?? 0;
      });
    }
  }

  void increment() {
    setState(() {
      if(count < 99){
        count++;
        _controller.text = count.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
              ),
              onPressed: decrement, 
              child: const Icon(Icons.remove),
            ),
          ),
          Column(
            children: [
              Text(widget.label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary
                  )),
              SizedBox(
                width: 100,
                child: TextFormField(
                  controller: _controller,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(2),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
              ),
              onPressed: increment, 
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
