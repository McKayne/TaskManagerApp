/**
 * Модель залогиненного пользователя, для высокоуровневых уровней Clean Architecture, без привязки к конкретной БД
 */
class BusinessUser {

  late final String firstName;
  late final String lastName;
  late final String loginOrEmail;
}