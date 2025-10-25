
import 'package:drift/drift.dart';
import 'package:task_data/impl/task.dart';
import 'package:task_domain/detailsrep.dart';
import 'package:task_data/database.dart';
import 'package:task_entities/enums/taskstate.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

/**
 * Реализация интерфейса для просмотра, редаутирования статуса, удаления выбранной задачи
 */
class DetailsRepositoryImpl extends TaskRepositoryImpl implements DetailsRepository {

  /**
   * Удаление задачи
   */
  @override
  Future<bool> deleteTask(int id) async {

    bool success = false;

    UserData? signedInUser = await database.select(database.user).getSingleOrNull();

    if (signedInUser != null) {
      if (await _apiDeleteTask(id, signedInUser.loginOrEmail)) {
        success = true;
      }
    }

    await (database.delete(database.task)
      ..where((t) => t.id.equals(id))).go();

    return success;
  }

  /**
   * Делаем запрос к апи об удалении задачи
   */
  Future<bool> _apiDeleteTask(int id, String loginOrEmail) async {

    final apiUrl = Uri.parse('$baseURL/deletetask/'); // Replace with your API endpoint

    try {
      String body = jsonEncode(<String, dynamic>{
        'task_id': id,
        'login_or_email': loginOrEmail,
      });

      final response = await http.post(
          apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      if (response.statusCode < 400) { // 201 Created is common for successful POST
        Map<String, dynamic> result = jsonDecode(response.body);

        if (result['success']) {
          return true;
        }
      } else {
        print('Failed to make POST request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }

    return false;
  }

  /**
   * Смена статуса для задачи
   */
  @override
  Future<bool> changeTaskState(int id, TaskState taskState) async {

    bool success = false;

    UserData? signedInUser = await database.select(database.user).getSingleOrNull();

    if (signedInUser != null) {
      if (await _apiChangeTaskState(id, taskState, signedInUser.loginOrEmail)) {
        success = true;
      }
    }

    TaskData? dateTask = await (database.select(database.task)
      ..where((t) => t.id.equals(id))).getSingleOrNull();

    if (dateTask != null) {
      await (database.update(database.task)
        ..where((t) => t.id.equals(id))).write(TaskCompanion(
          id: Value(id),

          date: Value(dateTask.date),
          startFrom: Value(dateTask.startFrom),
          endAt: Value(dateTask.endAt),

          startTime: Value(dateTask.startTime),
          endTime: Value(dateTask.endTime),

          taskState: Value(taskState.toString()),
          taskDescription: Value(dateTask.taskDescription)
      ));
    }

    return success;
  }

  /**
   * Запрос к API на изменение статуса задачи на сервере
   */
  Future<bool> _apiChangeTaskState(int id, TaskState taskState, String loginOrEmail) async {

    final apiUrl = Uri.parse('$baseURL/changestate/'); // Replace with your API endpoint

    try {
      String body = jsonEncode(<String, dynamic>{
        'task_id': id,
        'task_state': taskState.toString(),
        'login_or_email': loginOrEmail,
      });

      final response = await http.post(
          apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      if (response.statusCode < 400) { // 201 Created is common for successful POST
        Map<String, dynamic> result = jsonDecode(response.body);

        if (result['success']) {
          return true;
        }
      } else {
        print('Failed to make POST request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }

    return false;
  }
}