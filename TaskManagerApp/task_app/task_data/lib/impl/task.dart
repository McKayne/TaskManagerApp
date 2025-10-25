
import 'package:drift/drift.dart';
import 'package:task_data/impl/base.dart';
import 'package:task_domain/detailsrep.dart';
import 'package:task_data/database.dart';
import 'package:task_domain/taskrep.dart';
import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';

/**
 * Репозиторий для запроса деталей задачи
 */
class TaskRepositoryImpl extends BaseRepositoryImpl implements TaskRepository {

  /**
   * Запрос задачи из локальной БД
   */
  @override
  Future<BusinessTask?> fetchTask(int id) async {

    TaskData? dateTask = await (database.select(database.task)
      ..where((t) => t.id.equals(id))).getSingleOrNull();

    if (dateTask != null) {
      BusinessTask task = BusinessTask();
      task.id = dateTask.id;

      task.date = dateTask.date;
      task.startFrom = dateTask.startFrom;
      task.endAt = dateTask.endAt;

      task.startTime = dateTask.startTime;
      task.endTime = dateTask.endTime;

      task.taskState = dateTask.taskState;
      task.taskDescription = dateTask.taskDescription;

      return task;
    }

    return null;
  }
}