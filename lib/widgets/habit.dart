import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/screens/add_habit.dart';

class Habit extends StatelessWidget {
  final Map<String, dynamic> habit;
  final Function updateHabits;
  const Habit({super.key, required this.habit, required this.updateHabits});

  @override
  Widget build(BuildContext context) {
    const int descriptionLength = 30;

    const Icon checkIcon = Icon(Icons.check, color: Colors.green);
    const Icon wipIcon = Icon(Icons.query_builder, color: Colors.amber);
    const Icon canceledIcon = Icon(Icons.do_disturb, color: Colors.grey);

    final bool isAGoodHabit = habit["type"] == "good";
    final String status = habit["status"];

    String difficulty = habit["difficulty"];
    String description = habit["description"];
    Color? difficultyTextColor;
    Color? difficultyBackgroundColor;

    switch (difficulty) {
      case "easy":
        difficulty = AppLocalizations.of(context)!.easy;
        difficultyTextColor = Colors.brown[900];
        difficultyBackgroundColor = Colors.green[200];
        break;
      case "medium":
        difficulty = AppLocalizations.of(context)!.medium;
        difficultyTextColor = Colors.blue[900];
        difficultyBackgroundColor = Colors.amber[200];
        break;
      default:
        difficulty = AppLocalizations.of(context)!.hard;
        difficultyTextColor = Colors.teal[900];
        difficultyBackgroundColor = Colors.red[200];
        break;
    }

    if (description.length > descriptionLength) {
      String shortedDesc = description.substring(0, descriptionLength);
      description = "$shortedDesc...";
    }

    void onEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddHabit(habit: habit, updateHabits: updateHabits)),
      );
    }

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ListTile(
                  leading: isAGoodHabit
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.heart_broken, color: Colors.grey),
                  title: Text(habit["name"]),
                  subtitle: Text(description),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      status == "done"
                          ? checkIcon
                          : status == "in_progress"
                              ? wipIcon
                              : canceledIcon
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Badge(
                    label: Text(difficulty),
                    textColor: difficultyTextColor,
                    backgroundColor: difficultyBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
                    IconButton(icon: const Icon(Icons.delete), onPressed: () {})
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
