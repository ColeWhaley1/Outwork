import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormIncrementer extends StatefulWidget {
  const FormIncrementer({super.key, required this.label, required this.onChanged});

  final String label;
  final ValueChanged<int> onChanged;

  @override
  State<FormIncrementer> createState() => _FormIncrementer();
}

class _FormIncrementer extends State<FormIncrementer> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  int count = 0;

  final double minRowWidth = 200.0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
    _controller.addListener(updateCountWhenEnteredManually);
    _focusNode = FocusNode();
    _focusNode.addListener(handleFocusChange);
  }

  @override
  void dispose() {
    _controller.removeListener(updateCountWhenEnteredManually);
    _controller.dispose();
    _focusNode.dispose();
    _focusNode.removeListener(handleFocusChange);
    super.dispose();
  }

  void decrement() {
    setState(() {
      if (count > 0) {
        count--;
        _controller.text = count.toString();

      }
    });
  }

  void updateCountWhenEnteredManually() {
    final input = _controller.text;
    if (input.isNotEmpty) {
      setState(() {
        count = int.tryParse(input) ?? 0;
        widget.onChanged(count);
      });
    }
  }

  void increment() {
    setState(() {
      if (count < 99) {
        count++;
        _controller.text = count.toString();

      }
    });
  }

  void handleFocusChange() {
    if (!_focusNode.hasFocus) {
      FocusScope.of(context).unfocus();
      if (_controller.text.isEmpty) {
        _controller.text = '0';
        count = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: max(screenWidth, minRowWidth)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(5),
                      ),
                      onPressed: decrement,
                      child: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _controller,
                        focusNode: _focusNode,
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(5),
                      ),
                      onPressed: increment,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
