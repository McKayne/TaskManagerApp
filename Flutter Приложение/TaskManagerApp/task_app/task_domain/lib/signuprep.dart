/**
 * Репозиторий для экрана регистрации
 */
abstract interface class SignUpRepository {

  Future<bool> signUp(String firstName, String lastName, String loginOrEmail, String password);
}