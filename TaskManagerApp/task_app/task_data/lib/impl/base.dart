import '../database.dart';

/**
 * Основная реализация репозиториев, содержит адрес сервера api и инстанс БД
 */
class BaseRepositoryImpl {

  final baseURL = "http://5.188.31.209:18640";

  late final AppDatabase database;

  BaseRepositoryImpl() {
    database = AppDatabase();
  }
}