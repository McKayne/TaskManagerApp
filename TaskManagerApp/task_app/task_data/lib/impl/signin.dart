
import 'package:drift/drift.dart';
import 'package:task_data/impl/base.dart';
import 'package:task_domain/signinrep.dart';
import 'package:task_data/database.dart';
import 'package:task_entities/entities/user.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

/**
 * Репозиторий для экрана входа в систему
 */
class SignInRepositoryImpl extends BaseRepositoryImpl implements SignInRepository {

  /**
   * Логин в систему
   */
  @override
  Future<bool> signIn(String loginOrEmail, String password) async {

    BusinessUser? user = await _apiSignIn(loginOrEmail, password);

    if (user != null) {
      await database
        .into(database.user)
        .insert(UserCompanion(
          firstName: Value(user.firstName),
          lastName: Value(user.lastName),
          loginOrEmail: Value(user.loginOrEmail)
        )
      );

      return true;
    }

    return false;
  }

  /**
   * Запрос для логина
   */
  Future<BusinessUser?> _apiSignIn(String loginOrEmail, String password) async {

    final apiUrl = Uri.parse('$baseURL/signin/'); // Replace with your API endpoint

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login_or_email': loginOrEmail,
          'password': password,
        }),
      );

      if (response.statusCode < 400) { // 201 Created is common for successful POST
        Map<String, dynamic> result = jsonDecode(response.body);

        if (result['success']) {
          BusinessUser user = BusinessUser();
          user.firstName = result['first_name'];
          user.lastName = result['last_name'];
          user.loginOrEmail = loginOrEmail;
          return user;
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
}