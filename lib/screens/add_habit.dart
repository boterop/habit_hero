import 'package:flutter/material.dart';

class AddHabit extends StatelessWidget {
  const AddHabit({super.key});

  @override
  Widget build(BuildContext context) {
    onCancel() => Navigator.pop(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'cancel',
        onPressed: onCancel,
        child: const Icon(Icons.cancel_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const Center(
        child: Hero(
          tag: 'addHabit',
          child: Text("Habit", style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
