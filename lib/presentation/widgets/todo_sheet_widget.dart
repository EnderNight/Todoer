import 'package:flutter/material.dart';
import 'package:todoer/domain/todo.dart';

class TodoSheetWidget extends StatefulWidget {
  final Todo? todo;
  final String validateBtnText;
  final void Function(String title, TodoPriority priority) onValidate;
  final bool shouldClear;

  const TodoSheetWidget({
    super.key,
    this.todo,
    required this.validateBtnText,
    required this.onValidate,
    required this.shouldClear,
  });

  @override
  State<TodoSheetWidget> createState() => _TodoSheetWidgetState();
}

class _TodoSheetWidgetState extends State<TodoSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late TodoPriority selectedPriority;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.todo?.title);
    selectedPriority = widget.todo?.priority ?? TodoPriority.low;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please, enter a title.';
                }
                return null;
              },
              controller: controller,
            ),
            const SizedBox(height: 40),
            SegmentedButton<TodoPriority>(
              segments: const [
                ButtonSegment(
                  value: TodoPriority.low,
                  label: Text('Low'),
                  icon: Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.green,
                  ),
                ),
                ButtonSegment(
                  value: TodoPriority.medium,
                  label: Text('Medium'),
                  icon: Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.orange,
                  ),
                ),
                ButtonSegment(
                  value: TodoPriority.high,
                  label: Text('High'),
                  icon: Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.red,
                  ),
                ),
              ],
              showSelectedIcon: false,
              selected: {selectedPriority},
              onSelectionChanged: (selection) {
                setState(() {
                  selectedPriority = selection.first;
                });
              },
            ),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onValidate(controller.text, selectedPriority);

                  if (widget.shouldClear) {
                    controller.clear();
                  }
                }
              },
              label: Text(widget.validateBtnText),
            ),
          ],
        ),
      ),
    );
  }
}
