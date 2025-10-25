
import 'package:drift/drift.dart';

import 'package:task_data/impl/base.dart';
import 'package:task_domain/homerep.dart';
import 'package:task_entities/entities/task.dart';
import 'package:task_data/database.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

/**
 * Репозиторий для главного экрана в приложении
 */
class HomeRepositoryImpl extends BaseRepositoryImpl implements HomeRepository {

  /**
   * Получение списка задач для юзера
   */
  @override
  Future<List<BusinessTask>> fetchTasks(String date) async {
    UserData? signedInUser = await database.select(database.user).getSingleOrNull();

    if (signedInUser != null) {
      List<BusinessTask>? apiTasks = await _apiTasks(signedInUser.loginOrEmail);

      if (apiTasks != null) {
        await database.delete(database.task).go();

        await _cacheApiTasks(apiTasks);
      }
    }

    List<BusinessTask> tasks = await _dbFetchTasks(date);

    return tasks;
  }

  /**
   * Кэшируем в БД полученный список задач
   */
  Future<bool> _cacheApiTasks(List<BusinessTask> apiTasks) async {

    for (BusinessTask apiTask in apiTasks) {
      await database
          .into(database.task)
          .insertOnConflictUpdate(TaskCompanion(
            id: Value(apiTask.id),

            date: Value(apiTask.date),
            startFrom: Value(apiTask.startFrom),
            endAt: Value(apiTask.endAt),

            startTime: Value(apiTask.startTime),
            endTime: Value(apiTask.endTime),

            taskState: Value(apiTask.taskState),
            taskDescription: Value(apiTask.taskDescription)
        )
      );
    }

    return true;
  }

  /**
   * Запрашиваем список задач из БД для выбранного дня для отображения
   */
  Future<List<BusinessTask>> _dbFetchTasks(String date) async {
    List<TaskData> dateTasks = await (database.select(database.task)
      ..where((t) => t.date.equals(date))).get();
    List<BusinessTask> tasks = [];

    for (TaskData dateTask in dateTasks) {
      BusinessTask task = BusinessTask();
      task.id = dateTask.id;

      task.date = dateTask.date;
      task.startFrom = dateTask.startFrom;
      task.endAt = dateTask.endAt;

      task.startTime = dateTask.startTime;
      task.endTime = dateTask.endTime;

      task.taskState = dateTask.taskState;
      task.taskDescription = dateTask.taskDescription;

      tasks.add(task);
    }

    return tasks;
  }

  /**
   * Запрос актуального списка задач из api
   */
  Future<List<BusinessTask>?> _apiTasks(String loginOrEmail) async {

    final apiUrl = Uri.parse('$baseURL/tasks/'); // Replace with your API endpoint

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login_or_email': loginOrEmail
        }),
      );

      if (response.statusCode < 400) { // 201 Created is common for successful POST
        Map<String, dynamic> result = jsonDecode(response.body);

        if (result['success']) {
          List<BusinessTask> tasks = [];

          for (Map<String, dynamic> dateTask in result['tasks']) {
            BusinessTask task = BusinessTask();
            task.id = dateTask['id'];

            task.date = dateTask['date'];
            task.startFrom = dateTask['start_from'];
            task.endAt = dateTask['end_at'];

            task.startTime = BigInt.from(dateTask['start_time']);
            task.endTime = BigInt.from(dateTask['end_time']);

            task.taskState = dateTask['task_state'];
            task.taskDescription = dateTask['task_description'];

            tasks.add(task);
          }

          return tasks;
        }
      } else {
        print('Failed to make POST request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }

    return null;
  }

  /**
   * Выход из системы
   */
  @override
  Future<bool> logOut() async {
    await database.delete(database.user).go();
    await database.delete(database.task).go();

    return true;
  }
}