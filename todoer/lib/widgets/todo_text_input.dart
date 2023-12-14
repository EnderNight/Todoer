import 'package:flutter/material.dart';

class TodoTextInput extends StatelessWidget {
  const TodoTextInput({
    super.key,
    required this.todoTextController,
    required this.onSubmit,
    required this.hintText,
  });

  final TextEditingController todoTextController;
  final void Function(String) onSubmit;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: onSubmit,
              controller: todoTextController,
              decoration: InputDecoration(hintText: hintText),
            ),
          ),
        ),
      ],
    );
  }
}
