import 'package:flutter/material.dart';
import 'package:habit_hero/widgets/glassmorphic_container.dart';

class AddHabit extends StatelessWidget {
  const AddHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassmorphicContainer(
      alignment: Alignment.topCenter,
      width: 0.9,
      height: 0.85,
      child: Center(
        child: Text("Habit", style: TextStyle(color: Colors.black, fontSize: 24)),
      ),
    );
  }
}
