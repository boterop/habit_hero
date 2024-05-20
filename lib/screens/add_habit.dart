import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/widgets/center_form_field.dart';
import 'package:habit_hero/widgets/date_picker.dart';

List<String> notifyList = ["hourly", "daily", "weekly", "monthly"];

class AddHabit extends StatefulWidget {
  final Function updateHabits;
  final Map<String, dynamic>? habit;
  const AddHabit({super.key, required this.updateHabits, this.habit});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool visibleDatePicker = false;
  DateTime endDate = DateTime.now();
  bool isAGoodHabit = true;

  String notify = notifyList.first;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? habit = widget.habit;
    if (habit != null) {
      nameController.text = habit["name"];
      descriptionController.text = habit["description"];
      endDate = DateTime.parse(habit["end_date"]);
      isAGoodHabit = habit["type"] == "good";
      notify = habit["notify"];
    }
  }

  @override
  Widget build(BuildContext context) {
    onCancel() => Navigator.pop(context);

    void onCreate() {
      final String name = nameController.text;
      final String description = descriptionController.text;
      final String type = isAGoodHabit ? "good" : "bad";

      if (widget.habit != null) {
        APIService()
            .updateHabit(
                id: widget.habit?["id"],
                type: type,
                name: name,
                description: description,
                notify: notify,
                endDate: endDate)
            .then((response) {
          debugPrint(response.toString());
          switch (response) {
            case {"data": Map _}:
              widget.updateHabits();
              onCancel();
              break;
          }
        });
        return;
      }

      APIService()
          .createHabit(
              type: type,
              name: name,
              description: description,
              notify: notify,
              endDate: endDate)
          .then((response) {
        debugPrint(response.toString());
        switch (response) {
          case {"data": Map _}:
            widget.updateHabits();
            onCancel();
            break;
        }
      });
    }

    void toggleDatePicker() {
      setState(() {
        visibleDatePicker = !visibleDatePicker;
      });
    }

    void onDateSelected(DateTime date) {
      endDate = date;
      toggleDatePicker();
    }

    void onSelectNotification(String? value) {
      setState(() {
        notify = value!;
      });
    }

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            onCreate();
          }
        },
        child: Text(widget.habit != null
            ? AppLocalizations.of(context)!.update
            : AppLocalizations.of(context)!.create),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CenterFormField(
                  controller: nameController,
                  hint: AppLocalizations.of(context)!.name,
                  prefixIcon: Hero(
                    tag: 'addHabit',
                    child: IconButton(
                      icon: isAGoodHabit
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.heart_broken),
                      color: isAGoodHabit ? Colors.red : Colors.grey,
                      iconSize: 40,
                      onPressed: () {
                        setState(() {
                          isAGoodHabit = !isAGoodHabit;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterValid("name");
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: CenterFormField(
                    controller: descriptionController,
                    hint: AppLocalizations.of(context)!.description,
                    border: InputBorder.none,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .enterValid("description");
                      }
                      return null;
                    },
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("${AppLocalizations.of(context)!.notify}:"),
                  const SizedBox(width: 10),
                  DropdownButton(
                      items: notifyList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: notify,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: onSelectNotification)
                ]),
                visibleDatePicker
                    ? DatePicker(onDateSelected: onDateSelected)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${AppLocalizations.of(context)!.endDate}:"),
                          TextButton(
                            onPressed: toggleDatePicker,
                            child: Text(
                              endDate.toString().split(" ")[0],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
