import 'package:flutter/material.dart';
import 'package:task_presentation/ui/privacy.dart';
import 'package:task_presentation/uicomponents/bg.dart';
import 'package:task_domain/signuprep.dart';

// DI
import 'package:task_data/di/module.dart';
import 'package:task_presentation/uicomponents/passworderror.dart';

import '../uicomponents/apierror.dart';
import '../uicomponents/nowloadingmodal.dart';
import '../uicomponents/texterror.dart';
import 'home.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Экран регистрации в приложении
 */
class SignUpPage extends StatefulWidget {

  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {

  late final SignUpRepository _repository;
  bool _nowLoading = false; /// лоадер при запросах

  String _firstName = ""; /// имя
  String _lastName = ""; /// фамилия
  String _loginOrEmail = ""; /// логин пользователя
  String _password = ""; /// пароль
  String _confirmPassword = ""; /// подтверждение пароля

  @override
  void initState() {
    super.initState();

    _repository = getIt<SignUpRepository>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppLocalizations.of(context)!.signup,
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 24.0,
              color: Colors.white
            ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /**
           * Полноэкранная картинка в качестве фона на всю страницу
           */
          background(),

          /**
           * Сам контент (лого, поля для данных, кнопки снизу в вертикальном виде)
           */
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16), /// Добавим общие отступы по краям слева-справа
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                /**
                 * Секция для полей ввода данных
                 */
                _userDetailsSection(),

                /**
                 * Секция для кнопок внизу
                 */
                _buttonsSection(),

              ],
            ),
          ),

          ?_nowLoading ? NowLoadingModal() : null,

        ],
      ),
    );
  }

  /**
   * Регаемся и входим в систему
   */
  void _signUp() async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Регаемся и сразу логинимся
     */
    bool isSuccess = await _repository.signUp(_firstName, _lastName, _loginOrEmail, _password);

    /**
     * Ответ от API получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    if (isSuccess) {
      /**
       * Все окей, можно переводить юзера на основной экран
       */
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      /**
       * Что-то не так с регой, отображаем ошибку и предложение попробовать еще раз
       */
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return apiErrorAlert(context);
        },
      );
    }
  }

  /**
   * Сам контент (лого, поля для данных, кнопки снизу в вертикальном виде)
   */
  Widget _userDetailsSection() {
    return Flexible(
      flex: 1,
      child: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(AppLocalizations.of(context)!.enterdetails,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),


            /**
             * Имя пользователя
             */
            TextField(
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.firstname),
              onChanged: (value) {
                _firstName = value;
              },
            ),

            /**
             * Фамилия
             */
            TextField(
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.lastname),
              onChanged: (value) {
                _lastName = value;
              },
            ),

            /**
             * Логин юзера
             */
            TextField(
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.emaillogin),
              onChanged: (value) {
                _loginOrEmail = value;
              },
            ),

            /**
             * Пароль
             */
            TextField(
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.password),
              onChanged: (value) {
                _password = value;
              },
            ),

            /**
             * Подтверждение пароля
             */
            TextField(
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.confirmpassword),
              onChanged: (value) {
                _confirmPassword = value;
              },
            ),

          ],
        ),
      ),
    );
  }

  /**
   * Секция для кнопок внизу
   */
  Widget _buttonsSection() {
    return Flexible(
      flex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /**
             * Кнопка для входа
             */
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_firstName.isNotEmpty && _lastName.isNotEmpty && _loginOrEmail.isNotEmpty && _password.isNotEmpty && _confirmPassword.isNotEmpty) {
                      if (_password == _confirmPassword) {
                        _signUp();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return passwordErrorAlert(context);
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return textErrorAlert(context);
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(AppLocalizations.of(context)!.signup,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                ),

              ),

            ),

            /**
             * Политика конфиденциальности
             */
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(AppLocalizations.of(context)!.privacy,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Lato',
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),

                    ),

                  ),


                ]),



          ],
        ),
      ),
    );
  }
}