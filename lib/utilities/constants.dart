import 'package:flutter/material.dart';

const String apiUrl = 'http://172.20.10.2:3333/api/';

const kPrimaryColor = Color(0xFF0C5774);
const kPrimaryButtonColor = Color(0xFFAC3A4B);
const dropDownBorderColor = Color(0xFFFFFFFF);
const uploadeImageColor = Color(0xFF3F9925);

const inputBorderWidth = 1.0;
const inputFieldHeight = 50.0;
const int errorCode = 999;

class FontFamily {
  static const BaiJamjureeBold = 'BaiJamjuree-Bold';
  static const BaiJamjureeSemiBold = 'BaiJamjuree-SemiBold';
  static const BaiJamjureeMedium = 'BaiJamjuree-Medium';
}

class SharedKeys {
  static const token = 'token';
  static const user = 'user';
  static const fcmToken = 'fcmToken';
  static const sessionTime = 'sessionTime';
}

class PageRoutes {
  static const splashScreen = 'splashScreen';
  static const homeScreen = 'homeScreen';
  static const loginScreen = 'loginScreen';
  static const setupScreen = 'setupScreen';
}
