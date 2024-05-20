import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/widgets/center_form_field.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isAGoodHabit = true;

  @override
  Widget build(BuildContext context) {
    onCancel() => Navigator.pop(context);

    void onCreate() {
      final String name = nameController.text;
      final String description = descriptionController.text;
      final String type = isAGoodHabit ? "good" : "bad";
      APIService()
          .createHabit(type: type, name: name, description: description)
          .then((response) {
        debugPrint(response.toString());
        switch (response) {
          case {"data": Map _}:
            onCancel();
            break;
        }
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
        child: Text(AppLocalizations.of(context)!.create),
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
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
