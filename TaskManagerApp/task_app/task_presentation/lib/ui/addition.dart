
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_entities/entities/task.dart';
import 'package:task_entities/enums/taskstate.dart';
import 'package:task_presentation/ui/home.dart';
import 'package:task_presentation/uicomponents/bg.dart';
import 'package:task_presentation/uicomponents/texterror.dart';

import 'package:task_resources/l10n/app_localizations.dart';
import 'package:task_resources/gen/colors.gen.dart';

import 'package:one_clock/one_clock.dart';
import 'package:task_domain/additionrep.dart';

import 'package:intl/intl.dart';

// DI
import 'package:task_data/di/module.dart';

import '../uicomponents/apierror.dart';
import '../uicomponents/nowloadingmodal.dart';

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Экран добавления и редактирования задач
 */
class AdditionPage extends StatefulWidget {

  final int? id; /// айдишник выбранной задачи (при редактировании)

  DateTime selectedDate; /// дата задачи

  AdditionPage({super.key, required this.selectedDate, required this.id});

  @override
  State<StatefulWidget> createState() => _AdditionState();
}

class _AdditionState extends State<AdditionPage> {

  late final AdditionRepository _repository;
  bool _nowLoading = false; /// для индикации загрузки

  BusinessTask? _task; /// локальная задачи из БД (при редактировании)

  DateTime _startFrom = DateTime.now(); /// время начала задачи
  DateTime _endAt = DateTime.now(); /// время завершения задачи
  String _taskDescription = ""; /// описание задачи

  @override
  void initState() {
    super.initState();

    _repository = getIt<AdditionRepository>();

    if (widget.id != null) {
      /**
       * Если в виджет передан не нулевой айди значит идет редактирование существующей задачи
       */
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        /**
         * Запрашиваем редактируемую задачу из БД
         */
        _fetchTask(widget.id!);
      });
    }

  }

  /**
   * Запрос задачи из БД
   */
  void _fetchTask(int id) async {
    /**
     * Показываем лоадер что идет запрос к БД
     */
    setState(() {
      _nowLoading = true;
    });

    /**
     * Сам запрос из БД
     */
    BusinessTask? task = await _repository.fetchTask(id);

    /**
     * Ответ получен, можно убирать лоадер
     */
    setState(() {
      _nowLoading = false;
    });

    setState(() {
      _task = task;

      /**
       * Обновляем поля на экране значениями из редактируемой задачи
       */
      if (task != null) {
        DateFormat dateFormat = DateFormat('dd.MM.yyyy');
        widget.selectedDate = dateFormat.parse(task.date);

        _startFrom =
            DateTime.fromMillisecondsSinceEpoch(task.startTime.toInt());
        _endAt =
            DateTime.fromMillisecondsSinceEpoch(task.endTime.toInt());
      }
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.id != null ? AppLocalizations.of(context)!.edittask : AppLocalizations.of(context)!.newtask,
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
         * Список полей данных для создания/редактирования задачи
         */
        Padding(
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
                      return _selectedDay(); /// дата задачи
                    case 1:
                      return _startTime(); /// время начала
                    case 2:
                      return _endTime(); /// конец задачи
                    case 3:
                      return _taskDescriptionField(); /// поле описания
                    default:
                      return _confirmationButton(); /// кнопка подтверждения
                  }
                }
            ),
          ),

          ?_nowLoading ? NowLoadingModal() : null, /// лоадер при запросах
        ],
      ),
    );
  }

  /**
   * Дата задачи
   */
  Widget _selectedDay() {

    DateFormat dateFormat = DateFormat('dd.MM.yyyy');

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
            child: Text(dateFormat.format(widget.selectedDate),
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
   * Начало задачи
   */
  Widget _startTime() {
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

          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: DigitalClock(
                  showSeconds: false,
                  isLive:false,
                  digitalClockTextColor: Colors.black,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  datetime: _startFrom),
            ),
            onTap: () async {
              TimeOfDay startTime = TimeOfDay.fromDateTime(_startFrom);

              final TimeOfDay? picked = await showTimePicker(

                context: context,
                initialTime: startTime,

                builder: (context, child) {
                  return _clockWidget(child!);
                },
              );

              if (picked != null) {
                setState(() {
                  _startFrom = DateTime(_startFrom.year, _startFrom.month, _startFrom.day, picked.hour, picked.minute);
                });
              }
            },
          ),

        ],
      ),
    );
  }

  /**
   * Виджет часов при отображении времени начала и конца задачи
   */
  Widget _clockWidget(Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          // change the border color
          primary: Colors.red,
          // change the text color
          onSurface: Colors.purple,
        ),
        // button colors
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.green,
          ),
        ),
      ),
      child: child,
    );
  }

  /**
   * Конец задачи
   */
  Widget _endTime() {
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

          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: DigitalClock(
                  showSeconds: false,
                  isLive:false,
                  digitalClockTextColor: Colors.black,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  datetime: _endAt),
            ),
            onTap: () async {
              TimeOfDay endTime = TimeOfDay.fromDateTime(_endAt);

              final TimeOfDay? picked = await showTimePicker(

                context: context,
                initialTime: endTime,

                builder: (context, child) {
                  return _clockWidget(child!);
                },
              );

              if (picked != null) {
                setState(() {
                  _endAt = DateTime(_endAt.year, _endAt.month, _endAt.day, picked.hour, picked.minute);
                });
              }
            },
          ),

        ],
      ),
    );
  }

  /**
   * Описание задачи
   */
  Widget _taskDescriptionField() {
    return TextField(
      obscureText: false,
      maxLines: 1,
      decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.taskdescription),
        onChanged: (value) {
        _taskDescription = value;
        },
    );
  }

  /**
   * Кнопка для входа
   */
  Widget _confirmationButton() {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_taskDescription.isNotEmpty) {
              if (widget.id != null) {
                _updateTask(); /// редактирование
              } else {
                _addTask(); /// добавление задачи
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
            child: Text(widget.id != null ? AppLocalizations.of(context)!.updatetask : AppLocalizations.of(context)!.createtask,
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
              ),
            ),
          ),

        ),

      ),
    );
  }

  /**
   * Добавление новой задачи
   */
  void _addTask() async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateFormat format = DateFormat('HH:mm');

    /**
     * Запрос на добавление
     */
    if (!(await _repository.addTask(dateFormat.format(widget.selectedDate), format.format(_startFrom), format.format(_endAt),
        BigInt.from(_startFrom.millisecondsSinceEpoch), BigInt.from(_endAt.millisecondsSinceEpoch),
        TaskState.newTask.toString(), _taskDescription))) {
      /**
       * Что-то не так с API, отображаем ошибку и предложение попробовать еще раз
       */
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
     * Операция успешная, можно переводить юзера на основной экран
     */
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const HomePage(),
      ),
    );
  }

  /**
   * Обновление задачи
   */
  void _updateTask() async {
    /**
     * Показываем лоадер что идет запрос к API
     */
    setState(() {
      _nowLoading = true;
    });

    DateFormat format = DateFormat('HH:mm');

    /**
     * Запрос к серверу на обновление
     */
    if (!(await _repository.updateTask(widget.id!,
        format.format(_startFrom), format.format(_endAt),
        BigInt.from(_startFrom.millisecondsSinceEpoch), BigInt.from(_endAt.millisecondsSinceEpoch),
        _taskDescription))) {
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
     * Запрос успешен, можно переводить юзера на основной экран
     */
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const HomePage(),
      ),
    );
  }
}