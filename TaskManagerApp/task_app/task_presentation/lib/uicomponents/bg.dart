import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_resources/gen/assets.gen.dart';

/**
 * Полноэкранная картинка в качестве фона на всю страницу
 */
Widget background() {
  return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image(image: Assets.images.homeBg.provider(), fit: BoxFit.cover),
    );
}