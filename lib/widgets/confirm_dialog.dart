import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {
  final String name;
  final Function onConfirm;
  const ConfirmDialog({super.key, required this.name, required this.onConfirm});

  void _onConfirm() => onConfirm();

  void show(BuildContext context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => this,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.confirmDelete(name),
                textAlign: TextAlign.center),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _onConfirm();
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
