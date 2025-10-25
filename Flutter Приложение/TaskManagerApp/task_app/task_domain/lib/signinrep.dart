/**
 * Репозиторий для экрана входа в систему
 */
abstract interface class SignInRepository {

  Future<bool> signIn(String loginOrEmail, String password);
}