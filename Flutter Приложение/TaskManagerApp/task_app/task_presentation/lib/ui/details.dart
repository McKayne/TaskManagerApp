import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_domain/detailsrep.dart';
import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';

import 'package:task_presentation/ui/addition.dart';
import 'package:task_presentation/ui/home.dart';
import 'package:task_presentation/uicomponents/bg.dart';

import 'package:task_resources/gen/colors.gen.dart';
import 'package:intl/intl.dart';

// DI
import 'package:task_data/di/module.dart';

import '../uicomponents/apierror.dart';
import '../uicomponents/nowloadingmodal.dart';
import '../uicomponents/taskstate.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Экран просмотра деталей задачи
 */
class DetailsPage extends StatefulWidget {

  final int id; /// айдишник выбранной задачи

  const DetailsPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {

  late final DetailsRepository _repository;
  bool _nowLoading = false; /// для индикации процесса загрузки

  BusinessTask? _task; /// локальная задача из БД

  @override
  void initState() {
    super.initState();

    _repository = getIt<DetailsRepository>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /**
       * Запрашиваем выбранную задачу из локальной БД
       */
      _fetchTask();
    });
  }

  /**
   * Запрос задачи
   */
  void _fetchTask() async {
    /**
     * Показываем лоадер что идет запрос к БД
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Запрос к БД
     */
    BusinessTask? task = await _repository.fetchTask(widget.id);

    /**
     * Ответ от БД получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    /**
     * Обвовляем информацию на экране
     */
    setState(() {
      _task = task;
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
          AppLocalizations.of(context)!.taskdetails,
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
         * Сам контент (информация о задаче)
         */
        if (_task != null) Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return _selectedDay(_task!); /// дата задачи
                    case 1:
                      return _startTime(_task!); /// начало задачи
                    case 2:
                      return _endTime(_task!); /// время конца задачи
                    case 3:
                      return _taskStatus(_task!); /// статус
                    default:
                      return _taskDescriptionField(_task!); /// описание
                  }
                }
            ),
          ),

            ?_nowLoading ? NowLoadingModal() : null, /// лоадер при работе с БД

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toEdit,
        tooltip: 'Edit Task',
        foregroundColor: ColorName.goldenColor,
        child: const Icon(Icons.edit),
      ),
    );
  }

  /**
   * Начало задачи
   */
  Widget _startTime(BusinessTask task) {
    return Container(
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
            child: Text(AppLocalizations.of(context)!.startfrom,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(task.startFrom,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }

  /**
   * Конец задачи
   */
  Widget _endTime(BusinessTask task) {
    return Container(
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
            child: Text(AppLocalizations.of(context)!.endat,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(task.endAt,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }

  /**
   * Статус задачи
   */
  Widget _taskStatus(BusinessTask task) {
    return Container(
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
            child: Text(AppLocalizations.of(context)!.taskstatus,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(10),
            child: taskStatusView(context, task, 24.0),
          ),

        ],
      ),
    );
  }


  /**
   * Поле описания задачи
   */
  Widget _taskDescriptionField(BusinessTask task) {
    return Container(
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
            child: Text(AppLocalizations.of(context)!.taskdescription,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(task.taskDescription,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }

  /**
   * Переход на экран редактирования
   */
  void _toEdit() {
    if (_task != null) {

      DateFormat dateFormat = DateFormat('dd.MM.yyyy');
      DateTime selectedDate = dateFormat.parse(_task!.date);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => AdditionPage(selectedDate: selectedDate, id: widget.id),
        ),
      );
    }
  }

  /**
   * Выбранный день
   */
  Widget _selectedDay(BusinessTask task) {
    return Container(
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
            child: Text(AppLocalizations.of(context)!.selectedday,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(task.date,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                color: ColorName.goldenColor,
              ),
            ),
          ),

        ],
      ),
    );
  }

  /**
   * Верхнее боковое меню
   */
  Widget _appMenu() {
    return PopupMenuButton<String>(
      color: ColorName.taskAppColor,
      onSelected: (String result) {
        if (_task != null) {
          TaskState taskState = TaskState.values.firstWhere((e) =>
          e.toString() == result);

          if (taskState != TaskState.deleted) {
            _changeTaskState(_task!.id, taskState);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _deleteTaskAlert(_task!.id);
              },
            );
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: TaskState.inProgress.toString(),
          child: Text(AppLocalizations.of(context)!.markinprogress), /// поставить в статус в выполнении
        ),
        PopupMenuItem<String>(
          value: TaskState.paused.toString(),
          child: Text(AppLocalizations.of(context)!.markpaused), /// поставить в статус паузы
        ),
        PopupMenuItem<String>(
          value: TaskState.wontDo.toString(),
          child: Text(AppLocalizations.of(context)!.markwontdo), /// поставить в статус не буду делать
        ),
        PopupMenuItem<String>(
          value: TaskState.done.toString(),
          child: Text(AppLocalizations.of(context)!.markdone), /// поставить в статус готово
        ),
        PopupMenuItem<String>(
          value: TaskState.deleted.toString(),
          child: Text(AppLocalizations.of(context)!.deletethis), /// удаление задачи
        ),
      ],
    );
  }

  /**
   * Модалка с подтверждением удаления задачи
   */
  Widget _deleteTaskAlert(int id) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade500,
      title: Text(AppLocalizations.of(context)!.confirmation),
      content: Text(AppLocalizations.of(context)!.confirmdelete),
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

            _deleteTask(id);
          },
        ),
      ],
    );
  }

  /**
   * Удаление задачи
   */
  void _deleteTask(int id) async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Удаляем задачу
     */
    if (!(await _repository.deleteTask(id))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return apiErrorAlert(context);
        },
      );
    }

    /**
     * Ответ от API получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    /**
     * Операция завершена, можно переводить юзера на основной экран
     */
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const HomePage(),
      ),
    );
  }

  /**
   * Смена статуса у задачи
   */
  void _changeTaskState(int id, TaskState taskState) async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Смена статуса на сервере
     */
    if (!(await _repository.changeTaskState(id, taskState))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return apiErrorAlert(context);
        },
      );
    }

    /**
     * Ответ от API получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    /**
     * Все ок, можно переводить юзера на основной экран
     */
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const HomePage(),
      ),
    );
  }
}