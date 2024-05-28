import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/widgets/camera_screen.dart';
import 'package:habit_hero/widgets/square_image.dart';

List<String> notifyList = ["hourly", "daily", "weekly", "monthly"];

class ShowHabit extends StatefulWidget {
  final Map<String, dynamic> habit;
  const ShowHabit({super.key, required this.habit});

  @override
  State<ShowHabit> createState() => _ShowHabitState();
}

class _ShowHabitState extends State<ShowHabit> {
  String image = "";

  void onPictureTaken(XFile image) async {
    List<int> imageBytes = await image.readAsBytes();
    String encodedImage = base64.encode(imageBytes);

    Map result = await APIService()
        .uploadImage(id: widget.habit["id"], image: encodedImage);

    String imageUrl =
        result["data"]["done_image"] + "?" + DateTime.now().toString();
    setState(() {
      this.image = imageUrl;
    });
  }

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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            CameraScreen(onPictureTaken: onPictureTaken),
      );
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
          SquareImage(imageUrl: image, headers: APIService().headers),
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
