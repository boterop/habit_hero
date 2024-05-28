import 'package:flutter/material.dart';
import 'package:habit_hero/screens/add_habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/services/user_service.dart';
import 'package:habit_hero/widgets/confirm_dialog.dart';

class Home extends StatefulWidget {
  final List<Widget> habitsList;
  final Function updateHabits;
  const Home({super.key, required this.habitsList, required this.updateHabits});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    onAdd() {
      if (UserService.instance.id == "") {
        return showDialog<String>(
          context: context,
          builder: (BuildContext context) => ConfirmDialog(
              description: AppLocalizations.of(context)!.signInToContinue,
              onConfirm: () {}),
        );
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AddHabit(updateHabits: widget.updateHabits);
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
          Center(child: Column(children: widget.habitsList)),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
