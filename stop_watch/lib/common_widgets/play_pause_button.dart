import 'package:flutter/material.dart';

Widget PlayPauseButton(
  double width,
  void onPressed(),
  Icon icon,
) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
      onPressed: onPressed,
      child: icon,
      style: ElevatedButton.styleFrom(shape: CircleBorder()),
    ),
  );
}
