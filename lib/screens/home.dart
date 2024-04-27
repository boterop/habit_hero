import 'package:flutter/material.dart';
import 'package:habit_hero/screens/add_habit.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:habit_hero/services/user_service.dart';

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
    debugPrint("hodi");
    debugPrint(UserService.instance.session);
    APIService()
        .getHabitsList(userToken: UserService.instance.session)
        .then((response) => {
              debugPrint(response["data"].toString())
              // response.where((element) => false)
            })
        .catchError((error) => {debugPrint(error.toString())});
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
        body: Column(children: habitsList));
  }
}
