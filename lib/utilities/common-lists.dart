import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/enums.dart';

List<DropdownMenuItem<int>> gameTime = [
  DropdownMenuItem(
    child: Text(
      '15 min',
      style: TextStyle(
          fontFamily: FontFamily.BaiJamjureeMedium,
          fontSize: 16,
          color: Colors.white),
    ),
    value: SessionTime.min15.value,
  ),
  DropdownMenuItem(
    child: Text(
      '30 min',
      style: TextStyle(
          fontFamily: FontFamily.BaiJamjureeMedium,
          fontSize: 16,
          color: Colors.white),
    ),
    value: SessionTime.min30.value,
  ),
  DropdownMenuItem(
    child: Text(
      '45 min',
      style: TextStyle(
          fontFamily: FontFamily.BaiJamjureeMedium,
          fontSize: 16,
          color: Colors.white),
    ),
    value: SessionTime.min45.value,
  ),
  DropdownMenuItem(
    child: Text(
      '1 hour',
      style: TextStyle(
          fontFamily: FontFamily.BaiJamjureeMedium,
          fontSize: 16,
          color: Colors.white),
    ),
    value: SessionTime.min60.value,
  ),
];
