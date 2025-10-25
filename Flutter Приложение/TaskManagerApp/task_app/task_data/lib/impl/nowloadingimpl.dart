
import 'package:task_data/impl/base.dart';
import 'package:task_domain/nowloadingrep.dart';
import 'package:task_data/database.dart';

/**
 * Репозиторий для начального экрана
 */
class NowLoadingRepositoryImpl extends BaseRepositoryImpl implements NowLoadingRepository {

  /**
   * Проверяет есть ли в БД залогиненный юзер
   */
  @override
  Future<bool> hasSignedInUser() async {
    UserData? signedInUser = await database.select(database.user).getSingleOrNull();
    return signedInUser != null;
  }
}