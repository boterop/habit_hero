import 'package:flutter/material.dart';

class AddHabit extends StatelessWidget {
  const AddHabit({super.key});

  @override
  Widget build(BuildContext context) {
    onAdd() {
      Navigator.pop(context);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        backgroundColor: Colors.teal,
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text("Habit"),
      ),
    );
  }
}
