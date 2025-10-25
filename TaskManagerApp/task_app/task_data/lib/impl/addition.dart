
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:task_data/impl/task.dart';
import 'package:task_domain/additionrep.dart';
import 'package:task_data/database.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

/**
 * Реализация репозитория для добавления и редактирования задач
 */
class AdditionRepositoryImpl extends TaskRepositoryImpl implements AdditionRepository {

  /**
   * Добавляем задачу в апи и БД
   */
  @override
  Future<bool> addTask(
      String date, String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskState, String taskDescription
      ) async {

    bool success = false;

    UserData? signedInUser = await database.select(database.user).getSingleOrNull();

    int id = Random().nextInt(123456);
    if (signedInUser != null) {
      int? apiTaskID = await _apiAddTask(date, startFrom, endAt, startTime, endTime, taskState, taskDescription, signedInUser.loginOrEmail);

      if (apiTaskID != null) {
        id = apiTaskID;
        success = true;
      }
    }

    await _cacheApiTask(id, date, startFrom, endAt, startTime, endTime, taskState, taskDescription);

    return success;
  }

  /**
   * Кжшируем задачу от api в локальную БД для офлайна
   */
  Future<bool> _cacheApiTask(int id,
      String date, String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskState, String taskDescription) async {

    await database
        .into(database.task)
        .insertOnConflictUpdate(TaskCompanion(
          id: Value(id),

          date: Value(date),
          startFrom: Value(startFrom),
          endAt: Value(endAt),

          startTime: Value(startTime),
          endTime: Value(endTime),

          taskState: Value(taskState),
          taskDescription: Value(taskDescription)
        )
    );

    return true;
  }

  /**
   * Запрос к бекэнду для создания задачи на сервере
   */
  Future<int?> _apiAddTask(String date, String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskState, String taskDescription,
      String loginOrEmail) async {

    final apiUrl = Uri.parse('$baseURL/newtask/'); // Replace with your API endpoint

    try {
      String body = jsonEncode(<String, dynamic>{
        'date': date,
        'start_from': startFrom,
        'end_at': endAt,
        'start_time': startTime.toInt(),
        'end_time': endTime.toInt(),
        'task_state': taskState,
        'task_description': taskDescription,
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
          return result['id'];
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
   * Редактирование задачи (локально и на стороне api)
   */
  @override
  Future<bool> updateTask(
      int id,
      String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskDescription
      ) async {

    bool success = false;

    UserData? signedInUser = await database.select(database.user).getSingleOrNull();

    if (signedInUser != null) {
      if (await _apiUpdateTask(id, startFrom, endAt, startTime, endTime, taskDescription, signedInUser.loginOrEmail)) {
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
          startFrom: Value(startFrom),
          endAt: Value(endAt),

          startTime: Value(startTime),
          endTime: Value(endTime),

          taskState: Value(dateTask.taskState),
          taskDescription: Value(taskDescription)
      ));
    }

    return success;
  }

  /**
   * Запрос к бэку для редактирования задачи
   */
  Future<bool> _apiUpdateTask(int id,
      String startFrom, String endAt,
      BigInt startTime, BigInt endTime,
      String taskDescription,
      String loginOrEmail) async {

    final apiUrl = Uri.parse('$baseURL/updatetask/'); // Replace with your API endpoint

    try {
      String body = jsonEncode(<String, dynamic>{
        'task_id': id,
        'start_from': startFrom,
        'end_at': endAt,
        'start_time': startTime.toInt(),
        'end_time': endTime.toInt(),
        'task_description': taskDescription,
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