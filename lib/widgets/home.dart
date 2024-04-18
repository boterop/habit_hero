import 'package:flutter/material.dart';
import 'package:habit_hero/widgets/add_habit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    onAdd() {
      final addHabitRoute = MaterialPageRoute(
        builder: (context) => const AddHabit(),
      );
      Navigator.push(
        context,
        addHabitRoute,
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
