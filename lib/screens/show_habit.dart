import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<String> notifyList = ["hourly", "daily", "weekly", "monthly"];

class ShowHabit extends StatefulWidget {
  final Map<String, dynamic> habit;
  const ShowHabit({super.key, required this.habit});

  @override
  State<ShowHabit> createState() => _ShowHabitState();
}

class _ShowHabitState extends State<ShowHabit> {
  String image = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      image = widget.habit["done_image"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final isAGoodHabit = habit["type"] == "good";

    void onCam() {
      APIService().updateHabit({
        "id": habit["id"],
        "done_image": "https://www.boterop.io/avatar.jpg",
        "done_today": true
      }).then((response) {
        switch (response) {
          case {"data": Map habit}:
            setState(() {
              image = habit["done_image"];
            });
            // Congrats the user and go back
            break;
        }
      });
    }

    Widget head(String text) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              const Icon(Icons.recommend_outlined, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.makeIt(text),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget p(String text) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text),
        ),
      );
    }

    Widget createImage(String image) {
      if (image.isEmpty) return Container();
      return Padding(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(image, fit: BoxFit.cover),
          ));
    }

    Widget createStep(String step) {
      if (step.isEmpty) return Container();
      return Column(
        children: <Widget>[head(step), p(habit[step])],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(habit["name"]),
        actions: [
          isAGoodHabit
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.heart_broken, color: Colors.grey),
          const SizedBox(width: 15),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: onCam,
        child: const Icon(Icons.camera_alt, color: Colors.amber),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          createImage(image),
          createStep("obvious"),
          createStep("attractive"),
          createStep("easy"),
          createStep("satisfying"),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
