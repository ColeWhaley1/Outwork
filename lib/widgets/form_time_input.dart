import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTimeInput extends StatefulWidget {
  const FormTimeInput({super.key, required this.label});

  final String label;

  @override
  State<FormTimeInput> createState() => _FormTimeInput();
}

class _FormTimeInput extends State<FormTimeInput> {
  late TextEditingController _controllerMinutes;
  late TextEditingController _controllerSeconds;
  int countMinutes = 0;
  int countSeconds = 0;

  late FocusNode _focusNodeMinutes;
  late FocusNode _focusNodeSeconds;

  @override
  void initState() {
    super.initState();
    _controllerMinutes = TextEditingController(text: '0');
    _controllerMinutes.addListener(updateCountWhenEnteredManuallyMinutes);
    _controllerSeconds = TextEditingController(text: '0');
    _controllerSeconds.addListener(updateCountWhenEnteredManuallySeconds);

    _focusNodeMinutes = FocusNode();
    _focusNodeSeconds = FocusNode();
    _focusNodeMinutes.addListener(() => handleFocusChange(
        _controllerMinutes, _focusNodeMinutes, countMinutes, false));
    _focusNodeSeconds.addListener(() => handleFocusChange(
        _controllerSeconds, _focusNodeSeconds, countSeconds, true));
  }

  @override
  void dispose() {
    _controllerMinutes.removeListener(updateCountWhenEnteredManuallyMinutes);
    _controllerSeconds.removeListener(updateCountWhenEnteredManuallySeconds);
    _controllerMinutes.dispose();
    _controllerSeconds.dispose();

    _focusNodeMinutes.removeListener(() => handleFocusChange(
        _controllerMinutes, _focusNodeMinutes, countMinutes, false));
    _focusNodeSeconds.removeListener(() => handleFocusChange(
        _controllerSeconds, _focusNodeSeconds, countSeconds, true));

    super.dispose();
  }

  void decrement(int seconds) {
    setState(() {
      if (countSeconds - seconds < 0) {
        if (countMinutes > 0) {
          // carry the 1 from minutes
          countMinutes--;
          countSeconds += (60 - seconds);
        } else {
          countSeconds = 0;
        }
      } else {
        countSeconds -= seconds;
      }
      _controllerMinutes.text = countMinutes.toString();
      _controllerSeconds.text = countSeconds.toString();
    });
  }

  void increment(int seconds) {
    setState(() {
      if (countSeconds + seconds >= 60) {
        if (countMinutes < 99) {
          countMinutes++;
          countSeconds = countSeconds + seconds - 60;
        } else {
          countSeconds = 59;
        }
      } else {
        countSeconds += seconds;
      }
      _controllerMinutes.text = countMinutes.toString();
      _controllerSeconds.text = countSeconds.toString();
    });
  }

  void updateCountWhenEnteredManuallyMinutes() {
    final input = _controllerMinutes.text;
    if (input.isNotEmpty) {
      setState(() {
        countMinutes = int.tryParse(input) ?? 0;
      });
    }
  }

  void updateCountWhenEnteredManuallySeconds() {
    final input = _controllerSeconds.text;
    if (input.isNotEmpty) {
      final inputSeconds = int.tryParse(input) ?? 0;
      if (inputSeconds < 60) {
        setState(() {
          countSeconds = inputSeconds;
        });
      }
    }
  }

  void handleFocusChange(TextEditingController controller, FocusNode focusNode,
      int count, bool isSecondsInput) {
    if (!focusNode.hasFocus) {
      if (controller.text.isEmpty) {
        controller.text = '0';
        count = 0;
      }
      final inputSeconds = int.tryParse(controller.text) ?? 0;
      if (isSecondsInput && inputSeconds > 59) {
        controller.text = '59';
        count = 59;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(widget.label,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary)),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                    ),
                    onPressed: () {
                      decrement(15);
                    },
                    child: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 75,
                    child: TextFormField(
                      controller: _controllerMinutes,
                      focusNode: _focusNodeMinutes,
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
                  const Text(
                    'Min',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  SizedBox(
                    width: 75,
                    child: TextFormField(
                      controller: _controllerSeconds,
                      focusNode: _focusNodeSeconds,
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
                  const Text(
                    'Sec',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                    ),
                    onPressed: () {
                      increment(15);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
