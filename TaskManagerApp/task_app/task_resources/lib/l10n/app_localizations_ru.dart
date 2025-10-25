// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String get applogo => 'Ваш лучший помошник в организации задач!';

  @override
  String get appsubtitle =>
      'Войдите в систему чтобы организовать Ваши задачи между устройствами';

  @override
  String get signin => 'Войти';

  @override
  String get signup => 'Регистрация';

  @override
  String get emaillogin => 'E-mail или логин';

  @override
  String get password => 'Пароль';

  @override
  String get confirmpassword => 'Подтверждение пароля';

  @override
  String get firstname => 'Ваше имя';

  @override
  String get lastname => 'Ваша фимилия';

  @override
  String get logout => 'Выход из системы';

  @override
  String get donthaveaccount => 'Еще нет аккаунта?';

  @override
  String get clicktosignup => 'Регистрация';

  @override
  String get enterdetails => 'Для регистрации укажите Ваши данные';

  @override
  String get privacy => 'Политика конфиденциальности';

  @override
  String get dailytasks => 'Ваши задачи';

  @override
  String get newtask => 'Новая задача';

  @override
  String get inprogress => 'В процессе';

  @override
  String get paused => 'На паузе';

  @override
  String get wontdo => 'Отменена';

  @override
  String get done => 'Сделана';

  @override
  String get deleted => 'Удалена';

  @override
  String get edittask => 'Редактирование задачи';

  @override
  String get selectedday => 'Выбранный день';

  @override
  String get startfrom => 'Начало с';

  @override
  String get endat => 'Конец в';

  @override
  String get taskdescription => 'Описание задачи';

  @override
  String get createtask => 'Создать задачу';

  @override
  String get updatetask => 'Обновить задачу';

  @override
  String get taskdetails => 'Просмотр задачи';

  @override
  String get taskstatus => 'Статус задачи';

  @override
  String get markinprogress => 'Пометить как В процессе';

  @override
  String get markpaused => 'Пометить как На паузе';

  @override
  String get markwontdo => 'Пометить как Отменена';

  @override
  String get markdone => 'Пометить как Сделана';

  @override
  String get deletethis => 'Удалить эту задачу';

  @override
  String get apierrorheader =>
      'Не удается выполнить это действие в настоящий момент';

  @override
  String get apierror =>
      'Возникла ошибка при выполнении Вашего запроса. Пожалуйста проверьте соединение с интернетом и попробуйте еще раз';

  @override
  String get passworderrorheader => 'Пароли не совпадают';

  @override
  String get passworderror =>
      'Пожалуйста проверьте Ваши данные и попробуйте еще раз';

  @override
  String get texterrorheader => 'Одно или несколько текстовых полей пустые';

  @override
  String get texterror =>
      'Пожалуйста проверьте Ваши данные и попробуйте еще раз';

  @override
  String get confirmation => 'Подтверждение операции';

  @override
  String get confirmdelete => 'Вы уверены что хотите удалить эту задачу?';

  @override
  String get confirmlogout => 'Вы уверены что хотите выйти из системы?';

  @override
  String get cancel => 'Отмена';
}
