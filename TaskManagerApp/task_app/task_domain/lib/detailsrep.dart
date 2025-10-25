
import 'package:task_domain/taskrep.dart';
import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';

/**
 * Репозиторий для экрана просмотра деталей задачи
 */
abstract interface class DetailsRepository implements TaskRepository {

  Future<bool> deleteTask(int id);

  Future<bool> changeTaskState(int id, TaskState taskState);
}