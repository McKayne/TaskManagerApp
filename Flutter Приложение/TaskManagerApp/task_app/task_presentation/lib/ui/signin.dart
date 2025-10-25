import 'package:flutter/material.dart';
import 'package:task_domain/signinrep.dart';
import 'package:task_presentation/ui/home.dart';
import 'package:task_presentation/ui/signup.dart';
import 'package:task_presentation/uicomponents/bg.dart';
import 'package:task_presentation/uicomponents/nowloadingmodal.dart';

import 'package:task_resources/l10n/app_localizations.dart';

// DI
import 'package:task_data/di/module.dart';

import '../uicomponents/apierror.dart';
import '../uicomponents/texterror.dart';

/**
 * Экран входа в систему
 */
class SignInPage extends StatefulWidget {

  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {

  late final SignInRepository _repository;
  bool _nowLoading = false; /// лоадер для загрузки

  String _loginOrEmail = ""; /// логин пользователя при входе
  String _password = ""; /// пароль

  @override
  void initState() {
    super.initState();

    _repository = getIt<SignInRepository>();

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          AppLocalizations.of(context)!.welcome,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 24.0,
            color: Colors.white, // Set the title color to white
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
                 * Секция для логотипа
                 */
                _logoSection(),

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

          ?_nowLoading ? NowLoadingModal() : null, /// лоадер при запросе API

        ],
      ),
    );
  }

  /**
   * Входим в систему
   */
  void _signIn() async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Логинимся
     */
    bool isSuccess = await _repository.signIn(_loginOrEmail, _password);

    /**
     * Ответ от API получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    if (isSuccess) {
      /**
       * Логин успешный, можно переводить юзера на основной экран
       */
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      /**
       * Что-то не так с логином, отображаем ошибку и предложение попробовать еще раз
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
   * Секция для логотипа
   */
  Widget _logoSection() {
    return Flexible(
        flex: 1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(AppLocalizations.of(context)!.applogo, //Text('Your best helper in timely task organization!',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 48.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
  }

  /**
   * Секция для полей ввода данных
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
              child: Text(AppLocalizations.of(context)!.appsubtitle,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),


            TextField(
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.emaillogin),
              onChanged: (value) {
                _loginOrEmail = value;
              },
            ),

            TextField(
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.password),
              onChanged: (value) {
                _password = value;
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
                    if (_loginOrEmail.isNotEmpty && _password.isNotEmpty) {
                      _signIn();
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
                    child: Text(AppLocalizations.of(context)!.signin,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                ),

              ),

            ),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text(AppLocalizations.of(context)!.donthaveaccount,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(AppLocalizations.of(context)!.clicktosignup,
                        style: const TextStyle(
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