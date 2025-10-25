import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_domain/homerep.dart';
import 'package:task_entities/entities/task.dart';

import 'package:task_presentation/uicomponents/taskstate.dart';
import 'package:task_presentation/ui/addition.dart';
import 'package:task_presentation/ui/details.dart';
import 'package:task_presentation/ui/signin.dart';
import 'package:task_presentation/uicomponents/bg.dart';

import 'package:task_resources/l10n/app_localizations.dart';
import 'package:task_resources/gen/colors.gen.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';

// DI
import 'package:task_data/di/module.dart';

import '../uicomponents/nowloadingmodal.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Главный экран приложения, содержит календарь и список задач
 */
class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  late final HomeRepository _repository;
  bool _nowLoading = false; /// для лоадера при загрузке

  List<BusinessTask> _tasks = []; /// список задач для отображения

  DateTime _selectedDate = DateTime.now(); /// выбранная дата

  @override
  void initState() {
    super.initState();

    _repository = getIt<HomeRepository>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /**
       * Запрос задач для выбранный даты
       */
      _fetchTasks();
    });
  }

  /**
   * Запрос задач для выбранный даты
   */
  void _fetchTasks() async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    DateFormat dateFormat = DateFormat('dd.MM.yyyy');

    /**
     * Обновляем список задач от API
     */
    List<BusinessTask> tasks = await _repository.fetchTasks(dateFormat.format(_selectedDate));

    /**
     * Ответ от API получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    /**
     * Обновляем список на экране
     */
    setState(() {
      _tasks = tasks;
    });
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
        actions: <Widget>[
          _appMenu(),
        ],
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          AppLocalizations.of(context)!.dailytasks,
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

          _tasks.isNotEmpty ? _tasksList() : _emptyTasks(), /// в зависимости есть или нет задач показываем разные виджеты

        ?_nowLoading ? NowLoadingModal() : null, /// лоалер загрузки

        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _toAddition,
        tooltip: 'New Task',
        foregroundColor: ColorName.goldenColor,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /**
   * Навигация на экран добавления
   */
  void _toAddition() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => AdditionPage(selectedDate: _selectedDate, id: null),
      ),
    );
  }

  /**
   * Сообщение что список задач пуст
   */
  Widget _emptyTasks() {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _tasksCalendar();
          } else {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Text("No tasks added for this date\nPlease tap on \"+\" below to add new task",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 30.0,
                  color: ColorName.goldenColor,
                ),
              ),
            );
          }
        }
    );
  }

  /**
   * Список задач
   */
  Widget _tasksList() {
    return ListView.builder(
          itemCount: _tasks.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _tasksCalendar();
            } else {
              return GestureDetector(
                child: _taskListItem(_tasks[index - 1]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => DetailsPage(id: _tasks[index - 1].id),
                    ),
                  );
                },
              );
            }
          }
      );
  }

  /**
   * Верхнее боковое меню
   */
  Widget _appMenu() {
    return PopupMenuButton<String>(
      color: ColorName.taskAppColor,
      onSelected: (String result) {
        // Handle the selected menu item
        print('Selected: $result');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _logOutAlert();
          },
        );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Log out',
          child: Text(AppLocalizations.of(context)!.logout),
        ),
      ],
    );
  }

  /**
   * Выплывашка с подтверждением выхода из системы
   */
  Widget _logOutAlert() {
    return AlertDialog(
      backgroundColor: Colors.grey.shade500,
      title: Text(AppLocalizations.of(context)!.confirmation),
      content: Text(AppLocalizations.of(context)!.confirmlogout),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.cancel),
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            // Perform action here
            Navigator.of(context).pop(); // Dismiss the dialog

            _logOut();
          },
        ),
      ],
    );
  }

  /**
   * Выход из системы
   */
  void _logOut() async {

    await _repository.logOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const SignInPage(),
      ),
    );
  }

  /**
   * Календарь для выбора дня
   */
  Widget _tasksCalendar() {
    final ColorScheme appColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: ColorName.taskAppColor,
      onPrimary: Colors.white,
      secondary: ColorName.goldenColor,
      onSecondary: ColorName.goldenColor,
      tertiary: Colors.pink,
      onTertiary: Colors.pink,
      error: ColorName.nisekoiRedColor,
      onError: ColorName.nisekoiRedColor,
      surface: Colors.grey.shade500,
      onSurface: ColorName.goldenColor,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: appColorScheme,
      ),
      child: Builder(
          builder: (context) => EasyTheme(
            data: EasyTheme.of(context),
            child: EasyTheme(
              data: EasyTheme.of(context).copyWith(
                currentDayForegroundColor: WidgetStateProperty.resolveWith((states) {
                  return ColorName.goldenColor;
                }),
              ),
              child: EasyDateTimeLinePicker(
                focusedDate: _selectedDate,
                firstDate: DateTime(2024, 3, 18),
                lastDate: DateTime(2030, 3, 18),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                    _fetchTasks();
                  });
                },
              ),
            ),
          )
      ),
    );
  }

  /**
   * Элемент в списке задач
   */
  Widget _taskListItem(BusinessTask task) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), // Adjust radius as needed
          border: Border.all(
            color: ColorName.goldenColor, // Border color
            width: 1.0, // Border width
          ),
        ),

        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(task.taskDescription, /// описание задачи
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24.0,
                      color: ColorName.goldenColor,
                    ),
                  ),

                  taskStatusView(context, task, 16.0), /// статус задачи

                ],
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 10,
                children: <Widget>[
                  Text(task.startFrom, /// время начала
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),

                  Text(task.endAt, /// время окончания
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Text("➔",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24.0,
                  color: ColorName.goldenColor,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}