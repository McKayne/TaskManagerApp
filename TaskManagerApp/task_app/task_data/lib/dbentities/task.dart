import 'package:drift/drift.dart';

/**
 * Модель задачи для БД
 */
class Task extends Table {
  IntColumn get id => integer().named('id')(); /// айдишник для изменения или удаления задачи

  TextColumn get date => text().named('date')(); /// дата задачи
  TextColumn get startFrom => text().named('startFrom')(); /// время начала
  TextColumn get endAt => text().named('endAt')(); /// время окончания

  Int64Column get startTime => int64().named('startTime')(); /// время начала в unixtime
  Int64Column get endTime => int64().named('endTime')(); /// время конца в unixtime

  TextColumn get taskState => text().named('taskState')(); /// статус задачи
  TextColumn get taskDescription => text().named('taskDescription')(); /// описание

  @override
  Set<Column<Object>> get primaryKey => {id};
}