
import 'package:drift/drift.dart';
import 'package:task_data/impl/base.dart';
import 'package:task_domain/signuprep.dart';
import 'package:task_data/database.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

/**
 * Репощиторий для реги пользователей в приложении
 */
class SignUpRepositoryImpl extends BaseRepositoryImpl implements SignUpRepository {

  /**
   * Рега нового пользователя
   */
  @override
  Future<bool> signUp(String firstName, String lastName, String loginOrEmail, String password) async {
    if (await _apiSignUp(firstName, lastName, loginOrEmail, password)) {
        await database
            .into(database.user)
            .insert(UserCompanion(
            firstName: Value(firstName),
            lastName: Value(lastName),
            loginOrEmail: Value(loginOrEmail)
        )
      );

      return true;
    }

    return false;
  }

  /**
   * Запрос для реги в API
   */
  Future<bool> _apiSignUp(String firstName, String lastName, String loginOrEmail, String password) async {

    final apiUrl = Uri.parse('$baseURL/signup/'); // Replace with your API endpoint

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'first_name': firstName,
          'last_name': lastName,
          'login_or_email': loginOrEmail,
          'password': password,
        }),
      );

      if (response.statusCode < 400) { // 201 Created is common for successful POST
        Map<String, dynamic> result = jsonDecode(response.body);

        return result['success'];
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