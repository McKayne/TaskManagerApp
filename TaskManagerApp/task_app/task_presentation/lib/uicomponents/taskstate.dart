
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Отображения статуса задачи
 */
Widget taskStatusView(BuildContext context, BusinessTask task, double fontSize) {
  TaskState taskState = TaskState.values.firstWhere((e) => e.toString() == task.taskState); /// конвертируем строку в элемент перечисления

  switch (taskState) {
    case TaskState.newTask:
      return Text(AppLocalizations.of(context)!.newtask, /// новая задача
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.green,
        ),
      );
    case TaskState.inProgress:
      return Text(AppLocalizations.of(context)!.inprogress, /// в процессе
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.green,
        ),
      );
    case TaskState.paused:
      return Text(AppLocalizations.of(context)!.paused, /// на паузе
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.orange,
        ),
      );
    case TaskState.wontDo:
      return Text(AppLocalizations.of(context)!.wontdo, /// я не буду это делать
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.pink,
        ),
      );
    case TaskState.done:
      return Text(AppLocalizations.of(context)!.done, /// задача готова
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.grey.shade700,
        ),
      );
    case TaskState.deleted:
      return Text(AppLocalizations.of(context)!.deleted, /// задачу удалена
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: fontSize,
          color: Colors.red,
        ),
      );
  }
}