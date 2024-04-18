import 'package:flutter/material.dart';
import 'package:habit_hero/widgets/glassmorphic_container.dart';

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
        body: const GlassmorphicContainer(
          child: Center(
            child: Text("Habit"),
          ),
        ));
  }
}
