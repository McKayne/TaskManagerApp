import 'package:flutter/material.dart';
import 'package:task_domain/nowloadingrep.dart';
import 'package:task_presentation/ui/home.dart';
import 'package:task_presentation/ui/signin.dart';
import 'package:task_presentation/uicomponents/bg.dart';
import 'package:task_presentation/uicomponents/nowloadingmodal.dart';

// DI
import 'package:task_data/di/module.dart';

/**
 * Начальный экран приложения, его предназначение проверять залогинен ли пользователь в систему
 */
class NowLoadingPage extends StatefulWidget {

  final String title = 'Task Manager';

  const NowLoadingPage({super.key});

  @override
  State<StatefulWidget> createState() => _NowLoadingState();
}

class _NowLoadingState extends State<NowLoadingPage> {

  late final NowLoadingRepository _repository;

  @override
  void initState() {
    super.initState();

    _repository = getIt<NowLoadingRepository>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool hasSignedInUser = await _repository.hasSignedInUser();

      if (hasSignedInUser) {
        /**
         * Залогиненный пользователь есть, переводим приложение на главный экран
         */
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        /**
         * Нет залогиненного пользователя, переводим на вход в систему
         */
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const SignInPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 24.0,
            color: Colors.white, // Set the title color to white
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          /**
           * Полноэкранная картинка в качестве фона на всю страницу
           */
          background(),

          /**
           * Отображаем полноэкранный лоадер
           */
          NowLoadingModal(),
        ],
      ),
    );
  }
}