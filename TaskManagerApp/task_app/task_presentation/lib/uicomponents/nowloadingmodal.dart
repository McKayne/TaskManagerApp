import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:task_resources/gen/colors.gen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * Полноэкранный лоадер отображаемый при запросах (к БД или API)
 */
class NowLoadingModal extends StatelessWidget {

  const NowLoadingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /**
           * Полноэкранная картинка в качестве фона на всю страницу
           */
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ColoredBox(
              color: Colors.black.withOpacity(0.65), // The color to fill the box
            ),
          ),

          /**
           * Анимированный лоадер
           */
          Center(
            child: SpinKitFadingCircle(
              color: ColorName.goldenColor,
              size: 150.0,
            ),
          )
        ],
    );
  }
}