import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:task_data/di/module.config.dart';
import 'package:task_data/impl/addition.dart';
import 'package:task_data/impl/details.dart';
import 'package:task_data/impl/home.dart';
import 'package:task_data/impl/nowloadingimpl.dart';
import 'package:task_data/impl/signin.dart';
import 'package:task_data/impl/signup.dart';
import 'package:task_domain/additionrep.dart';
import 'package:task_domain/detailsrep.dart';
import 'package:task_domain/homerep.dart';
import 'package:task_domain/signinrep.dart';
import 'package:task_domain/signuprep.dart';
import 'package:task_domain/nowloadingrep.dart';

final getIt = GetIt.instance;

/**
 * Модуль для зависимостей dependency injection
 */
@InjectableInit()
void setupDependencies() {
  getIt.init();

  getIt.registerLazySingleton<NowLoadingRepository>(() => NowLoadingRepositoryImpl()); /// загрузка в начале
  getIt.registerLazySingleton<SignInRepository>(() => SignInRepositoryImpl()); /// вход в систему
  getIt.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl()); /// регистрация
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl()); /// главный экран
  getIt.registerLazySingleton<AdditionRepository>(() => AdditionRepositoryImpl()); /// добавление или удаление
  getIt.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl()); /// детали задачи
}