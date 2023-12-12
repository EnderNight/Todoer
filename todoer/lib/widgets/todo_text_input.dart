import 'package:flutter/material.dart';

class TodoTextInput extends StatelessWidget {
  const TodoTextInput({
    super.key,
    required this.todoTextController,
    required this.onSubmit,
  });

  final TextEditingController todoTextController;
  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: onSubmit,
              controller: todoTextController,
              decoration: const InputDecoration(
                  hintText: 'Enter a Todo'
              ),
            ),
          ),
        ),
      ],
    );
  }
}
