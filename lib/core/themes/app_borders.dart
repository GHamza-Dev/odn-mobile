import 'package:flutter/material.dart';

class AppBorders {
  static OutlineInputBorder border({bool? allWhite = false}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: allWhite! ? Colors.white : Colors.black.withOpacity(.2),
      width: 1,
    ),
  );

  static OutlineInputBorder enabled({bool? allWhite = false}) =>
      border(allWhite: allWhite);

  static OutlineInputBorder focused({bool? allWhite = false}) =>
      border(allWhite: allWhite);
}
