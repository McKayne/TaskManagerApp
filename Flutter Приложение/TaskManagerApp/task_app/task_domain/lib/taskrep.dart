
import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';

/**
 * Вспомогательный репозиторий, содержит определение метода запроса задачи из локальной БД
 */
abstract interface class TaskRepository {

  Future<BusinessTask?> fetchTask(int id);
}