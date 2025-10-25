import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_resources/gen/assets.gen.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Отображение что какие-то обязательные поля являются пустыми
 */
Widget textErrorAlert(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.grey.shade500,
    title: Text(AppLocalizations.of(context)!.texterrorheader),
    content: Text(AppLocalizations.of(context)!.texterror),
    actions: <Widget>[
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          // Perform action here
          Navigator.of(context).pop(); // Dismiss the dialog
        },
      ),
    ],
  );
}