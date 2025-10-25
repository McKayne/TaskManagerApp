import 'package:drift/drift.dart';

/**
 * Модель пользователя для БД
 */
class User extends Table {
  TextColumn get firstName => text().named('firstName')(); /// имя
  TextColumn get lastName => text().named('lastName')(); /// фамилия
  TextColumn get loginOrEmail => text().named('loginOrEmail')(); /// логин или почта
}