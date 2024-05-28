import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/widgets/confirm_dialog.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String name;
  final Function onConfirm;
  const ConfirmDeleteDialog(
      {super.key, required this.name, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
        description: AppLocalizations.of(context)!.confirmDelete(name),
        onConfirm: onConfirm);
  }
}
