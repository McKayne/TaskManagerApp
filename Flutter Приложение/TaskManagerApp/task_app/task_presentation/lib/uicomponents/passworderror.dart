import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_resources/gen/assets.gen.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Отображение ошибки при несовпадающих паролях
 */
Widget passwordErrorAlert(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.grey.shade500,
    title: Text(AppLocalizations.of(context)!.passworderrorheader),
    content: Text(AppLocalizations.of(context)!.passworderror),
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