
import 'package:task_domain/taskrep.dart';

/**
 * Репозиторий для экрана создания и редактирования задачи
 */
abstract interface class AdditionRepository implements TaskRepository {

  Future<bool> addTask(
      String date, String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskState, String taskDescription
      );

  Future<bool> updateTask(int id,
      String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskDescription);
}