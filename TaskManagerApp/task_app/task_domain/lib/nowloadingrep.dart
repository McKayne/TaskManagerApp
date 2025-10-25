/**
 * Репозиторий для начального экрана, где идет проверка залогинен ли пользователь
 */
abstract interface class NowLoadingRepository {

  Future<bool> hasSignedInUser();
}