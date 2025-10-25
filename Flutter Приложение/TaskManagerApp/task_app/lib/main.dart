import 'package:flutter/material.dart';
import 'package:task_presentation/ui/nowloading.dart';
import 'package:flutter/services.dart';
import 'package:task_resources/gen/colors.gen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:task_resources/l10n/app_localizations.dart';

// DI
import 'package:task_data/di/module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized

  /**
   * Лочим ориентацию в портретной
   */
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /**
   * Настройка модуля зависимостей для dependency injection
   */
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final ColorScheme appColorScheme = ColorScheme(
        brightness: Brightness.light,
        primary: ColorName.taskAppColor,
        onPrimary: ColorName.taskAppColor,
        secondary: ColorName.goldenColor,
        onSecondary: ColorName.goldenColor,
        tertiary: Colors.pink,
        onTertiary: Colors.pink,
        error: ColorName.nisekoiRedColor,
        onError: ColorName.nisekoiRedColor,
        surface: ColorName.goldenColor,
        onSurface: ColorName.goldenColor,
    );

    return MaterialApp(
      title: 'Task Manager App',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      /**
       * Fallback на случай если на девайсе стоит язык не EN и не RU, в таком случае юзаем англ. локаль
       */
      localeListResolutionCallback: (locales, supportedLocales) {

        if (locales != null) {
          for (Locale locale in locales) {
            // if device language is supported by the app,
            // just return it to set it as current app language

            if (<String>['en', 'ru'].contains(locale.languageCode)) {
              return locale;
            }
          }
        }

        return Locale('en');
      },
      supportedLocales: [
        Locale('en'), // English
        Locale('ru'), // Russian
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: appColorScheme,
      ),
      home: const NowLoadingPage(),
    );
  }
}
