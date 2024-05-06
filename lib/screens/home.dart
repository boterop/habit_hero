import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_hero/screens/add_habit.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:habit_hero/widgets/habit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> habitsList = [];

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  void loadHabits() {
    APIService().getUserHabits().then((response) {
      switch (response) {
        case {"data": List habits}:
          List<Widget> widgetList = [];
          for (var habit in habits) {
            widgetList.add(Habit(habit: habit));
          }
          setState(() {
            habitsList = widgetList;
          });
          break;
        default:
          debugPrint(response.toString());
          break;
      }
    }).catchError((error) {
      Timer(const Duration(seconds: 10), loadHabits);
    });
  }

  @override
  Widget build(BuildContext context) {
    onAdd() {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AddHabit();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'addHabit',
        tooltip: 'Add',
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          Center(child: Column(children: habitsList)),
        ],
      ),
    );
  }
}
