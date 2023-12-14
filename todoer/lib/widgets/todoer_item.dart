import 'package:flutter/material.dart';

class TodoerItemWidget extends StatelessWidget {
  const TodoerItemWidget({
    super.key,
    required this.todoerName,
    required this.onTap,
    required this.onDelete,
  });

  final String todoerName;
  final void Function() onTap;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(todoerName),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
