/**
 * Модель задачи, для высокоуровневых уровней Clean Architecture, без привязки к конкретной БД
 */
class BusinessTask {
  late final int id;

  late final String date;
  late final String startFrom;
  late final String endAt;

  late final BigInt startTime;
  late final BigInt endTime;

  late final String taskState;
  late final String taskDescription;
}