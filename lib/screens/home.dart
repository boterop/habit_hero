import 'package:flutter/material.dart';
import 'package:habit_hero/screens/add_habit.dart';

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
      body: Center(
        child: Stack(
          children: [
            Container(
              child: const Center(
                child: Text("DATA"),
              ),
            ),
            const AddHabit(),
          ],
        ),
      ),
    );
  }
}
