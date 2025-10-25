
import 'package:task_entities/entities/task.dart';

/**
 * Репозиторий для главного экрана списка задач
 */
abstract interface class HomeRepository {

  Future<List<BusinessTask>> fetchTasks(String date);

  Future<bool> logOut();
}